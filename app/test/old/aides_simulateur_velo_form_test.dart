import 'package:app/core/helpers/input_formatter.dart';
import 'package:app/core/helpers/number_format.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/domain/geographical_scale.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../features/step/i_enter_in_the_field.dart';
import '../features/step/i_scroll_down.dart';
import '../features/step/i_tap_on.dart';
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_appuie_sur_texte_comportant.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';
import 'steps/set_up_widgets.dart';

void main() {
  group('Aides Simulateur vélo formulaire', () {
    const aide2 = Aid(
      id: '2',
      themeType: ThemeType.transport,
      title: 'Acheter un vélo',
      maxAmount: 3500,
      isFree: false,
      partner: null,
      scale: GeographicalScale.country,
      content: '<p>Contenu</p>',
      simulatorUrl: '/aides/velo',
    );

    const codePostal = '39100';
    const codeInsee = '39198';
    const commune = 'DOLE';
    const nombreDePart = 2.5;
    const revenuFiscal = 16000;

    testWidgets('Iel arrive sur la page avec les informations déjà renseignées', (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        ielACesInformationsDeProfil(
          codePostal: codePostal,
          codeInsee: codeInsee,
          nombreDePartsFiscales: nombreDePart,
          revenuFiscal: revenuFiscal,
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        ielVoitLeTexteDansTexteRiche(Localisation.elementsNecessaireAuCalcul);
        ielVoitLeTexteDansTexteRiche(Localisation.donneesUtiliseesCodePostalEtCommune(codePostal: codePostal, commune: commune));
        ielVoitLeTexteDansTexteRiche(Localisation.donneesUtiliseesNombreDeParts(nombreDePart));
        ielVoitLeTexteDansTexteRiche(Localisation.donneesUtiliseesRevenuFiscal(revenuFiscal));
      });
    });

    testWidgets('Iel veut modifier ces informations, les données sont préremplis', (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        ielACesInformationsDeProfil(
          codePostal: codePostal,
          codeInsee: codeInsee,
          nombreDePartsFiscales: nombreDePart,
          revenuFiscal: revenuFiscal,
        );
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        ielVoitLeTexteDansTexteRiche(codePostal);
        ielVoitLeTexteDansTexteRiche(commune);
        ielVoitLeTexteDansTexteRiche(FnvNumberFormat.formatNumber(nombreDePart));
        ielVoitLeTexteDansTexteRiche(commune);
        ielVoitLeTexteDansTexteRiche(formatCurrency(revenuFiscal));
      });
    });

    testWidgets("Si le revenu fiscal n'est pas renseigné, le mode saisie est activé", (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        ielACesInformationsDeProfil(codePostal: codePostal, codeInsee: codeInsee, nombreDePartsFiscales: nombreDePart);
        await _allerSurLeSimulateurVelo(tester, aide2);
        await iScrollDown(tester);
        ielVoitLeTexteDansTexteRiche(Localisation.aideVeloAvertissement);
      });
    });

    testWidgets('Iel modifie le code postal alors la commune est réinitialisé', (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        ielACesInformationsDeProfil(
          codePostal: codePostal,
          codeInsee: codeInsee,
          nombreDePartsFiscales: nombreDePart,
          revenuFiscal: revenuFiscal,
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        await iEnterInTheField(tester, '3910', Localisation.codePostal);
        ielNeVoitPasLeTexte(commune);
      });
    });

    testWidgets(
      "Après avoir clique sur modifier il retourne sur la page de l'aide et reclique sur accéder au simulateur, la page doit être réinitialisée",
      (final tester) async {
        setUpWidgets(tester);
        await mockNetworkImages(() async {
          ielACesInformationsDeProfil(
            codePostal: codePostal,
            codeInsee: codeInsee,
            nombreDePartsFiscales: nombreDePart,
            revenuFiscal: revenuFiscal,
          );
          leServeurRetourneCetteListeDeCommunes([commune]);
          await _allerSurLeSimulateurVelo(tester, aide2);
          await ielScrolle(tester, Localisation.modifier);
          await ielAppuieSurTexteComportant(tester, Localisation.modifier);
          await ielAppuieSurAccessibilite(tester, Localisation.retour);
          await iTapOn(tester, Localisation.accederAuSimulateur);
          await ielScrolle(tester, Localisation.modifier);
          ielVoitLeTexteDansTexteRiche(Localisation.modifier);
        });
      },
    );
  });
}

Future<void> _allerSurLeSimulateurVelo(final WidgetTester tester, final Aid aide) async {
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await tester.pumpAndSettle();
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await iTapOn(tester, Localisation.aides);
  await iTapOn(tester, aide.title);
  await iTapOn(tester, Localisation.accederAuSimulateur);
}
