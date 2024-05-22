import 'package:dsfr_example/buttons_page.dart';
import 'package:dsfr_example/colors_page.dart';
import 'package:dsfr_example/fonts_page.dart';
import 'package:dsfr_example/icons_page.dart';
import 'package:dsfr_example/master_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MasterPage(
          pageItems: [
            ColorsPage.model,
            FontsPage.model,
            IconsPage.model,
            ButtonsPage.model,
          ],
        ),
      );
}
