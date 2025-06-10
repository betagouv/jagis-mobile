import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class LibraryContent extends StatefulWidget {
  const LibraryContent({super.key, required this.content});

  final Recommandation content;

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> with MaterialStateMixin<LibraryContent> {
  @override
  Widget build(final BuildContext context) {
    final sousTitre = widget.content.sousTitre;

    final contenu = widget.content;

    return DsfrFocusWidget(
      isFocused: isFocused,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: FnvShadows.card),
        child: Material(
          color: FnvColors.transparent,
          child: InkWell(
            onTap: () async {
              await GoRouter.of(context).pushNamed(
                ArticlePage.name,
                pathParameters: ArticlePage.pathParameters(title: contenu.titre, id: contenu.id),
              );
            },
            onHighlightChanged: updateMaterialState(WidgetState.pressed),
            onHover: updateMaterialState(WidgetState.hovered),
            focusColor: FnvColors.transparent,
            onFocusChange: updateMaterialState(WidgetState.focused),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (contenu.imageUrl == null) const Placeholder() else FnvImage.network(contenu.imageUrl!, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(DsfrSpacings.s2w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: DsfrSpacings.s1w,
                    children: [
                      Text(contenu.thematique.displayName, style: const DsfrTextStyle.bodyXsBold(color: DsfrColors.grey50)),
                      Text(contenu.titre, style: const DsfrTextStyle.headline4(color: DsfrColors.blueFranceSun113)),
                      if (sousTitre != null) Text(sousTitre, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
