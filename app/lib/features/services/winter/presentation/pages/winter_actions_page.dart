import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/action_card.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/services/winter/presentation/pages/bloc/winter_actions_bloc.dart';
import 'package:app/features/services/winter/presentation/pages/bloc/winter_actions_event.dart';
import 'package:app/features/services/winter/presentation/pages/bloc/winter_actions_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

// TODO(lsaudon): Page temporaire pour avoir les actions winter, voir avec le back comment faire pour le moment c'est une liste de code, non suffisant
class WinterActionsPage extends StatelessWidget {
  const WinterActionsPage({super.key});

  static const name = 'winter-actions';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const WinterActionsPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => WinterActionsBloc(context.read())..add(const WinterActionsLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => RootPage(
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        const Text('Actions', style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s3w),
        BlocBuilder<WinterActionsBloc, WinterActionsState>(builder: (final context, final state) => _Success(state: state)),
      ],
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final WinterActionsState state;

  @override
  Widget build(final BuildContext context) {
    final actions = state.actions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (actions.isEmpty) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          FnvSvg.asset(AssetImages.bibliothequeEmpty),
          const SizedBox(height: DsfrSpacings.s3w),
          const Center(
            child: Text(Localisation.aucuneActionTrouvee, style: DsfrTextStyle.headline4(color: DsfrColors.grey50)),
          ),
        ] else ...[
          Text(Localisation.nombreAction(actions.length), style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s2w),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (final context, final index) => ActionCard(action: actions[index]),
            separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s2w),
            itemCount: actions.length,
          ),
        ],
        const SafeArea(child: SizedBox(height: paddingVerticalPage)),
      ],
    );
  }
}
