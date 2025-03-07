import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('Voir le label', (final tester) async {
    const label = 'Label lien';
    await tester.pumpWidget(const App(child: DsfrLink.md(label: label)));
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('Appuyer', (final tester) async {
    const label = 'Label lien';
    final completer = Completer<void>();
    await tester.pumpWidget(App(child: DsfrLink.md(label: label, onTap: completer.complete)));

    await tester.tap(find.text(label));

    expect(completer.isCompleted, true);
  });

  group('Accessibilité', () {
    testWidgets('État désactivé', (final tester) async {
      final handle = tester.ensureSemantics();
      const label = 'Label lien';
      await tester.pumpWidget(const App(child: DsfrLink.md(label: label)));

      expect(tester.getSemantics(find.text(label)), containsSemantics(label: label, isLink: true, hasEnabledState: true));
      handle.dispose();
    });

    testWidgets('État activé', (final tester) async {
      final handle = tester.ensureSemantics();
      const label = 'Label lien';
      await tester.pumpWidget(App(child: DsfrLink.md(label: label, onTap: () {})));
      expect(
        tester.getSemantics(find.text(label)),
        containsSemantics(
          label: label,
          isLink: true,
          isFocusable: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      handle.dispose();
    });
  });
}
