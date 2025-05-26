import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecommendationWidget extends StatefulWidget {
  const RecommendationWidget({super.key, required this.id, required this.imageUrl, required this.titre, this.onPop});

  final String id;
  final String? imageUrl;
  final String titre;
  final VoidCallback? onPop;

  @override
  State<RecommendationWidget> createState() => _RecommendationWidgetState();
}

class _RecommendationWidgetState extends State<RecommendationWidget> with MaterialStateMixin<RecommendationWidget> {
  @override
  Widget build(final BuildContext context) {
    const width = 203.0;

    return FnvCard(
      onTap: () async {
        await GoRouter.of(context).pushNamed(
          ArticlePage.name,
          pathParameters: ArticlePage.pathParameters(title: widget.titre, id: widget.id),
        );
        widget.onPop?.call();
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageUrl == null)
              const SizedBox(width: width, height: width * 0.6)
            else
              FnvImage.network(widget.imageUrl!, width: width, height: width * 0.6, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Text(widget.titre, style: const DsfrTextStyle.bodyMdBold()),
            ),
          ],
        ),
      ),
    );
  }
}
