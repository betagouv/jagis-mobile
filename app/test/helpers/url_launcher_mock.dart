import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class UrlLauncherMock extends Mock with MockPlatformInterfaceMixin implements UrlLauncherPlatform {}
