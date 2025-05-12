// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_dont_see.dart';
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/i_enter_in_the_autocomplete_field.dart';
import './step/the_api_receives.dart';
import './step/url_launcher_launches.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action MAIF''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/%7BuserId%7D/actions',
              200,
              {
                "actions": [
                  {
                    "nombre_actions_en_cours": 0,
                    "nombre_actions_faites": 0,
                    "nombre_aides_disponibles": 0,
                    "code": "action_simulateur_maif",
                    "titre":
                        "Connaître les risques naturels auxquels votre logement est exposé",
                    "type": "simulateur",
                    "thematique": "logement",
                    "deja_vue": true,
                    "deja_faite": false,
                    "points": 30
                  }
                ],
                "filtres": [
                  {
                    "code": "alimentation",
                    "label": "🥦 Alimentation",
                    "selected": false
                  },
                  {
                    "code": "transport",
                    "label": "🚗 Transports",
                    "selected": false
                  },
                  {
                    "code": "logement",
                    "label": "🏡 Logement",
                    "selected": false
                  },
                  {
                    "code": "consommation",
                    "label": "🛒 Consommation durable",
                    "selected": false
                  },
                  {
                    "code": "climat",
                    "label": "☀️ Environnement",
                    "selected": false
                  },
                  {"code": "dechet", "label": "🗑️ Déchets", "selected": false},
                  {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                ],
                "consultation": "tout",
                "realisation": "tout",
                "nombre_resultats": 39,
                "nombre_resultats_disponibles": 39
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Actions');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir le simulateur avec uniquement la commune renseignée''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir le simulateur avec uniquement la commune renseignée''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": ""
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "nombre_arrets_catnat": 13,
                  "pourcentage_surface_inondation": 85,
                  "pourcentage_surface_secheresse_geotech": 86,
                  "code_commune": "39198"
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iDontSee(tester, 'Vos risques');
        await iSee(tester, 'Les chiffres clés de Dole');
        await iSee(tester, '85%');
        await iSee(tester, '86%');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le simulateur avec uniquement la commune renseignée''',
          success,
        );
      }
    });
    testWidgets('''Voir le simulateur avec une adresse complète''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le simulateur avec une adresse complète''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": ""
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_rue": "5",
                  "rue": "Chemin de Rougemont",
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "nombre_arrets_catnat": 13,
                  "pourcentage_surface_inondation": 85,
                  "pourcentage_surface_secheresse_geotech": 86,
                  "code_commune": "39198"
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 47.10341,
                  "longitude": 5.480833
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iSee(tester, '5 Chemin de Rougemont 39100 Dole');
        await iDontSee(tester, 'Choisir comme adresse principale');
        await iSee(tester, 'Vos risques');
        await iSee(tester, 'Risques de sécheresse');
        await iDontSee(tester, "Risques d'inondations");
        await iSee(tester, 'Risques retrait/gonflement des sols argileux');
        await iSee(tester, 'Risques sismiques');
        await iSee(tester, "Risques d'exposition au radon");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le simulateur avec une adresse complète''',
          success,
        );
      }
    });
    testWidgets(
        '''Modifier l'adresse sans la définir comme adresse principale''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Modifier l'adresse sans la définir comme adresse principale''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": ""
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_voie": "5",
                  "nom_voie": "Chemin de Rougemont",
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "nombre_arrets_catnat": 13,
                  "pourcentage_surface_inondation": 85,
                  "pourcentage_surface_secheresse_geotech": 86,
                  "code_commune": "39198"
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 47.10341,
                  "longitude": 5.480833
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iScrollDownTo(tester, 'Choisissez une adresse');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 45.766368,
                  "longitude": 4.850666
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "catnat", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": false,
                  "resultats": [
                    {
                      "id": "NOR19821118",
                      "titre": "Inondations et/ou Coulées de Boue, Tempête",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19821215",
                      "titre": "Poids de la Neige",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19830111",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19830621",
                      "titre":
                          "Inondations et/ou Coulées de Boue, Glissement de Terrain",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "MDIE900017A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9300601A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400065A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400220A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400269A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400424A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9500304A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9500748A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9600255A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0000045A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0000391A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0100232A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0200011A",
                      "titre": "Inondations Remontée Nappe",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0500697A",
                      "titre": "Mouvement de Terrain",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "IOCE0800746A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "IOME2400969A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "zones_secheresse", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "zone_1",
                      "titre": "Pourcentage risque très faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_2",
                      "titre": "Pourcentage risque faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 79
                    },
                    {
                      "id": "zone_3",
                      "titre": "Pourcentage risque moyen",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_4",
                      "titre": "Pourcentage risque fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 21
                    },
                    {
                      "id": "zone_5",
                      "titre": "Pourcentage risque très fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_total",
                      "titre": "Total considéré à risque",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 21
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "zones_inondation", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "zone_1",
                      "titre": "Pourcentage risque très faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_2",
                      "titre": "Pourcentage risque faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 48
                    },
                    {
                      "id": "zone_3",
                      "titre": "Pourcentage risque moyen",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 29
                    },
                    {
                      "id": "zone_4",
                      "titre": "Pourcentage risque fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 19
                    },
                    {
                      "id": "zone_5",
                      "titre": "Pourcentage risque très fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 3
                    },
                    {
                      "id": "zone_total",
                      "titre": "Total considéré à risque",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 22
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iSee(tester, 'Les chiffres clés de Lyon');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Modifier l'adresse sans la définir comme adresse principale''',
          success,
        );
      }
    });
    testWidgets('''Modifier l'adresse comme adresse principale''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Modifier l'adresse comme adresse principale''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": ""
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_voie": "5",
                  "nom_voie": "Chemin de Rougemont",
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "nombre_arrets_catnat": 13,
                  "pourcentage_surface_inondation": 85,
                  "pourcentage_surface_secheresse_geotech": 86,
                  "code_commune": "39198"
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 47.10341,
                  "longitude": 5.480833
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iScrollDownTo(tester, 'Choisissez une adresse');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 45.766368,
                  "longitude": 4.850666
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "catnat", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": false,
                  "resultats": [
                    {
                      "id": "NOR19821118",
                      "titre": "Inondations et/ou Coulées de Boue, Tempête",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19821215",
                      "titre": "Poids de la Neige",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19830111",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "NOR19830621",
                      "titre":
                          "Inondations et/ou Coulées de Boue, Glissement de Terrain",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "MDIE900017A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9300601A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400065A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400220A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400269A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9400424A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9500304A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9500748A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE9600255A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0000045A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0000391A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0100232A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0200011A",
                      "titre": "Inondations Remontée Nappe",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "INTE0500697A",
                      "titre": "Mouvement de Terrain",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "IOCE0800746A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    },
                    {
                      "id": "IOME2400969A",
                      "titre": "Inondations et/ou Coulées de Boue",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": []
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "zones_secheresse", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "zone_1",
                      "titre": "Pourcentage risque très faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_2",
                      "titre": "Pourcentage risque faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 79
                    },
                    {
                      "id": "zone_3",
                      "titre": "Pourcentage risque moyen",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_4",
                      "titre": "Pourcentage risque fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 21
                    },
                    {
                      "id": "zone_5",
                      "titre": "Pourcentage risque très fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_total",
                      "titre": "Total considéré à risque",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 21
                    }
                  ]
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {"categorie": "zones_inondation", "code_commune": "69386"},
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "zone_1",
                      "titre": "Pourcentage risque très faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 0
                    },
                    {
                      "id": "zone_2",
                      "titre": "Pourcentage risque faible",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 48
                    },
                    {
                      "id": "zone_3",
                      "titre": "Pourcentage risque moyen",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 29
                    },
                    {
                      "id": "zone_4",
                      "titre": "Pourcentage risque fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 19
                    },
                    {
                      "id": "zone_5",
                      "titre": "Pourcentage risque très fort",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 3
                    },
                    {
                      "id": "zone_total",
                      "titre": "Total considéré à risque",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "categories": [],
                      "categories_labels": [],
                      "pourcentage": 22
                    }
                  ]
                }
              ],
              ['PATCH', '/utilisateurs/{userId}/logement', 200, null, {}]
            ]));
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iTapOn(tester, 'Choisir');
        await iDontSee(tester, 'Choisir');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PATCH',
                "/utilisateurs/{userId}/logement",
                200,
                {
                  "rue": "Rue Garibaldi",
                  "numero_rue": "110",
                  "code_postal": "69006",
                  "code_commune": "69386",
                  "latitude": 45.766368,
                  "longitude": 4.850666
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Modifier l'adresse comme adresse principale''',
          success,
        );
      }
    });
    testWidgets('''Télécharger mon kit de prévention''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Télécharger mon kit de prévention''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": ""
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_rue": "5",
                  "rue": "Chemin de Rougemont",
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "nombre_arrets_catnat": 13,
                  "pourcentage_surface_inondation": 85,
                  "pourcentage_surface_secheresse_geotech": 86,
                  "code_commune": "39198"
                }
              ],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/maif/search2',
                200,
                {
                  "categorie": "score_risque",
                  "latitude": 47.10341,
                  "longitude": 5.480833
                },
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "score_secheresse",
                      "titre": "Risques de sécheresse",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "fort",
                      "type_risque": "secheresse"
                    },
                    {
                      "id": "score_inondation",
                      "titre": "Risques d'inondations",
                      "description":
                          "Une inondation est une submersion ponctuelle d’origine naturelle d’une zone habituellement hors d’eau. Elle peut relever d'un phénomène régulier ou catastrophique pouvant se produire lentement ou très rapidement. Elle peut être liée à différents événements :\n- la remontée des nappes phréatiques\n- le ruissellement\n- le débordement des cours d'eau",
                      "categories": [],
                      "categories_labels": [],
                      "niveau_risque": "tres_faible",
                      "type_risque": "inondation"
                    },
                    {
                      "id": "score_submersion",
                      "titre": "Risques de submersion",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "description":
                          "Les submersions marines sont des inondations rapides et de courtes durées (de quelques heures à quelques jours) de la zone côtière par la mer, lors de conditions météorologiques et océaniques défavorables.",
                      "niveau_risque": "tres_faible",
                      "type_risque": "submersion"
                    },
                    {
                      "id": "score_tempete",
                      "titre": "Risques de tempetes",
                      "description": "",
                      "niveau_risque": "tres_faible",
                      "type_risque": "tempete"
                    },
                    {
                      "id": "score_seisme",
                      "titre": "Risques sismiques",
                      "description":
                          "Un séisme ou tremblement de terre est une rupture brutale et profonde des roches le long d'une faille (déplacement tectonique) qui provoque des vibrations plus ou moins violentes à la surface du sol.  D'autres phénomènes peuvent être à l'origine de secousses sismiques (volcan qui entre en éruption…), de mouvements des glaces ou consécutifs à l’action humaine (activités minières, barrages ou explosions).",
                      "niveau_risque": "faible",
                      "type_risque": "seisme"
                    },
                    {
                      "id": "score_argile",
                      "titre": "Risques retrait/gonflement des sols argileux",
                      "description":
                          "La sécheresse géotechnique est le nom donné au phénomène de retrait-gonflement des argiles, processus naturel où les sols argileux gonflent lorsqu'ils sont humides et se rétractent lorsqu'ils sont secs, ce qui peut causer des dégradations sur les structures construites sur ces sols.",
                      "niveau_risque": "moyen",
                      "type_risque": "argile"
                    },
                    {
                      "id": "score_radon",
                      "titre": "Risques d'exposition au radon",
                      "description": "",
                      "niveau_risque": "faible",
                      "type_risque": "radon"
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iScrollDownTo(tester, 'Télécharger mon kit de prévention');
        await iTapOn(tester, 'Télécharger mon kit de prévention');
        await urlLauncherLaunches(tester,
            'https://api.aux-alentours.1934.io/report/pdf/v2/_byLatLon?lat=47.10341&lon=5.480833');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Télécharger mon kit de prévention''',
          success,
        );
      }
    });
  });
}
