import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_bloc.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_event.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MesAidesRenoWidget extends StatelessWidget {
  const MesAidesRenoWidget({super.key, required this.isDone});

  final bool isDone;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => MesAidesRenoBloc(context.read())..add(const MesAidesRenoIframeUrlRequested()),
    child: _View(isDone),
  );
}

class _View extends StatelessWidget {
  const _View(this.isDone);

  final bool isDone;

  @override
  Widget build(final BuildContext context) => BlocBuilder<MesAidesRenoBloc, MesAidesRenoState>(
    builder:
        (final context, final state) => switch (state.status) {
          MesAidesRenoStateStatus.initial || MesAidesRenoStateStatus.loading => const Center(child: CircularProgressIndicator()),
          MesAidesRenoStateStatus.success => _Success(iframeUrl: state.iframeUrl!, isDone: isDone),
          MesAidesRenoStateStatus.failure => Center(child: Text(state.errorMessage ?? 'Erreur inconnue')),
        },
  );
}

class _Success extends StatefulWidget {
  const _Success({required this.iframeUrl, required this.isDone});

  final String iframeUrl;
  final bool isDone;

  @override
  State<_Success> createState() => _MesAidesRenoWidgetState();
}

class _MesAidesRenoWidgetState extends State<_Success> {
  double _webViewHeight = 700;
  InAppWebViewController? _webViewController;
  var _isAtEllibilityResult = false;

  static const mesAidesRenoHandlerName = 'mesAidesRenoHandler';

  @override
  void dispose() {
    _webViewController?.removeJavaScriptHandler(handlerName: mesAidesRenoHandlerName);
    _webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final url = WebUri(widget.iframeUrl).replace(host: 'reno-git-fork-emilerolley-master-mesaidesreno.vercel.app');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        if (widget.isDone && !_isAtEllibilityResult)
          Padding(
            padding: const EdgeInsets.only(bottom: DsfrSpacings.s4w, left: DsfrSpacings.s2w, right: DsfrSpacings.s2w),
            child: DsfrAlert(
              type: DsfrAlertType.info,
              description: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(Localisation.vousAvezDejaFaitCeSimulateur, style: DsfrTextStyle.bodyMd()),
                  DsfrLink.md(
                    label: Localisation.voirMesResultats,
                    onTap:
                        () => {
                          setState(() {
                            _isAtEllibilityResult = true;
                          }),
                          context.read<MesAidesRenoBloc>().add(const MesAidesRenoIframeUrlRequested(whenIsDone: true)),
                        },
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: _webViewHeight,
          child: InAppWebView(
            initialSettings: InAppWebViewSettings(isInspectable: kDebugMode, iframeAllow: 'clipboard-read; clipboard-write'),
            initialUrlRequest: URLRequest(url: WebUri.uri(url)),
            onLoadStop: (final controller, final url) async {
              await controller.evaluateJavascript(source: _injectEventListeners);
            },
            onWebViewCreated: (final controller) {
              _webViewController = controller;
              _webViewController?.addJavaScriptHandler(
                handlerName: mesAidesRenoHandlerName,
                callback: (final args) {
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
                        setState(() {
                          _isAtEllibilityResult = true;
                        });
                        context.read<ActionBloc>().add(
                          ActionMarkAsDone(id: ActionSimulatorId.mesAidesReno.apiString, type: ActionType.simulator),
                        );
                        context.read<MesAidesRenoBloc>().add(MesAidesRenoSendSituation(data));
                        break;
                      }
                  }
                },
              );
            },
          ),
        ),
      ],
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
