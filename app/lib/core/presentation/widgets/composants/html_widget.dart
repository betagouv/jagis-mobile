import 'package:app/core/infrastructure/image_viewer.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:go_router/go_router.dart';
import 'package:html/dom.dart' as dom;

class FnvHtmlWidget extends StatelessWidget {
  const FnvHtmlWidget(this.html, {super.key});

  final String html;

  /// Le CMS peut retourner des balises `<li>` avec des balises `<p>` dedans.
  /// Cela pose des problèmes de mise en forme, alors on retire les marges.
  Map<String, String>? _handlePDansLi(final dom.Element element) =>
      element.parent?.localName == 'li' && element.localName == 'p' ? {'margin': '0'} : null;

  @override
  Widget build(final BuildContext context) => SelectionArea(
    child: HtmlWidget(
      html,
      customStylesBuilder: _handlePDansLi,
      factoryBuilder: IframeFactory.new,
      onTapImage: (final imageMetadata) async {
        final sources = imageMetadata.sources;
        if (sources.isNotEmpty) {
          final element = sources.first;
          await enlargeImage(context, src: element.url, semanticLabel: imageMetadata.alt);
        }
      },
      onTapUrl: (final url) async {
        final uri = Uri.parse(url);
        if (uri.host == 'jagis.beta.gouv.fr') {
          switch (uri.path) {
            case '/vos-aides':
            case '/aides':
              await GoRouter.of(context).pushNamed(AidsPage.name);

              return true;
            case '/bilan-environnemental':
              await GoRouter.of(context).pushNamed(EnvironmentalPerformanceSummaryPage.name);

              return true;
            default:
              return false;
          }
        }

        try {
          return await FnvUrlLauncher.launch(url);
        } on PlatformException {
          return false;
        }
      },
      textStyle: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
    ),
  );
}

class IframeFactory extends WidgetFactory with WebViewFactory {}
