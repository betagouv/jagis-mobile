import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/profil/supprimer_compte/presentation/widgets/supprimer_compte.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class OptionsAvanceesPage extends StatelessWidget {
  const OptionsAvanceesPage({super.key});

  static const name = 'options-avancees';
  static const path = name;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const OptionsAvanceesPage());

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: const SingleChildScrollView(
      primary: true,
      child: Padding(
        padding: EdgeInsets.all(paddingVerticalPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s3w,
          children: [
            FnvTitle(title: Localisation.optionsAvancees),
            SupprimerCompte(),
          ],
        ),
      ),
    ),
  );
}
