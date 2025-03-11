import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/aid_summary_card.dart';
import 'package:app/features/car_simulator/presentation/widgets/car_simulator_widget.dart';
import 'package:app/features/services/lvao/presentation/widgets/lvao_horizontal_list.dart';
import 'package:app/features/services/recipes/action/presentation/widgets/recipe_horizontal_list.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionPage extends StatelessWidget {
  const ActionPage({super.key, required this.id, required this.type});

  static const name = 'action';
  static const path = 'action/:type/:titre/:id';

  static Map<String, String> pathParameters({
    required final ActionType type,
    required final String title,
    required final String id,
  }) => {'type': actionTypeToAPIString(type), 'titre': title, 'id': id};

  final String id;
  final ActionType type;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder:
        (final context, final state) =>
            ActionPage(id: state.pathParameters['id']!, type: actionTypeFromAPIString(state.pathParameters['type']!)),
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => ActionBloc(repository: context.read())..add(ActionLoadRequested(id, type)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocBuilder<ActionBloc, ActionState>(
      builder:
          (final context, final state) => switch (state) {
            ActionInitial() || ActionLoadInProgress() => const Center(child: CircularProgressIndicator()),
            ActionLoadSuccess() => _Success(state),
            ActionLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
          },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final ActionLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final action = state.action;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
          child: _TitleWithSubTitleView(title: action.title, subTitle: action.subTitle),
        ),
        _WhySectionView(action.why),
        switch (action) {
          ActionClassic() => _ActionClassicView(action: action),
          ActionSimulator() => _ActionSimulatorView(action: action),
        },
        _ActionAidsView(aidSummaries: action.aidSummaries),
      ],
    );
  }
}

class _TitleWithSubTitleView extends StatelessWidget {
  const _TitleWithSubTitleView({required this.title, required this.subTitle});

  final String title;

  final String? subTitle;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      FnvMarkdown(data: title, p: const DsfrTextStyle(fontSize: 28)),
      if (subTitle != null) Text(subTitle!, style: const DsfrTextStyle.bodyLg()),
    ],
  );
}

class _WhySectionView extends StatelessWidget {
  const _WhySectionView(this.why);

  final String why;

  @override
  Widget build(final BuildContext context) {
    final (heading: whyFirstHeading, content: whyContent) = parseFirstHeadingInMardown(why);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: actionOmbre),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
        child: Column(
          spacing: DsfrSpacings.s1w,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                const Icon(DsfrIcons.editorFrQuoteLine, size: 32, color: DsfrColors.blueFranceSun113),
                Text(whyFirstHeading, style: const DsfrTextStyle.headline3()),
              ],
            ),
            _Markdown(data: whyContent),
          ],
        ),
      ),
    );
  }
}

class _ActionAidsView extends StatelessWidget {
  const _ActionAidsView({required this.aidSummaries});

  final List<AidSummary> aidSummaries;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const Text(Localisation.lesAidesAssociees, style: DsfrTextStyle.headline2()),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (final context, final index) => AidSummaryCard(aidSummary: aidSummaries[index]),
          separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s1w),
          itemCount: aidSummaries.length,
        ),
        const SizedBox(height: DsfrSpacings.s4w),
      ],
    ),
  );
}

class _ActionClassicView extends StatelessWidget {
  const _ActionClassicView({required this.action});

  final ActionClassic action;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: Colors.white, boxShadow: actionOmbre),
    child: Column(
      children: [
        if (action.hasLvaoService) ...[
          const SizedBox(height: DsfrSpacings.s4w),
          LvaoHorizontalList(category: action.lvaoService.category),
        ],
        if (action.hasRecipesService) ...[
          const SizedBox(height: DsfrSpacings.s4w),
          RecipeHorizontalList(category: action.recipesService.category),
        ],
        const SizedBox(height: DsfrSpacings.s4w),
        Padding(padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w), child: _Markdown(data: action.how)),
        const SizedBox(height: DsfrSpacings.s2w),
      ],
    ),
  );
}

class _ActionSimulatorView extends StatelessWidget {
  const _ActionSimulatorView({required this.action});

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => switch (action.getId()) {
    ActionSimulatorId.carSimulator => CarSimulatorWidget(alreadySeen: action.alreadySeen),
  };
}

class _Markdown extends StatelessWidget {
  const _Markdown({required this.data});

  final String data;

  @override
  Widget build(final BuildContext context) => FnvMarkdown(
    data: data,
    h1: const DsfrTextStyle(fontSize: 22),
    p: const DsfrTextStyle(fontSize: 16),
    onTapLink: (final href) async {
      if (href != null) {
        await FnvUrlLauncher.launch(href);
      }
    },
    imageBuilder: (final uri, final alt) => FnvImage.network(uri.toString(), semanticLabel: alt),
  );
}
