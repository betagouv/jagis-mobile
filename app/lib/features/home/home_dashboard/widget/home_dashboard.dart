import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_event.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            HomeDashboardBloc(actionRepository: context.read(), environmentalPerformanceSummaryRepository: context.read())
              ..add(const HomeDashboardLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<HomeDashboardBloc, HomeDashboardState>(
    builder:
        (final context, final state) => switch (state) {
          HomeDashboardInitial() ||
          HomeDashboardLoadInProgress() => const _Success(nbActionsDone: 0, bilanCarbonePercentageCompletion: 0),
          HomeDashboardLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
          HomeDashboardLoadSuccess(:final nbActionsDone, :final bilanCarbonePercentageCompletion) => _AnimatedSuccess(
            nbActionsDone: nbActionsDone,
            bilanCarbonePercentageCompletion: bilanCarbonePercentageCompletion,
          ),
        },
  );
}

// Animated success class wich display the number of actions done and the percentage of the environmental performance completion from 0 to the provided values once the data is loaded.
class _AnimatedSuccess extends StatefulWidget {
  const _AnimatedSuccess({required this.nbActionsDone, required this.bilanCarbonePercentageCompletion});

  final int nbActionsDone;
  final int bilanCarbonePercentageCompletion;

  @override
  State createState() => _AnimatedSuccessState();
}

class _AnimatedSuccessState extends State<_AnimatedSuccess> {
  late int nbActionsDone;
  late int bilanCarbonePercentageCompletion;

  @override
  void initState() {
    super.initState();
    nbActionsDone = widget.nbActionsDone;
    bilanCarbonePercentageCompletion = widget.bilanCarbonePercentageCompletion;
  }

  // increment the values from 0 to the provided values in 1 second.
  var currentNbActionsDone = 0;
  var currentBilanCarbonePercentageCompletion = 0;
  var delay = 150;

  @override
  Widget build(final BuildContext context) {
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: delay));
      setState(() {
        if (delay > 10) {
          delay = delay - 5;
        }
        if (currentNbActionsDone < nbActionsDone) {
          currentNbActionsDone++;
        }
        if (currentBilanCarbonePercentageCompletion < bilanCarbonePercentageCompletion) {
          currentBilanCarbonePercentageCompletion++;
        }
      });
      return currentNbActionsDone < nbActionsDone || currentBilanCarbonePercentageCompletion < bilanCarbonePercentageCompletion;
    });

    return _Success(
      nbActionsDone: currentNbActionsDone,
      bilanCarbonePercentageCompletion: currentBilanCarbonePercentageCompletion,
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.nbActionsDone, required this.bilanCarbonePercentageCompletion});

  final int nbActionsDone;
  final int bilanCarbonePercentageCompletion;

  @override
  Widget build(final BuildContext context) {
    const progressSize = 88.00;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: DsfrColors.grey850,
        image: DecorationImage(image: AssetImage('assets/images/home_dashboard_bg.png'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s4w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: DsfrSpacings.s1w,
                children: [
                  // FIXME: tweaks to align the text, maybe there is a clever way to do it or at least we could factorized this.
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Center(
                        child: SizedBox(
                          height: progressSize,
                          width: progressSize,
                          child: CircularProgressIndicator(
                            value: 100,
                            backgroundColor: Color.fromARGB(0, 0, 0, 0),
                            strokeWidth: 0,
                            strokeCap: StrokeCap.round,
                            valueColor: AlwaysStoppedAnimation(Color.fromARGB(0, 0, 0, 0)),
                          ),
                        ),
                      ),
                      Center(child: Text(nbActionsDone.toString(), style: const DsfrTextStyle(fontSize: 37))),
                    ],
                  ),
                  Text(nbActionsDone > 1 ? 'Actions terminées' : 'Action terminée', style: const DsfrTextStyle(fontSize: 13)),
                ],
              ),
            ),
            const DsfrDivider(width: 1, height: 100),
            Expanded(
              child: Column(
                spacing: DsfrSpacings.s1w,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: progressSize,
                          width: progressSize,
                          child: CircularProgressIndicator(
                            value: bilanCarbonePercentageCompletion / 100,
                            backgroundColor: const Color(0xFFE7E3DC),
                            strokeWidth: 4,
                            strokeCap: StrokeCap.round,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFA89F8E)),
                          ),
                        ),
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: bilanCarbonePercentageCompletion.toString(),
                            children: const [TextSpan(text: '%', style: DsfrTextStyle(fontSize: 12))],
                          ),
                          style: const DsfrTextStyle(fontSize: 37),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(Localisation.bilanEnvironnemental, style: DsfrTextStyle(fontSize: 13)),
                      DsfrLink.sm(
                        label: bilanCarbonePercentageCompletion == 100 ? 'Voir' : 'Compléter',
                        icon: DsfrIcons.systemArrowRightLine,
                        iconPosition: DsfrLinkIconPosition.end,
                        onTap: () => GoRouter.of(context).pushReplacementNamed(EnvironmentalPerformanceSummaryPage.name),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
