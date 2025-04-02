import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  // ignore: avoid-accessing-other-classes-private-members
  static void restartApp(final BuildContext context) => context.findAncestorStateOfType<_RestartWidgetState>()?._restartApp();

  final Widget child;

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void _restartApp() => setState(() => _key = UniqueKey());

  @override
  Widget build(final BuildContext context) => KeyedSubtree(key: _key, child: widget.child);
}
