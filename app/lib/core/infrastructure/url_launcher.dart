import 'package:url_launcher/url_launcher_string.dart';

abstract final class FnvUrlLauncher {
  static Future<bool> launch(final String urlString, {final LaunchMode mode = LaunchMode.platformDefault}) =>
      launchUrlString(urlString.trim(), mode: mode);
}
