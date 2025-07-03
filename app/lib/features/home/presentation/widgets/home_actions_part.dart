import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_horizontal_list.dart';
import 'package:app/features/home/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class HomeActionsPart extends StatelessWidget {
  const HomeActionsPart({super.key, required this.actions});

  final List<ActionSummary> actions;

  @override
  Widget build(final BuildContext context) {
    if (actions.isEmpty) {
      return Column(
        spacing: DsfrSpacings.s1v,
        children: [
          Text(
            Localisation.actionsTermineesVide,
            style: DsfrTextStyle.headline6(color: DsfrColorDecisions.textTitleGrey(context)),
          ),
          const Text(Localisation.actionsTermineesVideDetail, style: DsfrTextStyle.bodyMd(color: DsfrColors.yellowTournesol200)),
        ],
      );
    }

    return ActionsHorizontalList(
      actions: actions,
      onPop: () => context.read<HomeDashboardBloc>().add(const HomeDashboardActionsRefreshRequested()),
    );
  }
}
