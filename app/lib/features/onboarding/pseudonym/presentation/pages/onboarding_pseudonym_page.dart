import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_bloc.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_event.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_state.dart';
import 'package:app/features/onboarding/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/onboarding/widgets/onboarding_illustration.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class OnboardingPseudonymPage extends StatelessWidget {
  const OnboardingPseudonymPage({super.key});

  static const name = 'question-pseudonym';
  static const path = name;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const OnboardingPseudonymPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        OnboardingPseudonymBloc(context.read(), context.read<UserBloc>().state.user?.isUserFranceConnect ?? false),
    child: const _Content(),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) {
    final isUserFranceConnect = context.select<OnboardingPseudonymBloc, bool>((final bloc) => bloc.state.isUserFranceConnect);

    return BlocListener<OnboardingPseudonymBloc, OnboardingPseudonymState>(
      listener: (final context, final state) async {
        if (state.isSuccess) {
          await GoRouter.of(context).pushNamed(QuestionCodePostalPage.name);
        }
      },
      child: FnvScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: FnvColors.background,
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
            const Align(
              alignment: Alignment.centerLeft,
              child: OnboardingIllustration(assetName: AssetImages.illustration1),
            ),
            const Text(Localisation.bienvenueSur, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(Localisation.bienvenueSurDetails, style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50)),
            const SizedBox(height: DsfrSpacings.s3w),
            DsfrInput(
              label: Localisation.monPseudonyme,
              hintText: Localisation.monPseudonymeIndice,
              onChanged: (final value) {
                context.read<OnboardingPseudonymBloc>().add(OnboardingPseudonymChanged(value));
              },
              onFieldSubmitted: (final value) {
                context.read<OnboardingPseudonymBloc>().add(const OnboardingPseudonymSubmitted());
              },
              autofocus: true,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: isUserFranceConnect ? TextInputAction.done : TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(21)],
            ),
            BlocSelector<OnboardingPseudonymBloc, OnboardingPseudonymState, String?>(
              selector: (final state) => state.errorMessage,
              builder: (final context, final errorMessage) {
                if (errorMessage == null) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    const SizedBox(height: DsfrSpacings.s2w),
                    FnvAlert.error(label: errorMessage),
                  ],
                );
              },
            ),
            if (!isUserFranceConnect) ...[
              const SizedBox(height: DsfrSpacings.s2w),
              FnvDateOnlyInput(
                label: Localisation.maDateDeNaissance,
                hint: Localisation.dateDeNaissanceDescription,
                maxYear: context.read<Clock>().now().year,
                initialValue: null,
                onChanged: (final value) {
                  context.read<OnboardingPseudonymBloc>().add(OnboardingBirthdateChanged(value));
                },
              ),
            ],
          ],
        ),
        bottomNavigationBar: BlocSelector<OnboardingPseudonymBloc, OnboardingPseudonymState, bool>(
          selector: (final state) => state.isValid,
          builder: (final context, final isValid) => FnvBottomBar(
            child: DsfrButton(
              label: Localisation.continuer,
              variant: DsfrButtonVariant.primary,
              size: DsfrComponentSize.lg,
              onPressed: isValid ? () => context.read<OnboardingPseudonymBloc>().add(const OnboardingPseudonymSubmitted()) : null,
            ),
          ),
        ),
      ),
    );
  }
}
