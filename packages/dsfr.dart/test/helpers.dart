import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key, required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => MaterialApp(home: Scaffold(body: Center(child: child)));
}
