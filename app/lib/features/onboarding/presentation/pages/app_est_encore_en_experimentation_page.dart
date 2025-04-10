import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/onboarding/question_themes/presentation/pages/question_themes_page.dart';
import 'package:app/features/onboarding/widgets/onboarding_illustration.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class AppEstEncoreEnExperimentationPage extends StatelessWidget {
  const AppEstEncoreEnExperimentationPage({super.key, required this.commune});

  static const name = 'app-est-encore-en-experimentation';
  static const path = '$name/:commune';

  final String commune;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => AppEstEncoreEnExperimentationPage(commune: state.pathParameters['commune']!),
  );

  @override
  Widget build(final BuildContext context) {
    const bodyLg = DsfrTextStyle.bodyLg(color: DsfrColors.grey50);

    return FnvScaffold(
      appBar: AppBar(
        backgroundColor: FnvColors.background,
        iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: OnboardingIllustration(assetName: AssetImages.illustration3),
          ),
          const Text(Localisation.appEstEncoreEnExperimentation, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s2w),
          Text.rich(
            TextSpan(
              text: Localisation.appEstEncoreEnExperimentationDetails,
              children: [
                TextSpan(
                  text: Localisation.communeEtSaRegion(commune),
                  style: bodyLg.copyWith(color: DsfrColors.blueFranceSun113, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: Localisation.appEstEncoreEnExperimentationDetails2),
              ],
            ),
            style: bodyLg,
          ),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.jaiCompris,
          variant: DsfrButtonVariant.primary,
          size: DsfrComponentSize.lg,
          onPressed: () async {
            await GoRouter.of(context).pushNamed(QuestionThemesPage.name);
          },
        ),
      ),
    );
  }
}
