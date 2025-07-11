// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_text.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/the_api_receives.dart';
import './step/i_enter_in_the_autocomplete_field.dart';
import './step/i_scroll_down_to.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Longue vie aux objets''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/{userId}/thematiques/consommation',
              200,
              {
                "thematique": "consommation",
                "est_personnalisation_necessaire": false,
                "enchainement_questions_personnalisation":
                    "ENCHAINEMENT_KYC_personnalisation_consommation",
                "liste_actions_recommandees": [
                  {
                    "nombre_actions_en_cours": 0,
                    "nombre_actions_faites": 0,
                    "nombre_aides_disponibles": 0,
                    "code": "action_stoppub",
                    "titre":
                        "**Afficher un Stop Pub** sur votre boîte aux lettres",
                    "sous_titre": null,
                    "type": "classique",
                    "thematique": "consommation",
                    "deja_vue": false,
                    "deja_faite": false,
                    "points": 100
                  }
                ],
                "nombre_actions": 6,
                "nombre_aides": 2,
                "nombre_simulateurs": 0,
                "nom_commune": "Lyon 6e Arrondissement"
              }
            ],
            [
              'GET',
              '/utilisateurs/%7BuserId%7D/aides_v2?thematique=consommation',
              200,
              {"couverture_aides_ok": false, "liste_aides": []}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/thematiques/consommation/recherche_services',
              200,
              [
                {
                  "id_service": "longue_vie_objets",
                  "titre": "Que faire de mes objets ?",
                  "sous_titre": "donner, réparer, recycler,...",
                  "external_url": "https://longuevieauxobjets.ademe.fr/",
                  "icon_url":
                      "https://agir-front-dev.osc-fr1.scalingo.io/commerce.webp",
                  "univers": "consommation",
                  "thematique": "consommation",
                  "is_available_inhouse": true
                },
                {
                  "id_service": "reparerabilite",
                  "titre": "Mon appareil se répare-t-il facilement ?",
                  "sous_titre": "Epargnons nos ressources",
                  "external_url":
                      "https://epargnonsnosressources.gouv.fr/indice-de-reparabilite/",
                  "icon_url":
                      "https://epargnonsnosressources.gouv.fr/wp-content/uploads/2023/09/picto_reparabilite_desktop-115.png",
                  "univers": "consommation",
                  "thematique": "consommation",
                  "is_available_inhouse": false
                },
                {
                  "id_service": "labels",
                  "titre": "Se repérer dans les labels",
                  "sous_titre": "Epargnons nos ressources",
                  "external_url":
                      "https://epargnonsnosressources.gouv.fr/labels-environnementaux/",
                  "icon_url":
                      "https://epargnonsnosressources.gouv.fr/wp-content/uploads/2023/09/outils_index-des-labels_icon_desktop_115x95.png",
                  "univers": "consommation",
                  "thematique": "consommation",
                  "is_available_inhouse": false
                },
                {
                  "id_service": "diagnostiquer",
                  "titre": "Diagnostiquer une panne",
                  "sous_titre": "Epargnons nos ressources",
                  "external_url":
                      "https://epargnonsnosressources.gouv.fr/diagnostic-pannes-appareils/",
                  "icon_url":
                      "https://epargnonsnosressources.gouv.fr/wp-content/uploads/2023/10/icons-outils_diagnostique.png",
                  "univers": "consommation",
                  "thematique": "consommation",
                  "is_available_inhouse": false
                },
                {
                  "id_service": "reparer",
                  "titre": "Tutos pour réparer mes objets",
                  "sous_titre": "Epargnons nos ressources",
                  "external_url":
                      "https://epargnonsnosressources.gouv.fr/tutos-reparation/",
                  "icon_url":
                      "https://epargnonsnosressources.gouv.fr/wp-content/uploads/2023/09/picto_tutoreparation_desktop_115x95.png",
                  "univers": "consommation",
                  "thematique": "consommation",
                  "is_available_inhouse": false
                }
              ]
            ],
            [
              'GET',
              '/utilisateurs/{userId}/recherche_services/longue_vie_objets/categories',
              200,
              [
                {
                  "code": "vos_objets",
                  "label": "Vos objets",
                  "is_default": true
                },
                {"code": "donner", "label": "Donner", "is_default": false},
                {"code": "reparer", "label": "Réparer", "is_default": false},
                {"code": "vendre", "label": "Vendre", "is_default": false},
                {"code": "louer", "label": "Louer", "is_default": false},
                {
                  "code": "acheter",
                  "label": "Acheter d'occasion",
                  "is_default": false
                },
                {"code": "emprunter", "label": "Emprunter", "is_default": false}
              ]
            ],
            [
              'POST',
              '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
              200,
              {
                "encore_plus_resultats_dispo": true,
                "resultats": [
                  {
                    "id": "refashion_TLC-REFASHION-PAV-3289828",
                    "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                    "adresse_rue":
                        "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                    "est_favoris": false,
                    "nombre_favoris": 0,
                    "distance_metres": 67,
                    "categories": ["donner"],
                    "latitude": 45.772192,
                    "longitude": 4.856551,
                    "ingredients": [],
                    "etapes_recette": [],
                    "categories_labels": ["Donner"],
                    "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                  }
                ]
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnText(tester, 1, '👕 Mes achats');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir les suggestions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les suggestions''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await iSee(tester, "EBS LE RELAIS NORD PAS DE CALAIS");
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2",
                200,
                {
                  "categorie": "vos_objets",
                  "nombre_max_resultats": 9,
                  "rayon_metres": 5000
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les suggestions''',
          success,
        );
      }
    });
    testWidgets('''Choisir une catégorie''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Choisir une catégorie''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await iTapOn(tester, 'Vos objets');
        await iTapOn(tester, 'Donner');
        await iSee(tester, "EBS LE RELAIS NORD PAS DE CALAIS");
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2",
                200,
                {
                  "categorie": "donner",
                  "nombre_max_resultats": 9,
                  "rayon_metres": 5000
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Choisir une catégorie''',
          success,
        );
      }
    });
    testWidgets('''Recherche avec une adresse''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Recherche avec une adresse''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iSee(tester, "EBS LE RELAIS NORD PAS DE CALAIS");
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2",
                200,
                {
                  "categorie": "vos_objets",
                  "nombre_max_resultats": 9,
                  "rayon_metres": 5000,
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
          '''Recherche avec une adresse''',
          success,
        );
      }
    });
    testWidgets('''Aller sur la page de détails''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Aller sur la page de détails''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/last_results/refashion_TLC-REFASHION-PAV-3289828',
                200,
                {
                  "id": "refashion_TLC-REFASHION-PAV-3289828",
                  "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                  "adresse_rue":
                      "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                  "est_favoris": false,
                  "nombre_favoris": 0,
                  "distance_metres": 67,
                  "categories": ["donner"],
                  "latitude": 45.772192,
                  "longitude": 4.856551,
                  "ingredients": [],
                  "etapes_recette": [],
                  "categories_labels": ["Donner"],
                  "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                }
              ]
            ]));
        await iTapOn(tester, 'EBS LE RELAIS NORD PAS DE CALAIS');
        await iScrollDownTo(tester, 'Sources :');
        await iSee(tester, '· REFASHION');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Aller sur la page de détails''',
          success,
        );
      }
    });
    testWidgets(
        '''Ne pas voir Voir plus qaund il n'y a pas de encore de resultat''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Ne pas voir Voir plus qaund il n'y a pas de encore de resultat''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": false,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await iDontSee(tester, 'Voir plus');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Ne pas voir Voir plus qaund il n'y a pas de encore de resultat''',
          success,
        );
      }
    });
    testWidgets('''Voir plus''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir plus''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'POST',
                '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2',
                200,
                {
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "refashion_TLC-REFASHION-PAV-3289828",
                      "titre": "EBS LE RELAIS NORD PAS DE CALAIS",
                      "adresse_rue":
                          "2 rue Anatole France, 69006, Lyon 6e  Arrondissement",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 67,
                      "categories": ["donner"],
                      "latitude": 45.772192,
                      "longitude": 4.856551,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": ["Donner"],
                      "sources": ["Longue Vie Aux Objets", "ADEME", "REFASHION"]
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Que faire de mes objets ?');
        await iScrollDownTo(tester, 'Voir plus');
        await iTapOn(tester, 'Voir plus');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2",
                200,
                {
                  "categorie": "vos_objets",
                  "nombre_max_resultats": 18,
                  "rayon_metres": 5000
                }
              ]
            ]));
        await iTapOn(tester, 'Voir plus');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2",
                200,
                {
                  "categorie": "vos_objets",
                  "nombre_max_resultats": 27,
                  "rayon_metres": 5000
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir plus''',
          success,
        );
      }
    });
  });
}
