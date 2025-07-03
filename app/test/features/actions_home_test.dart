// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';
import './step/i_tap_on.dart';
import './step/the_api_receives.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Actions home''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir les actions recommandées''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les actions recommandées''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_recettes_sans_cuisson",
                      "titre":
                          "**Cuisiner une recette sans cuisson** pour limiter les sources de chaleur",
                      "sous_titre":
                          "Cet été, faites-vous plaisir avec des recettes fraîches pour limiter la chaleur et économiser de l'énergie !",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous habitez en zone urbaine",
                            "tag": "habite_zone_urbaine"
                          },
                          {
                            "label_explication": "Vous mangez de saison",
                            "tag": "mange_de_saison"
                          },
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "habite_zone_urbaine",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag": "mange_de_saison",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_legumineuse_nouvelle",
                      "titre":
                          "**Goûter une légumineuse produite en France** que vous ne connaissez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 1,
                      "code": "action_mettre_sa_voiture_a_disposition",
                      "titre":
                          "**Mettre votre voiture à disposition** quand vous ne vous en servez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Vous avez une voiture thermique",
                            "tag": "a_une_voiture_thermique"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "a_une_voiture_thermique",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_plat_local",
                      "titre":
                          "Préparer un plat avec **des ingrédients locaux**",
                      "sous_titre": "Où trouver des produits locaux ?",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_avant_compost",
                      "titre":
                          "**Évaluer les solutions pour composter** avant de vous lancer",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "logement",
                      "deja_vue": false,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous ne compostez pas",
                            "tag": "ne_composte_pas"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "ne_composte_pas",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "quiz_impact_poissons",
                      "titre":
                          "Comprendre les produits de la mer et leur impact",
                      "sous_titre": null,
                      "type": "quizz",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 20,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
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
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false
                    },
                    {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                  ],
                  "consultation": "tout",
                  "realisation": "pas_faite",
                  "nombre_resultats": 6,
                  "nombre_resultats_disponibles": 36
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester,
            'Cuisiner une recette sans cuisson pour limiter les sources de chaleur');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les actions recommandées''',
          success,
        );
      }
    });
    testWidgets('''Voir les actions terminées''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les actions terminées''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_recettes_sans_cuisson",
                      "titre":
                          "**Cuisiner une recette sans cuisson** pour limiter les sources de chaleur",
                      "sous_titre":
                          "Cet été, faites-vous plaisir avec des recettes fraîches pour limiter la chaleur et économiser de l'énergie !",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous habitez en zone urbaine",
                            "tag": "habite_zone_urbaine"
                          },
                          {
                            "label_explication": "Vous mangez de saison",
                            "tag": "mange_de_saison"
                          },
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "habite_zone_urbaine",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag": "mange_de_saison",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_legumineuse_nouvelle",
                      "titre":
                          "**Goûter une légumineuse produite en France** que vous ne connaissez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 1,
                      "code": "action_mettre_sa_voiture_a_disposition",
                      "titre":
                          "**Mettre votre voiture à disposition** quand vous ne vous en servez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Vous avez une voiture thermique",
                            "tag": "a_une_voiture_thermique"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "a_une_voiture_thermique",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_plat_local",
                      "titre":
                          "Préparer un plat avec **des ingrédients locaux**",
                      "sous_titre": "Où trouver des produits locaux ?",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_avant_compost",
                      "titre":
                          "**Évaluer les solutions pour composter** avant de vous lancer",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "logement",
                      "deja_vue": false,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous ne compostez pas",
                            "tag": "ne_composte_pas"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "ne_composte_pas",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "quiz_impact_poissons",
                      "titre":
                          "Comprendre les produits de la mer et leur impact",
                      "sous_titre": null,
                      "type": "quizz",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 20,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
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
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false
                    },
                    {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                  ],
                  "consultation": "tout",
                  "realisation": "pas_faite",
                  "nombre_resultats": 6,
                  "nombre_resultats_disponibles": 36
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 3,
                      "nombre_actions_faites": 3,
                      "nombre_aides_disponibles": 2,
                      "code": "simu_aides_reno",
                      "titre":
                          "**Calculer vos aides** pour rénover votre logement",
                      "sous_titre": null,
                      "type": "simulateur",
                      "thematique": "logement",
                      "deja_vue": true,
                      "deja_faite": true,
                      "points": 30,
                      "explications_recommandation": {
                        "liste_explications": [],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": []
                      }
                    },
                    {
                      "nombre_actions_en_cours": 5,
                      "nombre_actions_faites": 5,
                      "nombre_aides_disponibles": 2,
                      "code": "action_simulateur_voiture",
                      "titre":
                          "Trouver le **type de voiture** qui vous convient le mieux",
                      "sous_titre":
                          "Comparez les coûts et les émissions de votre voiture à des alternatives économiques et écologiques.",
                      "type": "simulateur",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": true,
                      "points": 30,
                      "explications_recommandation": {
                        "liste_explications": [],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": []
                      }
                    },
                    {
                      "nombre_actions_en_cours": 6,
                      "nombre_actions_faites": 6,
                      "nombre_aides_disponibles": 0,
                      "code": "action_simulateur_maif",
                      "titre":
                          "**Connaître les risques naturels** auxquels votre logement est exposé",
                      "sous_titre": null,
                      "type": "simulateur",
                      "thematique": "logement",
                      "deja_vue": true,
                      "deja_faite": true,
                      "points": 30,
                      "explications_recommandation": {
                        "liste_explications": [],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": []
                      }
                    }
                  ],
                  "filtres": [
                    {
                      "code": "alimentation",
                      "label": "🥦 Alimentation",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "transport",
                      "label": "🚗 Transports",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "logement",
                      "label": "🏡 Logement",
                      "selected": false,
                      "liste_sous_thematiques": [
                        {
                          "code": "logement_economie_energie",
                          "label": "Faire des économies d'énergie",
                          "selected": false
                        },
                        {
                          "code": "logement_risque_naturel",
                          "label": "Les risques naturels",
                          "selected": false
                        }
                      ]
                    },
                    {
                      "code": "consommation",
                      "label": "🛒 Consommation durable",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "climat",
                      "label": "☀️ Environnement",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "loisir",
                      "label": "⚽ Loisirs",
                      "selected": false,
                      "liste_sous_thematiques": []
                    }
                  ],
                  "consultation": "tout",
                  "realisation": "faite",
                  "nombre_resultats": 3,
                  "nombre_resultats_disponibles": 3
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iTapOn(tester, 'Terminées');
        await iSee(tester, 'Calculer vos aides pour rénover votre logement');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "GET",
                '/utilisateurs/%7BuserId%7D/actions?realisation=faite&ordre=recommandee_filtre_perso&take=6',
                200,
                null
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les actions terminées''',
          success,
        );
      }
    });
    testWidgets('''Voir le message si aucune action terminée''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le message si aucune action terminée''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_recettes_sans_cuisson",
                      "titre":
                          "**Cuisiner une recette sans cuisson** pour limiter les sources de chaleur",
                      "sous_titre":
                          "Cet été, faites-vous plaisir avec des recettes fraîches pour limiter la chaleur et économiser de l'énergie !",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous habitez en zone urbaine",
                            "tag": "habite_zone_urbaine"
                          },
                          {
                            "label_explication": "Vous mangez de saison",
                            "tag": "mange_de_saison"
                          },
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "habite_zone_urbaine",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag": "mange_de_saison",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_legumineuse_nouvelle",
                      "titre":
                          "**Goûter une légumineuse produite en France** que vous ne connaissez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 1,
                      "code": "action_mettre_sa_voiture_a_disposition",
                      "titre":
                          "**Mettre votre voiture à disposition** quand vous ne vous en servez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Vous avez une voiture thermique",
                            "tag": "a_une_voiture_thermique"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "a_une_voiture_thermique",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_plat_local",
                      "titre":
                          "Préparer un plat avec **des ingrédients locaux**",
                      "sous_titre": "Où trouver des produits locaux ?",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_avant_compost",
                      "titre":
                          "**Évaluer les solutions pour composter** avant de vous lancer",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "logement",
                      "deja_vue": false,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous ne compostez pas",
                            "tag": "ne_composte_pas"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "ne_composte_pas",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "quiz_impact_poissons",
                      "titre":
                          "Comprendre les produits de la mer et leur impact",
                      "sous_titre": null,
                      "type": "quizz",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 20,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
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
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false
                    },
                    {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                  ],
                  "consultation": "tout",
                  "realisation": "pas_faite",
                  "nombre_resultats": 6,
                  "nombre_resultats_disponibles": 36
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [],
                  "filtres": [
                    {
                      "code": "alimentation",
                      "label": "🥦 Alimentation",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "transport",
                      "label": "🚗 Transports",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "logement",
                      "label": "🏡 Logement",
                      "selected": false,
                      "liste_sous_thematiques": [
                        {
                          "code": "logement_economie_energie",
                          "label": "Faire des économies d'énergie",
                          "selected": false
                        },
                        {
                          "code": "logement_risque_naturel",
                          "label": "Les risques naturels",
                          "selected": false
                        }
                      ]
                    },
                    {
                      "code": "consommation",
                      "label": "🛒 Consommation durable",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "climat",
                      "label": "☀️ Environnement",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false,
                      "liste_sous_thematiques": []
                    },
                    {
                      "code": "loisir",
                      "label": "⚽ Loisirs",
                      "selected": false,
                      "liste_sous_thematiques": []
                    }
                  ],
                  "consultation": "tout",
                  "realisation": "faite",
                  "nombre_resultats": 3,
                  "nombre_resultats_disponibles": 3
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iTapOn(tester, 'Terminées');
        await iSee(tester, 'Vous n’avez pas encore terminé d’action.');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le message si aucune action terminée''',
          success,
        );
      }
    });
    testWidgets('''Voir les raccourcis vers les thèmes''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les raccourcis vers les thèmes''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_recettes_sans_cuisson",
                      "titre":
                          "**Cuisiner une recette sans cuisson** pour limiter les sources de chaleur",
                      "sous_titre":
                          "Cet été, faites-vous plaisir avec des recettes fraîches pour limiter la chaleur et économiser de l'énergie !",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous habitez en zone urbaine",
                            "tag": "habite_zone_urbaine"
                          },
                          {
                            "label_explication": "Vous mangez de saison",
                            "tag": "mange_de_saison"
                          },
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "habite_zone_urbaine",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag": "mange_de_saison",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_legumineuse_nouvelle",
                      "titre":
                          "**Goûter une légumineuse produite en France** que vous ne connaissez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 1,
                      "code": "action_mettre_sa_voiture_a_disposition",
                      "titre":
                          "**Mettre votre voiture à disposition** quand vous ne vous en servez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Vous avez une voiture thermique",
                            "tag": "a_une_voiture_thermique"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "a_une_voiture_thermique",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_plat_local",
                      "titre":
                          "Préparer un plat avec **des ingrédients locaux**",
                      "sous_titre": "Où trouver des produits locaux ?",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_avant_compost",
                      "titre":
                          "**Évaluer les solutions pour composter** avant de vous lancer",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "logement",
                      "deja_vue": false,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous ne compostez pas",
                            "tag": "ne_composte_pas"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "ne_composte_pas",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "quiz_impact_poissons",
                      "titre":
                          "Comprendre les produits de la mer et leur impact",
                      "sous_titre": null,
                      "type": "quizz",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 20,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
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
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false
                    },
                    {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                  ],
                  "consultation": "tout",
                  "realisation": "pas_faite",
                  "nombre_resultats": 6,
                  "nombre_resultats_disponibles": 36
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Affinez vos recommandations');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les raccourcis vers les thèmes''',
          success,
        );
      }
    });
    testWidgets('''Ne pas voir les raccourcis vers les thèmes''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Ne pas voir les raccourcis vers les thèmes''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 100,
                  "pourcentage_global_reco_done": 100
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&ordre=recommandee_filtre_perso&take=6',
                200,
                {
                  "actions": [
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_recettes_sans_cuisson",
                      "titre":
                          "**Cuisiner une recette sans cuisson** pour limiter les sources de chaleur",
                      "sous_titre":
                          "Cet été, faites-vous plaisir avec des recettes fraîches pour limiter la chaleur et économiser de l'énergie !",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous habitez en zone urbaine",
                            "tag": "habite_zone_urbaine"
                          },
                          {
                            "label_explication": "Vous mangez de saison",
                            "tag": "mange_de_saison"
                          },
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "habite_zone_urbaine",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag": "mange_de_saison",
                            "valeur": 10,
                            "ponderation": 1
                          },
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 1,
                      "nombre_actions_faites": 1,
                      "nombre_aides_disponibles": 0,
                      "code": "action_legumineuse_nouvelle",
                      "titre":
                          "**Goûter une légumineuse produite en France** que vous ne connaissez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 1,
                      "code": "action_mettre_sa_voiture_a_disposition",
                      "titre":
                          "**Mettre votre voiture à disposition** quand vous ne vous en servez pas",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "transport",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Vous avez une voiture thermique",
                            "tag": "a_une_voiture_thermique"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "a_une_voiture_thermique",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_plat_local",
                      "titre":
                          "Préparer un plat avec **des ingrédients locaux**",
                      "sous_titre": "Où trouver des produits locaux ?",
                      "type": "classique",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "action_avant_compost",
                      "titre":
                          "**Évaluer les solutions pour composter** avant de vous lancer",
                      "sous_titre": null,
                      "type": "classique",
                      "thematique": "logement",
                      "deja_vue": false,
                      "deja_faite": false,
                      "points": 100,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication": "Vous ne compostez pas",
                            "tag": "ne_composte_pas"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag": "ne_composte_pas",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
                    },
                    {
                      "nombre_actions_en_cours": 0,
                      "nombre_actions_faites": 0,
                      "nombre_aides_disponibles": 0,
                      "code": "quiz_impact_poissons",
                      "titre":
                          "Comprendre les produits de la mer et leur impact",
                      "sous_titre": null,
                      "type": "quizz",
                      "thematique": "alimentation",
                      "deja_vue": true,
                      "deja_faite": false,
                      "points": 20,
                      "explications_recommandation": {
                        "liste_explications": [
                          {
                            "label_explication":
                                "Mieux vous nourrir est ce que vous recherchez en priorité",
                            "tag": "appetence_thematique_alimentation"
                          }
                        ],
                        "est_exclu": false
                      },
                      "explications_recommandation_raw": {
                        "liste_explications": [
                          {
                            "inclusion_tag":
                                "appetence_thematique_alimentation",
                            "valeur": 10,
                            "ponderation": 1
                          }
                        ]
                      }
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
                    {
                      "code": "dechet",
                      "label": "🗑️ Déchets",
                      "selected": false
                    },
                    {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                  ],
                  "consultation": "tout",
                  "realisation": "pas_faite",
                  "nombre_resultats": 6,
                  "nombre_resultats_disponibles": 36
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iDontSee(tester, 'Affinez vos recommandations');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Ne pas voir les raccourcis vers les thèmes''',
          success,
        );
      }
    });
  });
}
