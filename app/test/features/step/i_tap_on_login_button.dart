import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_scroll_down.dart';
import 'i_tap_on.dart';

/// Usage: I tap on login button
Future<void> iTapOnLoginButton(final WidgetTester tester) async {
  const user = 'user123';
  FeatureContext.instance.dioMock
    ..postM(Endpoints.magicLinkSend)
    ..postM(
      Endpoints.magicLinkLogin,
      responseData: {
        'token': "header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': user}).codeUnits)}.signature",
        'utilisateur': {'id': user},
      },
    )
    ..getM(
      Endpoints.utilisateur,
      responseData: {'is_onboarding_done': false, 'is_nom_prenom_modifiable': true, 'popup_reset_est_vue': true},
    );
  await iScrollDown(tester);
  await iTapOn(tester, Localisation.meConnecter);
}
