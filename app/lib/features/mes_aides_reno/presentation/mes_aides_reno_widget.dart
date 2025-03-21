import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MesAidesRenoWidget extends StatefulWidget {
  const MesAidesRenoWidget({super.key, required this.isDone});

  final bool isDone;

  @override
  State<MesAidesRenoWidget> createState() => _MesAidesRenoWidgetState();
}

class _MesAidesRenoWidgetState extends State<MesAidesRenoWidget> {
  double webViewHeight = 700;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: webViewHeight,
    child: InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('https://reno-git-fork-emilerolley-master-mesaidesreno.vercel.app?iframe=true')),
      initialSettings: InAppWebViewSettings(iframeAllow: 'clipboard-read; clipboard-write', isInspectable: kDebugMode),
      onWebViewCreated: (final controller) {
        controller.addJavaScriptHandler(
          handlerName: 'mesAidesRenoHandler',
          callback: (final args) {
            try {
              final data = args[0] as Map<String, dynamic>;
              if (data['kind'] == 'mesaidesreno-resize-height') {
                setState(() {
                  webViewHeight = double.parse(data['value'].toString()) + 20;
                });
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
