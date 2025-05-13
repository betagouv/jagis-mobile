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
  const MesAidesRenoWidget({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => MesAidesRenoBloc(context.read())..add(const MesAidesRenoIframeUrlRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocConsumer<MesAidesRenoBloc, MesAidesRenoState>(
    builder:
        (final context, final state) => switch (state.status) {
          MesAidesRenoStateStatus.initial => const SizedBox.shrink(),
          MesAidesRenoStateStatus.loading => const Center(child: CircularProgressIndicator()),
          MesAidesRenoStateStatus.getIframeUrlSuccess => _Success(state.iframeUrl!),
          MesAidesRenoStateStatus.sendSituationSuccess => const Center(child: Text('Votre situation a bien été envoyée')),
          MesAidesRenoStateStatus.failure => Center(child: Text(state.errorMessage ?? 'Erreur inconnue')),
        },
    listener: (final context, final state) {
      if (state.status == MesAidesRenoStateStatus.sendSituationSuccess) {
        context.read<ActionBloc>().add(
          ActionMarkAsDone(id: ActionSimulatorId.mesAidesReno.apiString, type: ActionType.simulator),
        );
      }
    },
  );
}

class _Success extends StatefulWidget {
  const _Success(this.iframeUrl);

  final String iframeUrl;

  @override
  State<_Success> createState() => _MesAidesRenoWidgetState();
}

class _MesAidesRenoWidgetState extends State<_Success> {
  double _webViewHeight = 700;

  @override
  Widget build(final BuildContext context) {
    final url = WebUri(widget.iframeUrl).replace(host: 'reno-git-fork-emilerolley-master-mesaidesreno.vercel.app');
    print('MesAidesRenoWidget: ${url.host}');
    return SizedBox(
      height: _webViewHeight,
      child: InAppWebView(
        initialSettings: InAppWebViewSettings(isInspectable: kDebugMode, iframeAllow: 'clipboard-read; clipboard-write'),
        initialUrlRequest: URLRequest(url: WebUri.uri(url)),
        onLoadStop: (final controller, final url) async {
          await controller.evaluateJavascript(source: _injectEventListeners);
        },
        onWebViewCreated: (final controller) {
          controller.addJavaScriptHandler(
            handlerName: 'mesAidesRenoHandler',
            callback: (final args) async {
              final data = args.first as Map<String, dynamic>;

              switch (data['kind']) {
                case 'mesaidesreno-resize-height':
                  {
                    setState(() {
                      _webViewHeight = double.parse(data['value'].toString());
                    });
                    break;
                  }
                case 'mesaidesreno-eligibility-done':
                  {
                    // situation.forEach((key, value) => print("$key: ${value.runtimeType.toString()}"));
                    context.read<MesAidesRenoBloc>().add(MesAidesRenoSendSituation(data));
                    break;
                  }
              }
            },
          );
        },
      ),
    );
  }
}

const _injectEventListeners = '''
  if (!window.flutterMessageListenerAttached) {
    window.flutterMessageListenerAttached = true;

    window.addEventListener("message", (event) => {
      window.flutter_inappwebview.callHandler("mesAidesRenoHandler", event.data);
    }, false);
  }
''';
