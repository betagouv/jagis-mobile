// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_see_points.dart';
import './step/i_dont_see_badges.dart';
import './step/i_see.dart';
import './step/i_tap_on.dart';
import './step/i_see_badges.dart';
import './step/i_dont_see.dart';
import './step/the_api_receives.dart';
import './step/i_scroll_down_to.dart';
import './step/i_tap_on_text.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_actions_in_my_library.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Gamification''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir le points au lancement de l'application''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le points au lancement de l'application''');
        await iAmLoggedIn(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 2000}
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSeePoints(tester, '2000');
        await iDontSeeBadges(tester, '0');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le points au lancement de l'application''',
          success,
        );
      }
    });
    testWidgets('''Voir le popup de reset si c'est un ancien compte''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir le popup de reset si c'est un ancien compte''');
        await iAmLoggedIn(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}',
                200,
                {
                  "pseudo": "Lucas",
                  "is_onboarding_done": true,
                  "popup_reset_est_vue": false,
                  "is_nom_prenom_modifiable": true
                }
              ],
              [
                "POST",
                "/utilisateurs/{userId}/gamification/popup_reset_vue",
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 2000}
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Il y a du nouveau sur J’agis !');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'Merci pour votre soutien !');
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {
                  "points": 200,
                  "badges": [
                    {
                      "description": "Présent depuis les premiers jours",
                      "image_url": "badge-pionnier.webp",
                      "titre": "Pionnier",
                      "type": "pionnier"
                    }
                  ]
                }
              ]
            ]));
        await iTapOn(tester, 'Récolter');
        await iSeePoints(tester, '200');
        await iSeeBadges(tester, '1');
        await iDontSee(tester, 'Merci pour votre soutien !');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "POST",
                "/utilisateurs/{userId}/gamification/popup_reset_vue",
                200,
                null
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le popup de reset si c'est un ancien compte''',
          success,
        );
      }
    });
    testWidgets(
        '''Répondre pour la 1ere fois à la personnalisation d'une thématique fait gagner 25 points''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Répondre pour la 1ere fois à la personnalisation d'une thématique fait gagner 25 points''');
        await iAmLoggedIn(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 0}
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iScrollDownTo(tester, 'Découvrir');
        await iTapOnText(tester, 1, 'Découvrir');
        await iScrollDownTo(tester, 'Commencer');
        await iSeePoints(tester, '0');
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 25}
              ]
            ]));
        await iTapOn(tester, 'Commencer');
        await iSeePoints(tester, '25');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre pour la 1ere fois à la personnalisation d'une thématique fait gagner 25 points''',
          success,
        );
      }
    });
    testWidgets('''Répondre a un quiz fait gagner 20 des feuilles''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Répondre a un quiz fait gagner 20 des feuilles''');
        await iAmLoggedIn(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 0}
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iTapOnTheMenuButton(tester);
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
                  "titre": "Bien trier les déchets",
                  "sous_titre":
                      "Testez vos connaissances sur le tri des déchets avec ce quiz !",
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
                          "Vrai ou faux : tous les déchets organiques peuvent être compostés",
                      "thematique_principale": "dechet",
                      "questions": [
                        {
                          "explicationKO": null,
                          "explicationOk": null,
                          "libelle":
                              "Vrai ou faux : tous les déchets organiques peuvent être compostés",
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
                      "titre": "Où jeter une barquette en aluminium ?",
                      "thematique_principale": "alimentation",
                      "questions": [
                        {
                          "explicationKO":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "explicationOk":
                              "<p><strong>L'aluminium se recycle. </strong>La barquette, préalablement vidée et lavée, doit donc être placée dans la <strong>poubelle des emballages recyclables</strong>. </p><blockquote><p>ℹ️ <strong><em>Le saviez-vous ? </em></strong>On estime que 75% de l'aluminium produit depuis 1880 est toujours utilisé aujourd'hui.</p></blockquote>",
                          "libelle": "Où jeter une barquette en aluminium ?",
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
                      "Alors, le tri n'a plus de secret pour vous ? En cas de doute, rendez-vous sur le site Que faire de mes déchets",
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 20
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
        await iTapOn(tester, 'Quiz - Bien trier les déchets');
        await iTapOn(tester, 'Faux');
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iScrollDownTo(tester, "Poubelle jaune, l'aluminium se recycle");
        await iTapOn(tester, "Poubelle jaune, l'aluminium se recycle");
        await iScrollDownTo(tester, 'Voir la réponse');
        await iTapOn(tester, 'Voir la réponse');
        await iScrollDownTo(tester, 'Voir le résultat');
        await iSeePoints(tester, '0');
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 20}
              ]
            ]));
        await iTapOn(tester, 'Voir le résultat');
        await iSeePoints(tester, '20');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre a un quiz fait gagner 20 des feuilles''',
          success,
        );
      }
    });
    testWidgets('''Répondre a un bilan fait gagner 50 des feuilles''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Répondre a un bilan fait gagner 50 des feuilles''');
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'bilan',
                'action_bilan_alimentation',
                'Calculer les impacts liés à **votre alimentation**',
                2
              ]
            ]));
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 0}
              ]
            ]));
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iTapOnTheMenuButton(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation',
                200,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 0,
                  "code": "action_bilan_alimentation",
                  "titre": "Calculer les impacts liés à **votre alimentation**",
                  "sous_titre":
                      "Quelques questions pour mieux comprendre vos habitudes et calculer le bilan carbone de votre alimentation",
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi": null,
                  "type": "bilan",
                  "thematique": "alimentation",
                  "kycs": [
                    {
                      "code": "KYC_saison_frequence",
                      "question":
                          "Faites-vous attention à consommer des fruits et légumes de saison ?",
                      "reponse_multiple": [
                        {"code": "jamais", "label": "Jamais", "selected": true},
                        {
                          "code": "parfois",
                          "label": "Parfois",
                          "selected": false
                        },
                        {
                          "code": "souvent",
                          "label": "Souvent",
                          "selected": false
                        },
                        {
                          "code": "toujours",
                          "label": "Toujours",
                          "selected": false
                        }
                      ],
                      "is_answered": true,
                      "categorie": "mission",
                      "points": 5,
                      "type": "choix_unique",
                      "is_NGC": true,
                      "thematique": "alimentation"
                    },
                    {
                      "code": "KYC_gaspillage_alimentaire_frequence",
                      "question":
                          "Combien estimez-vous la quantité de déchets alimentaires que vous jetez ?",
                      "reponse_multiple": [
                        {
                          "code": "50L",
                          "label": "Une poubelle de 50L par semaine",
                          "selected": true
                        },
                        {
                          "code": "20L",
                          "label": "Une poubelle de 20L par semaine",
                          "selected": false
                        },
                        {
                          "code": "peu",
                          "label":
                              "Environ une poignée ou l'équivalent d'un bol par semaine",
                          "selected": false
                        },
                        {"code": "zero", "label": "Zéro", "selected": false},
                        {
                          "code": "ne_sais_pas",
                          "label": "Je ne sais pas",
                          "selected": false
                        }
                      ],
                      "is_answered": true,
                      "categorie": "mission",
                      "points": 5,
                      "type": "choix_unique",
                      "is_NGC": true,
                      "thematique": "alimentation"
                    }
                  ],
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": true,
                  "faqs": [],
                  "points": 50,
                  "sources": []
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_saison_frequence',
                200,
                {
                  "code": "KYC_saison_frequence",
                  "question":
                      "Faites-vous attention à consommer des fruits et légumes de saison ?",
                  "reponse_multiple": [
                    {"code": "jamais", "label": "Jamais", "selected": false},
                    {"code": "parfois", "label": "Parfois", "selected": false},
                    {"code": "souvent", "label": "Souvent", "selected": false},
                    {"code": "toujours", "label": "Toujours", "selected": false}
                  ],
                  "is_answered": false,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": true,
                  "thematique": "alimentation"
                }
              ],
              [
                "PUT",
                "/utilisateurs/{userId}/questionsKYC_v2/KYC_saison_frequence",
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_gaspillage_alimentaire_frequence',
                200,
                {
                  "code": "KYC_gaspillage_alimentaire_frequence",
                  "question":
                      "Combien estimez-vous la quantité de déchets alimentaires que vous jetez ?",
                  "reponse_multiple": [
                    {
                      "code": "50L",
                      "label": "Une poubelle de 50L par semaine",
                      "selected": true
                    },
                    {
                      "code": "20L",
                      "label": "Une poubelle de 20L par semaine",
                      "selected": false
                    },
                    {
                      "code": "peu",
                      "label":
                          "Environ une poignée ou l'équivalent d'un bol par semaine",
                      "selected": false
                    },
                    {"code": "zero", "label": "Zéro", "selected": false},
                    {
                      "code": "ne_sais_pas",
                      "label": "Je ne sais pas",
                      "selected": false
                    }
                  ],
                  "is_answered": true,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": true,
                  "thematique": "alimentation"
                }
              ],
              [
                "PUT",
                "/utilisateurs/{userId}/questionsKYC_v2/KYC_gaspillage_alimentaire_frequence",
                200,
                {}
              ],
              [
                "GET",
                "/utilisateurs/{userId}/bilans/last_v3/alimentation",
                200,
                {
                  "thematique": "alimentation",
                  "impact_kg_annee": 3873.1151821000003,
                  "details": [
                    {
                      "label": "Viandes",
                      "impact_kg_annee": 2233.296,
                      "emoji": "🥩"
                    },
                    {
                      "label": "Boissons",
                      "impact_kg_annee": 940.1798000000001,
                      "emoji": "🥤"
                    },
                    {
                      "label": "Poissons",
                      "impact_kg_annee": 182,
                      "emoji": "🐟"
                    },
                    {
                      "label": "Petit déjeuner",
                      "impact_kg_annee": 113.15,
                      "emoji": "🥐"
                    },
                    {
                      "label": "Fruits & Légumes",
                      "impact_kg_annee": 0,
                      "emoji": "🥦"
                    }
                  ],
                  "emoji": "🍴"
                }
              ],
              [
                "POST",
                "/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation/faite",
                200,
                {}
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iTapOn(
            tester, 'Bilan - Calculer les impacts liés à votre alimentation');
        await iTapOn(tester, 'Jamais');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iTapOn(tester, 'Une poubelle de 50L par semaine');
        await iScrollDownTo(tester, 'Question suivante');
        await iSeePoints(tester, '0');
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/gamification',
                200,
                {"points": 50}
              ]
            ]));
        await iTapOn(tester, 'Question suivante');
        await iSeePoints(tester, '50');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre a un bilan fait gagner 50 des feuilles''',
          success,
        );
      }
    });
  });
}
