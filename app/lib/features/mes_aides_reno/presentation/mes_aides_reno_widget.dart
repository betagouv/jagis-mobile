import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_bloc.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_event.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MesAidesRenoWidget extends StatelessWidget {
  const MesAidesRenoWidget({super.key, required this.isDone});

  final bool isDone;

  @override
  Widget build(final BuildContext context) =>
      BlocProvider(create: (final context) => MesAidesRenoBloc(), child: _MesAidesRenoWidget(isDone: isDone));
}

class _MesAidesRenoWidget extends StatefulWidget {
  const _MesAidesRenoWidget({required this.isDone});

  final bool isDone;

  @override
  State<_MesAidesRenoWidget> createState() => _MesAidesRenoWidgetState();
}

class _MesAidesRenoWidgetState extends State<_MesAidesRenoWidget> {
  _MesAidesRenoWidgetState();

  double webViewHeight = 700;

  @override
  Widget build(final BuildContext context) => BlocListener<MesAidesRenoBloc, MesAidesRenoState>(
    listener: (final context, final state) {
      if (state is MesAidesRenoActionDone) {
        context.read<ActionBloc>().add(
          ActionMarkAsDone(id: actionSimulatorIdToAPIString(ActionSimulatorId.mesAidesReno), type: ActionType.simulator),
        );
      }
    },
    child: SizedBox(
      height: webViewHeight,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
            'https://reno-git-fork-emilerolley-master-mesaidesreno.vercel.app/simulation?iframe=true&logement.EPCI="243100518"&logement.commune="31555"&logement.commune.nom="Toulouse"&vous.propriétaire.statut="non+propriétaire"*&logement.surface=10*&logement.période+de+construction="de+2+à+10+ans"*&DPE.actuel=1*&taxe+foncière.commune.éligible.logement=non&logement.commune.denormandie=non',
          ),
        ),
        initialSettings: InAppWebViewSettings(iframeAllow: 'clipboard-read; clipboard-write', isInspectable: kDebugMode),
        onWebViewCreated: (final controller) {
          controller.addJavaScriptHandler(
            handlerName: 'mesAidesRenoHandler',
            callback: (final args) {
              try {
                final data = args[0] as Map<String, dynamic>;

                switch (data['kind']) {
                  case 'mesaidesreno-resize-height':
                    {
                      setState(() {
                        webViewHeight = double.parse(data['value'].toString()) + 20;
                      });
                      break;
                    }
                  case 'mesaidesreno-simulation-done':
                    {
                      context.read<MesAidesRenoBloc>().add(const MesAidesRenoMarkAsDone());
                      break;
                    }
                }
              } on Exception catch (e) {
                throw Exception('Erreur de décodage du message: $e');
              }
              return null;
            },
          );
        },
        onLoadStop: (final controller, final url) async {
          await controller.evaluateJavascript(source: _injectEventListeners);
        },
        // read search params when url changed to get answered questions
        onUpdateVisitedHistory: (final controller, final uri, final androidIsReload) async {
          print('uri: ${uri?.path}');
          print('parameters: ${uri?.queryParametersAll}');
        },
        onConsoleMessage: (final controller, final consoleMessage) {},
      ),
    ),
  );
}

const _injectEventListeners = '''
  if (!window.flutterMessageListenerAttached) {
    window.flutterMessageListenerAttached = true;

    window.addEventListener("message", (event) => {
      window.flutter_inappwebview.callHandler("mesAidesRenoHandler", event.data);
    }, false);
  }
''';
