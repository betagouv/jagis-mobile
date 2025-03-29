import 'package:app/core/helpers/input_formatter.dart';
import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../features/step/i_enter_in_the_field.dart';
import '../features/step/i_select_date_in_the_field.dart';
import '../features/step/i_tap_on.dart';
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';
import 'steps/iel_voit_le_texte_markdown.dart';
import 'steps/scenario_context.dart';
import 'steps/set_up_widgets.dart';

void main() {
  testWidgets('Voir tous les textes', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMesInformations(tester);
    ielVoitLeTexte(Localisation.mesInformations);
    ielVoitLeTexte(Localisation.monIdentite);
    ielVoitLeTexte(Localisation.pseudonyme);
    ielVoitLeTexte(Localisation.prenom);
    ielVoitLeTexte(Localisation.nom);
    ielVoitLeTexte(Localisation.nom);
    await ielScrolle(tester, Localisation.donneesPersonnelles);
    ielVoitLeTexte(Localisation.donneesPersonnelles);
    ielVoitLeTexte(Localisation.nombreDePartsFiscales);
    ielVoitLeTexte(Localisation.nombreDePartsFiscalesDescription);
    ielVoitLeTexte(Localisation.revenuFiscal);
    ielVoitLeTexteMarkdown(tester, Localisation.pourquoiCesQuestionsReponse);
    ielVoitLeTexte(Localisation.mettreAJourMesInformations);
  });

  testWidgets('Iel voit les informations prérempli', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMesInformations(tester);
    ielVoitLeTexte('Dupont');
    ielVoitLeTexte('Michel');
    ielVoitLeTexteDansTexteRiche('michel@dupont.fr');
    await ielScrolle(tester, Localisation.revenuFiscal);
    ielVoitLeTexte(FnvNumberFormat.formatNumber(1.5));
    ielVoitLeTexte(formatCurrency(16000));
  });

  testWidgets('Iel rempli ces informations et appuie sur mettre à jour', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMesInformations(tester);
    ScenarioContext().dioMock!.patchM(Endpoints.profile);
    await iEnterInTheField(tester, 'Nouveau pseudo', Localisation.pseudonyme);
    await iEnterInTheField(tester, 'Nouveau prenom', Localisation.prenom);
    await iEnterInTheField(tester, 'Nouveau nom', Localisation.nom);
    final year = ScenarioContext().clock!.now().year - 18;
    await iSelectDateInTheField(tester, '15/01/$year', Localisation.dateDeNaissance);
    await ielScrolle(tester, Localisation.revenuFiscal);
    await iEnterInTheField(tester, 2.5.toString(), Localisation.nombreDePartsFiscales);
    await iEnterInTheField(tester, 35000.toString(), Localisation.revenuFiscal);

    await iTapOn(tester, Localisation.mettreAJourMesInformations);

    verify(
      () => ScenarioContext().dioMock!.patch<dynamic>(
        Endpoints.profile,
        data: {
          'pseudo': 'Nouveau pseudo',
          'prenom': 'Nouveau prenom',
          'nom': 'Nouveau nom',
          'annee_naissance': year,
          'mois_naissance': 1,
          'jour_naissance': 15,
          'nombre_de_parts_fiscales': 2.5,
          'revenu_fiscal': 35000,
        },
      ),
    );
  });
}

Future<void> _allerSurMesInformations(final WidgetTester tester) async {
  ielACesInformationsDeProfil(
    email: 'michel@dupont.fr',
    prenom: 'Michel',
    nom: 'Dupont',
    codePostal: '75018',
    commune: 'Paris',
    nombreDePartsFiscales: 1.5,
    revenuFiscal: 16000,
  );
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await iTapOn(tester, Localisation.monProfil);
  await iTapOn(tester, Localisation.mesInformations);
}
