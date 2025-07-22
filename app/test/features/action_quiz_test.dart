// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/the_api_will_return.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/the_api_receive.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action Quiz''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir la première question''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir la première question''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "123",
                      "article_contenu":
                          "<h2>Les idées reçues sur le compost</h2><h3>Tous les déchets organiques peuvent être compostés - Faux</h3><p>Certains déchets comme la viande, le poisson, les produits laitiers et les huiles ne conviennent pas au compostage classique car ils attirent les nuisibles et ralentissent le processus. En revanche, les déchets de cuisine comme les épluchures de fruits et légumes, le marc de café, et les coquilles d'œufs sont parfaits pour le compost​.</p><h3>Le compostage sent mauvais - Faux</h3><p>Bien géré, le compost ne dégage pas d'odeurs désagréables. Un bon équilibre entre matières vertes (azote) et brunes (carbone), ainsi qu'une aération régulière, prévient les mauvaises odeurs​​.</p><h3>Le compostage nécessite beaucoup d'entretien - Faux</h3><p>Le compostage demande un entretien modéré, comme ajouter les bons matériaux et aérer le tas. Une gestion basique suffit souvent pour produire du compost de qualité sans trop d'efforts.</p><h3>Le compost attire les animaux - Vrai et Faux</h3><p>Le compost peut attirer des animaux si des déchets comme la viande et les produits laitiers y sont ajoutés. En ne compostant que des matières appropriées et en utilisant des bacs fermés, vous pouvez minimiser ce risque.</p><h3>Le compostage est lent et inefficace - Faux</h3><p>Le compostage peut produire du compost en quelques mois avec les bonnes conditions de chaleur, d'humidité, et d'aération. Des méthodes comme le compostage en bac rotatif peuvent accélérer le processus.</p>",
                      "article_sources": [
                        {
                          "url":
                              "https://reseaucompost.org/sites/default/files/2024-03/Fiche%20technique%20n%C2%B012%20V2%284%29.pdf",
                          "label": "Réseau Compost"
                        }
                      ],
                      "article_id": "160",
                      "difficulty": 2,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre":
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                          "reponses": [
                            {"exact": false, "reponse": "Vrai"},
                            {"exact": true, "reponse": "Faux"}
                          ]
                        }
                      ]
                    },
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iSee(tester,
            'Testez vos connaissances sur le tri des déchets avec ce quiz !');
        await iSee(tester, 'Question 1 sur 2');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir la première question''',
          success,
        );
      }
    });
    testWidgets('''Réponse correcte à la question avec article''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Réponse correcte à la question avec article''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "123",
                      "article_contenu":
                          "<h2>Les idées reçues sur le compost</h2><h3>Tous les déchets organiques peuvent être compostés - Faux</h3><p>Certains déchets comme la viande, le poisson, les produits laitiers et les huiles ne conviennent pas au compostage classique car ils attirent les nuisibles et ralentissent le processus. En revanche, les déchets de cuisine comme les épluchures de fruits et légumes, le marc de café, et les coquilles d'œufs sont parfaits pour le compost​.</p><h3>Le compostage sent mauvais - Faux</h3><p>Bien géré, le compost ne dégage pas d'odeurs désagréables. Un bon équilibre entre matières vertes (azote) et brunes (carbone), ainsi qu'une aération régulière, prévient les mauvaises odeurs​​.</p><h3>Le compostage nécessite beaucoup d'entretien - Faux</h3><p>Le compostage demande un entretien modéré, comme ajouter les bons matériaux et aérer le tas. Une gestion basique suffit souvent pour produire du compost de qualité sans trop d'efforts.</p><h3>Le compost attire les animaux - Vrai et Faux</h3><p>Le compost peut attirer des animaux si des déchets comme la viande et les produits laitiers y sont ajoutés. En ne compostant que des matières appropriées et en utilisant des bacs fermés, vous pouvez minimiser ce risque.</p><h3>Le compostage est lent et inefficace - Faux</h3><p>Le compostage peut produire du compost en quelques mois avec les bonnes conditions de chaleur, d'humidité, et d'aération. Des méthodes comme le compostage en bac rotatif peuvent accélérer le processus.</p>",
                      "article_sources": [
                        {
                          "url":
                              "https://reseaucompost.org/sites/default/files/2024-03/Fiche%20technique%20n%C2%B012%20V2%284%29.pdf",
                          "label": "Réseau Compost"
                        }
                      ],
                      "article_id": "160",
                      "difficulty": 2,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre":
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                          "reponses": [
                            {"exact": false, "reponse": "Vrai"},
                            {"exact": true, "reponse": "Faux"}
                          ]
                        }
                      ]
                    },
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iSee(tester,
            'Testez vos connaissances sur le tri des déchets avec ce quiz !');
        await iTapOn(tester, 'Faux');
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(tester, '✅ Votre réponse : Faux');
        await iSee(tester, 'Les idées reçues sur le compost');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {"pourcent": 100}
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Réponse correcte à la question avec article''',
          success,
        );
      }
    });
    testWidgets('''Réponse incorrete à la question avec article''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Réponse incorrete à la question avec article''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "123",
                      "article_contenu":
                          "<h2>Les idées reçues sur le compost</h2><h3>Tous les déchets organiques peuvent être compostés - Faux</h3><p>Certains déchets comme la viande, le poisson, les produits laitiers et les huiles ne conviennent pas au compostage classique car ils attirent les nuisibles et ralentissent le processus. En revanche, les déchets de cuisine comme les épluchures de fruits et légumes, le marc de café, et les coquilles d'œufs sont parfaits pour le compost​.</p><h3>Le compostage sent mauvais - Faux</h3><p>Bien géré, le compost ne dégage pas d'odeurs désagréables. Un bon équilibre entre matières vertes (azote) et brunes (carbone), ainsi qu'une aération régulière, prévient les mauvaises odeurs​​.</p><h3>Le compostage nécessite beaucoup d'entretien - Faux</h3><p>Le compostage demande un entretien modéré, comme ajouter les bons matériaux et aérer le tas. Une gestion basique suffit souvent pour produire du compost de qualité sans trop d'efforts.</p><h3>Le compost attire les animaux - Vrai et Faux</h3><p>Le compost peut attirer des animaux si des déchets comme la viande et les produits laitiers y sont ajoutés. En ne compostant que des matières appropriées et en utilisant des bacs fermés, vous pouvez minimiser ce risque.</p><h3>Le compostage est lent et inefficace - Faux</h3><p>Le compostage peut produire du compost en quelques mois avec les bonnes conditions de chaleur, d'humidité, et d'aération. Des méthodes comme le compostage en bac rotatif peuvent accélérer le processus.</p>",
                      "article_sources": [
                        {
                          "url":
                              "https://reseaucompost.org/sites/default/files/2024-03/Fiche%20technique%20n%C2%B012%20V2%284%29.pdf",
                          "label": "Réseau Compost"
                        }
                      ],
                      "article_id": "160",
                      "difficulty": 2,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre":
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                          "reponses": [
                            {"exact": false, "reponse": "Vrai"},
                            {"exact": true, "reponse": "Faux"}
                          ]
                        }
                      ]
                    },
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iSee(tester,
            'Testez vos connaissances sur le tri des déchets avec ce quiz !');
        await iTapOn(tester, 'Vrai');
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(tester, '❌ Votre réponse : Vrai');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {"pourcent": 0}
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Réponse incorrete à la question avec article''',
          success,
        );
      }
    });
    testWidgets('''Réponse correcte à la question sans article''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Réponse correcte à la question sans article''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/216",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO": "explication KO",
                          "explicationOk": "explication OK",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iTapOn(tester, "Poubelle jaune, l'aluminium se recycle");
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(
            tester, "✅ Votre réponse : Poubelle jaune, l'aluminium se recycle");
        await iSee(tester, "explication OK");
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/216",
                200,
                {"pourcent": 100}
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Réponse correcte à la question sans article''',
          success,
        );
      }
    });
    testWidgets('''Réponse incorrete à la question sans article''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Réponse incorrete à la question sans article''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/216",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO": "explication KO",
                          "explicationOk": "explication OK",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iTapOn(tester,
            "Avec les ordures ménagères, l'aluminium ne se recycle pas");
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(tester,
            "❌ Votre réponse : Avec les ordures ménagères, l'aluminium ne se recycle pas");
        await iSee(tester, "explication KO");
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/216",
                200,
                {"pourcent": 0}
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Réponse incorrete à la question sans article''',
          success,
        );
      }
    });
    testWidgets('''Répond à toutes les questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Répond à toutes les questions''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {}
              ],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/216",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "123",
                      "article_contenu":
                          "<h2>Les idées reçues sur le compost</h2><h3>Tous les déchets organiques peuvent être compostés - Faux</h3><p>Certains déchets comme la viande, le poisson, les produits laitiers et les huiles ne conviennent pas au compostage classique car ils attirent les nuisibles et ralentissent le processus. En revanche, les déchets de cuisine comme les épluchures de fruits et légumes, le marc de café, et les coquilles d'œufs sont parfaits pour le compost​.</p><h3>Le compostage sent mauvais - Faux</h3><p>Bien géré, le compost ne dégage pas d'odeurs désagréables. Un bon équilibre entre matières vertes (azote) et brunes (carbone), ainsi qu'une aération régulière, prévient les mauvaises odeurs​​.</p><h3>Le compostage nécessite beaucoup d'entretien - Faux</h3><p>Le compostage demande un entretien modéré, comme ajouter les bons matériaux et aérer le tas. Une gestion basique suffit souvent pour produire du compost de qualité sans trop d'efforts.</p><h3>Le compost attire les animaux - Vrai et Faux</h3><p>Le compost peut attirer des animaux si des déchets comme la viande et les produits laitiers y sont ajoutés. En ne compostant que des matières appropriées et en utilisant des bacs fermés, vous pouvez minimiser ce risque.</p><h3>Le compostage est lent et inefficace - Faux</h3><p>Le compostage peut produire du compost en quelques mois avec les bonnes conditions de chaleur, d'humidité, et d'aération. Des méthodes comme le compostage en bac rotatif peuvent accélérer le processus.</p>",
                      "article_sources": [
                        {
                          "url":
                              "https://reseaucompost.org/sites/default/files/2024-03/Fiche%20technique%20n%C2%B012%20V2%284%29.pdf",
                          "label": "Réseau Compost"
                        }
                      ],
                      "article_id": "160",
                      "difficulty": 2,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre":
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                          "reponses": [
                            {"exact": false, "reponse": "Vrai"},
                            {"exact": true, "reponse": "Faux"}
                          ]
                        }
                      ]
                    },
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets/score",
                200,
                {"nombre_bonnes_reponses": 2, "nombre_quizz_done": 2}
              ],
              [
                "POST",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets/faite",
                200,
                {}
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iSee(tester,
            'Testez vos connaissances sur le tri des déchets avec ce quiz !');
        await iSee(tester, 'Question 1 sur 2');
        await iTapOn(tester, 'Faux');
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(tester, '✅ Votre réponse : Faux');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iSee(tester, 'Question 2 sur 2');
        await iScrollDownTo(tester, "Poubelle jaune, l'aluminium se recycle");
        await iTapOn(tester, "Poubelle jaune, l'aluminium se recycle");
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iSee(
            tester, "✅ Votre réponse : Poubelle jaune, l'aluminium se recycle");
        await iScrollDownTo(tester, 'Voir le résultat');
        await iTapOn(tester, 'Voir le résultat');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "POST",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets/faite",
                200,
                null
              ]
            ]));
        await iSee(tester, 'Recommencer le quiz');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répond à toutes les questions''',
          success,
        );
      }
    });
    testWidgets('''Ne pas répondre à un quiz et valider ne fait rien''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Ne pas répondre à un quiz et valider ne fait rien''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['quizz', 'quiz_tri_dechets', 'Bien trier les déchets', 5]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/bibliotheque/quizz/123",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/actions/quizz/quiz_tri_dechets",
                200,
                {
                  "nombre_actions_en_cours": 5,
                  "nombre_actions_faites": 5,
                  "nombre_aides_disponibles": 0,
                  "code": "quiz_tri_dechets",
                  "emoji": "🌧️",
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "quizz",
                  "thematique": "consommation",
                  "kycs": [],
                  "quizzes": [
                    {
                      "content_id": "123",
                      "article_contenu":
                          "<h2>Les idées reçues sur le compost</h2><h3>Tous les déchets organiques peuvent être compostés - Faux</h3><p>Certains déchets comme la viande, le poisson, les produits laitiers et les huiles ne conviennent pas au compostage classique car ils attirent les nuisibles et ralentissent le processus. En revanche, les déchets de cuisine comme les épluchures de fruits et légumes, le marc de café, et les coquilles d'œufs sont parfaits pour le compost​.</p><h3>Le compostage sent mauvais - Faux</h3><p>Bien géré, le compost ne dégage pas d'odeurs désagréables. Un bon équilibre entre matières vertes (azote) et brunes (carbone), ainsi qu'une aération régulière, prévient les mauvaises odeurs​​.</p><h3>Le compostage nécessite beaucoup d'entretien - Faux</h3><p>Le compostage demande un entretien modéré, comme ajouter les bons matériaux et aérer le tas. Une gestion basique suffit souvent pour produire du compost de qualité sans trop d'efforts.</p><h3>Le compost attire les animaux - Vrai et Faux</h3><p>Le compost peut attirer des animaux si des déchets comme la viande et les produits laitiers y sont ajoutés. En ne compostant que des matières appropriées et en utilisant des bacs fermés, vous pouvez minimiser ce risque.</p><h3>Le compostage est lent et inefficace - Faux</h3><p>Le compostage peut produire du compost en quelques mois avec les bonnes conditions de chaleur, d'humidité, et d'aération. Des méthodes comme le compostage en bac rotatif peuvent accélérer le processus.</p>",
                      "article_sources": [
                        {
                          "url":
                              "https://reseaucompost.org/sites/default/files/2024-03/Fiche%20technique%20n%C2%B012%20V2%284%29.pdf",
                          "label": "Réseau Compost"
                        }
                      ],
                      "article_id": "160",
                      "difficulty": 2,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre":
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                          "reponses": [
                            {"exact": false, "reponse": "Vrai"},
                            {"exact": true, "reponse": "Faux"}
                          ]
                        }
                      ]
                    },
                    {
                      "content_id": "216",
                      "article_id": null,
                      "difficulty": 1,
                      "duree": "⏱️ 2 minutes",
                      "points": 5,
                      "sousTitre": null,
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
                          "reponses": [
                            {
                              "exact": false,
                              "reponse":
                                  "Avec les ordures ménagères, l'aluminium ne se recycle pas"
                            },
                            {
                              "exact": true,
                              "reponse":
                                  "Poubelle jaune, l'aluminium se recycle"
                            },
                            {
                              "exact": false,
                              "reponse":
                                  "Conteneur à verre, il sera trié par la suite"
                            }
                          ]
                        }
                      ]
                    }
                  ],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Asnières-sur-Seine",
                  "quizz_felicitations":
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20,
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Bien trier les déchets');
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Ne pas répondre à un quiz et valider ne fait rien''',
          success,
        );
      }
    });
  });
}
