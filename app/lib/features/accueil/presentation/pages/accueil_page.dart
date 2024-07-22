import 'package:app/features/aides/presentation/widgets/mes_aides.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/univers/presentation/widgets/univers_section.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/text_styles.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  static const name = 'accueil';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AccueilPage(),
      );

  @override
  Widget build(final BuildContext context) {
    context
        .read<UtilisateurBloc>()
        .add(const UtilisateurRecuperationDemandee());

    return Builder(
      builder: (final context) {
        final state = context.watch<UtilisateurBloc>().state;

        return RootPage(
          title: const _AppBarTitle(),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w),
            children: [
              if (state.aLesUnivers) ...[
                const UniversSection(),
                const SizedBox(height: DsfrSpacings.s4w),
              ],
              if (state.aLesAides) ...[
                const MesAides(),
                const SizedBox(height: DsfrSpacings.s4w),
              ],
              if (state.aLesRecommandations) const MesRecommandations(),
            ],
          ),
        );
      },
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<UtilisateurBloc>().state;

    const font = FnvTextStyles.appBarTitleStyle;

    return Text.rich(
      TextSpan(
        text: Localisation.bonjour,
        children: [
          TextSpan(
            text: Localisation.prenomExclamation(state.prenom),
            style: font,
          ),
        ],
      ),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
