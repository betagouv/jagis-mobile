import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/features/my_answers/detail/presentation/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/my_answers/list/presentation/bloc/my_answers_bloc.dart';
import 'package:app/features/my_answers/list/presentation/bloc/my_answers_event.dart';
import 'package:app/features/my_answers/list/presentation/bloc/my_answers_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class MyAnswersPage extends StatelessWidget {
  const MyAnswersPage({super.key});

  static const name = 'mes-reponses';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const MyAnswersPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => MyAnswersBloc(repository: context.read())..add(const MyAnswersStarted()),
    child: Builder(
      builder: (final context) => FnvScaffold(
        appBar: FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: FnvTitle(title: Localisation.mesReponses),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            BlocBuilder<MyAnswersBloc, MyAnswersState>(
              builder: (final context, final state) => switch (state) {
                MyAnswersInitial() => const SizedBox.shrink(),
                MyAnswersLoading() => const Center(child: CircularProgressIndicator()),
                MyAnswersSuccess() => _Success(state),
                MyAnswersFailure() => FnvFailureWidget(
                  onPressed: () => context.read<MyAnswersBloc>().add(const MyAnswersStarted()),
                ),
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final MyAnswersSuccess state;

  @override
  Widget build(final BuildContext context) {
    final questions = state.questionsFiltered;
    final themeSelected = state.themeSelected;
    const padding = EdgeInsets.symmetric(horizontal: paddingVerticalPage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: padding,
          child: Text(Localisation.lesCategories, style: DsfrTextStyle.headline4(color: DsfrColors.grey50)),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Padding(
          padding: padding,
          child: Wrap(
            spacing: DsfrSpacings.s1w,
            runSpacing: DsfrSpacings.s1w,
            children: [null, ...ThemeType.values]
                .map((final e) => _Tag(thematique: e, isSelected: themeSelected.fold(() => e == null, (final s) => s == e)))
                .toList(),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (final context, final index) => _Item(questions[index]),
          separatorBuilder: (final context, final index) => const DsfrDivider(),
          itemCount: questions.length,
        ),
        const SafeArea(child: SizedBox.shrink()),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.thematique, required this.isSelected});

  final ThemeType? thematique;
  final bool isSelected;

  @override
  Widget build(final BuildContext context) {
    const blue = DsfrColors.blueFranceSun113;

    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s4w));

    return Material(
      color: FnvColors.transparent,
      child: InkWell(
        onTap: () =>
            context.read<MyAnswersBloc>().add(MyAnswersThemePressed(thematique == null ? const None() : Some(thematique!))),
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? blue : null,
            border: const Border.fromBorderSide(BorderSide(color: blue)),
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              thematique?.displayName ?? Localisation.tout,
              style: DsfrTextStyle.bodySmMedium(color: isSelected ? Colors.white : blue),
              semanticsLabel: thematique?.displayNameWithoutEmoji,
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.question);

  final Question question;

  @override
  Widget build(final BuildContext context) => ListItem(
    title: question.label,
    subTitle: question.responsesDisplay(),
    onTap: () async {
      final result = await GoRouter.of(
        context,
      ).pushNamed<bool>(MieuxVousConnaitreEditPage.name, pathParameters: {'id': question.code.value});

      if (result != true || !context.mounted) {
        return;
      }

      context.read<MyAnswersBloc>().add(const MyAnswersRefreshNeed());
    },
  );
}
