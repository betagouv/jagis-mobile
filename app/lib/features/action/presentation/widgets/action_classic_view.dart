import 'package:app/core/source/sources_widget.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/widgets/action_markdown.dart';
import 'package:app/features/action/presentation/widgets/action_markdown_heading.dart';
import 'package:app/features/action/presentation/widgets/action_why_section_view.dart';
import 'package:app/features/services/lvao/presentation/widgets/lvao_horizontal_list.dart';
import 'package:app/features/services/pdcn/presentation/widgets/pdcn_horizontal_list.dart';
import 'package:app/features/services/recipes/action/presentation/widgets/recipe_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionClassicView extends StatelessWidget {
  const ActionClassicView({super.key, required this.action});

  final ActionClassic action;

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ActionWhySectionView(why: action.why),
      if (action.sources.isNotEmpty) ...[
        const SizedBox(height: DsfrSpacings.s1w),
        const DsfrDivider(),
        const SizedBox(height: DsfrSpacings.s3w),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: SourcesWidget(sources: action.sources),
        ),
      ],
      if (action.hasLvaoService) ...[
        const SizedBox(height: DsfrSpacings.s4w),
        LvaoHorizontalList(category: action.lvaoService.category),
      ],
      if (action.hasMangerBougerService) ...[
        const SizedBox(height: DsfrSpacings.s4w),
        RecipeHorizontalList(category: action.mangerBougerService.category),
      ],
      if (action.hasPdcnService) ...[
        const SizedBox(height: DsfrSpacings.s4w),
        PdcnHorizontalList(category: action.pdcnService.category),
      ],
      const SizedBox(height: DsfrSpacings.s4w),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: ActionMarkdown(
          data: action.how,
          hTag: ActionMarkdownHeading(icon: DsfrIcons.othersLeafLine, iconColor: const Color(0xFF39826C)),
        ),
      ),
      const SizedBox(height: DsfrSpacings.s2w),
    ],
  );
}
