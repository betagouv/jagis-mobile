import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_bloc.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_event.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_state.dart';
import 'package:app/features/onboarding/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/onboarding/widgets/onboarding_illustration.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class OnboardingPseudonymPage extends StatelessWidget {
  const OnboardingPseudonymPage({super.key});

  static const name = 'question-pseudonyme';
  static const path = name;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const OnboardingPseudonymPage());

  @override
  Widget build(final context) =>
      BlocProvider(create: (final context) => OnboardingPseudonymBloc(repository: context.read()), child: const _Content());
}

class _Content extends StatelessWidget {
  const _Content();

  void _handleSubmitted(final BuildContext context) {
    context.read<OnboardingPseudonymBloc>().add(const OnboardingPseudonymSubmitted());
  }

  @override
  Widget build(final context) => BlocListener<OnboardingPseudonymBloc, OnboardingPseudonymState>(
    listener: (final context, final state) async {
      if (state is OnboardingPseudonymSuccess) {
        await GoRouter.of(context).pushNamed(QuestionCodePostalPage.name);
      }
    },
    child: FnvScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: FnvColors.homeBackground,
        iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          FnvMarkdown(
            data: Localisation.questionCourantSurMax(1, 3),
            p: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          const Align(alignment: Alignment.centerLeft, child: OnboardingIllustration(assetName: AssetImages.illustration1)),
          const Text(Localisation.bienvenueSur, style: DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s2w),
          const Text(Localisation.bienvenueSurDetails, style: DsfrTextStyle.bodyLg()),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrInput(
            label: Localisation.monPseudonyme,
            onChanged: (final value) {
              context.read<OnboardingPseudonymBloc>().add(OnboardingPseudonymChanged(value));
            },
            onFieldSubmitted: (final value) => _handleSubmitted(context),
            autofocus: true,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
          ),
          BlocSelector<OnboardingPseudonymBloc, OnboardingPseudonymState, Option<String>>(
            selector:
                (final state) => switch (state) {
                  OnboardingPseudonymFailure() => Some(state.errorMessage),
                  _ => const None(),
                },
            builder:
                (final context, final state) => state.fold(
                  () => const SizedBox.shrink(),
                  (final t) => Column(children: [const SizedBox(height: DsfrSpacings.s2w), FnvAlert.error(label: t)]),
                ),
          ),
        ],
      ),
      bottomNavigationBar: BlocSelector<OnboardingPseudonymBloc, OnboardingPseudonymState, bool>(
        selector:
            (final state) => switch (state) {
              OnboardingPseudonymEntered() => state.isValid,
              OnboardingPseudonymSuccess() => true,
              _ => false,
            },
        builder:
            (final context, final state) => FnvBottomBar(
              child: DsfrButton(
                label: Localisation.continuer,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: state ? () => _handleSubmitted(context) : null,
              ),
            ),
      ),
    ),
  );
}
