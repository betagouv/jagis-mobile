import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../features/step/i_enter_in_the_field.dart';
import '../features/step/i_tap_on.dart' show iTapOn;
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_appuie_sur_la_liste_deroulante.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_bouton_radio_avec_ce_texte_selectionne.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';
import 'steps/scenario_context.dart';
import 'steps/set_up_widgets.dart';

const _codePostal = '39100';
const _commune = 'DOLE';
const _nombreAdultes = 2;
const _nombreEnfants = 1;

void main() {
  testWidgets('Voir tous les textes', (final tester) async {
    setUpWidgets(tester);
    leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune]);
    await _allerSurMonLogement(tester);
    ielVoitLeTexte(Localisation.monLogement);
    ielVoitLeTexte(Localisation.codePostal);
    ielVoitLeTexte(Localisation.commune);
    ielVoitLeTexte(Localisation.combienEtesVousDansVotreLogement);
    ielVoitLeTexte(Localisation.adultes);
    ielVoitLeTexte(Localisation.enfants);
    ielVoitLeTexte(Localisation.maResidencePrincipaleEst);
    ielVoitLeTexte(Localisation.unAppartement);
    ielVoitLeTexte(Localisation.uneMaison);
    await ielScrolle(tester, Localisation.vousEtesProprietaireDeVotreLogement);
    ielVoitLeTexte(Localisation.vousEtesProprietaireDeVotreLogement);
    ielVoitLeTexte(Localisation.oui, n: 2);
    ielVoitLeTexte(Localisation.non, n: 2);
    ielVoitLeTexte(Localisation.quelleEstLaSuperficie);
    ielVoitLeTexte(Localisation.moinsDe35m2);
    ielVoitLeTexte(Localisation.entre35et70m2);
    ielVoitLeTexte(Localisation.entre70et100m2);
    ielVoitLeTexte(Localisation.entre100et150m2);
    ielVoitLeTexte(Localisation.plusDe150m2);
    await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
    ielVoitLeTexte(Localisation.monLogementPlusDe15Ans);
    ielVoitLeTexte(Localisation.consommationsEnergetiques);
    ielVoitLeTexte(Localisation.dpeA);
    ielVoitLeTexte(Localisation.dpeB);
    ielVoitLeTexte(Localisation.dpeC);
    ielVoitLeTexte(Localisation.dpeD);
    ielVoitLeTexte(Localisation.dpeE);
    ielVoitLeTexte(Localisation.dpeF);
    ielVoitLeTexte(Localisation.dpeG);
    ielVoitLeTexte(Localisation.dpeJeNeSaisPas);
  });

  testWidgets('Iel voit les informations préremplis', (final tester) async {
    setUpWidgets(tester);
    leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune]);
    await _allerSurMonLogement(tester);
    ielVoitLeTexte(_codePostal);
    ielVoitLeTexte(_commune);
    ielVoitLeTexte(_nombreAdultes.toString());
    ielVoitLeTexte(_nombreEnfants.toString());
    await ielScrolle(tester, Localisation.maResidencePrincipaleEst);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.uneMaison);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.non);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.entre70et100m2);
    await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.non);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.dpeG);
  });

  testWidgets('Iel rempli ces informations et appuie sur mettre à jour', (final tester) async {
    setUpWidgets(tester);
    const codePostal = '39100';
    const commune = 'CHOISEY';
    const nombreAdultes = 1;
    const nombreEnfants = 2;
    leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune, commune]);
    ScenarioContext().dioMock!.patchM(Endpoints.logement);
    await _allerSurMonLogement(tester);
    await iEnterInTheField(tester, codePostal, Localisation.codePostal);
    await ielAppuieSurLaListeDeroulante(tester);
    await iTapOn(tester, commune);
    await iEnterInTheField(tester, nombreAdultes.toString(), Localisation.adultes);
    await iEnterInTheField(tester, nombreEnfants.toString(), Localisation.enfants);
    await ielScrolle(tester, Localisation.maResidencePrincipaleEst);
    await iTapOn(tester, Localisation.unAppartement);
    await iTapOn(tester, Localisation.oui);
    await iTapOn(tester, Localisation.moinsDe35m2);

    await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
    await iTapOn(tester, Localisation.oui);
    await ielScrolle(tester, Localisation.consommationsEnergetiques);
    await iTapOn(tester, Localisation.dpeC);

    await iTapOn(tester, Localisation.mettreAJourMesInformations);

    verify(
      () => ScenarioContext().dioMock?.patch<dynamic>(
        Endpoints.logement,
        data:
            '{"code_postal":"39100","commune":"CHOISEY","dpe":"C","nombre_adultes":1,"nombre_enfants":2,"plus_de_15_ans":true,"proprietaire":true,"superficie":"superficie_35","type":"appartement"}',
      ),
    );
  });
}

Future<void> _allerSurMonLogement(final WidgetTester tester) async {
  ielACesInformationsDeProfil(codePostal: _codePostal, commune: _commune);
  ielACesInformationsDeLogement(
    const Logement(
      codePostal: _codePostal,
      commune: _commune,
      nombreAdultes: 2,
      nombreEnfants: 1,
      typeDeLogement: TypeDeLogement.maison,
      estProprietaire: false,
      superficie: Superficie.s100,
      plusDe15Ans: false,
      dpe: Dpe.g,
    ),
  );
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await iTapOn(tester, Localisation.monProfil);
  await iTapOn(tester, Localisation.monLogement);
}
