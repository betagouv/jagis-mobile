import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class CheckInboxPage extends StatelessWidget {
  const CheckInboxPage({super.key, required this.email});

  static const name = 'validation-compte';
  static const path = '/$name';

  final String email;

  static GoRoute get route => GoRoute(
    path: '$path/:email',
    name: name,
    builder: (final context, final state) {
      final email = state.pathParameters['email']!;

      return CheckInboxPage(email: email);
    },
  );

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113)),
    body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
      children: [
        const SizedBox(height: DsfrSpacings.s2w),
        const Align(alignment: Alignment.centerLeft, child: FnvImage.asset(AssetImages.checkInbox, height: 108)),
        const SizedBox(height: DsfrSpacings.s1w),
        const Text(Localisation.verifiezVotreBoiteEmail, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s1w),
        FnvMarkdown(data: Localisation.verifiezVotreBoiteEmailDescription(email)),
        const SizedBox(height: DsfrSpacings.s1w),
        DsfrLink(
          label: Localisation.jePrefereRentrerLeCodeManuellement,
          icon: DsfrIcons.designEditFill,
          onTap: () async {
            await GoRouter.of(context).pushNamed(SaisieCodePage.name, queryParameters: {'email': email});
          },
        ),
        const SafeArea(child: SizedBox.shrink()),
      ],
    ),
  );
}
