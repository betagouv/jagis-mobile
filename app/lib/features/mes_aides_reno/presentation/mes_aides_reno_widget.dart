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
  double _webViewHeight = 700;

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: _webViewHeight,
    child: InAppWebView(
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode, iframeAllow: 'clipboard-read; clipboard-write'),
      initialUrlRequest: URLRequest(url: WebUri('https://mesaidesreno.beta.gouv.fr')),
      onLoadStop: (final controller, final url) async {
        await controller.evaluateJavascript(source: _injectEventListeners);
      },
      onWebViewCreated: (final controller) {
        controller.addJavaScriptHandler(
          handlerName: 'mesAidesRenoHandler',
          callback: (final args) {
            final data = args.first as Map<String, dynamic>;

            switch (data['kind']) {
              case 'mesaidesreno-resize-height':
                {
                  setState(() {
                    _webViewHeight = double.parse(data['value'].toString()) + 20;
                  });
                  break;
                }
            }
          },
        );
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
