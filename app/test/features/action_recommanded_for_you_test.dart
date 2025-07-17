// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_scroll_down_to.dart';
import './step/i_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action Recommanded for you''', () {
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
                    "code": "action_recuperer_eau_pluie",
                    "emoji": "🌧️",
                    "titre":
                        "**Utiliser l'eau de pluie** pour votre maison ou vos plantes",
                    "sous_titre": null,
                    "type": "classique",
                    "thematique": "logement",
                    "deja_vue": true,
                    "deja_faite": false,
                    "points": 100
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
                "nombre_resultats": 1,
                "nombre_resultats_disponibles": 1
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

    testWidgets('''N’est pas recommandée pour vous''', (tester) async {
      var success = true;
      try {
        await beforeEach('''N’est pas recommandée pour vous''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/classique/action_recuperer_eau_pluie',
                200,
                {
                  "nombre_actions_en_cours": 1,
                  "nombre_actions_faites": 1,
                  "nombre_aides_disponibles": 0,
                  "code": "action_recuperer_eau_pluie",
                  "emoji": "🌧️",
                  "titre":
                      "**Utiliser l'eau de pluie** pour votre maison ou vos plantes",
                  "sous_titre": null,
                  "consigne":
                      "Cette semaine, mettez en place un système pour récupérer l'eau de pluie chez vous, au lieu d'utiliser de l'eau potable !",
                  "label_compteur":
                      "1 membres de la communauté **réduisent leur consommation d'eau** en tirant profit de la pluie.",
                  "besoins": ["recup_eau_pluie"],
                  "comment":
                      "## Comment faire ?\n\nPour récupérer l'eau de pluie qui ruisselle sur votre toiture, vous pouvez installer - ou faire installer par un professionnel - **une cuve hors-sol ou une cuve enterrée dans votre jardin.** Cet équipement s'achète dans les magasins de bricolage et coûte entre 80 et 2 500€ selon les modèles et les volumes stockés.\nEn effet, certaines cuves hors-sol peuvent recueillir jusqu'à 2 000 litres d'eau de pluie ; les récupérateurs enterrés, jusqu'à 5 000 litres.\n\nEn moyenne, **chaque m² de toiture peut recueillir environ 700 litres d'eau de pluie par an.** Ce qui représente environ 70m3 d'eau pour un toit de 100m².  \n\nPour choisir le bon modèle, **mesurez l'espace dont vous disposez** pour l'entreposer et faites le point sur le volume d'eau nécessaire aux usages : arrosage, lavage de votre véhicule ou pour des usages intérieurs.\nAttention, si la cuve est placée dans une cave, un sous-sol ou un garage, il est obligatoire d’afficher un écriteau précisant qu'il s'agit d'“Eau non potable”.\n\nDans le cas où vous utiliseriez l'eau de pluie pour des usages intérieurs (remplir les chasses d'eau des toilettes, laver vos sols, laver le linge - en ayant installé au préalable un système pour traiter l'eau -, **vous devez le déclarer en mairie et nettoyer la cuve tous les ans.**\n\nD'ailleurs, certaines communes proposent **des aides financières** et peuvent **vous accompagner dans l'installation d'un récupérateur chez vous** ! Retrouvez les aides à votre disposition ci-dessous.\n\nSi l'espace dont vous disposez ne peut pas accueillir une cuve - car par exemple, vous vivez en ville -, vous pouvez toujours **déposer plusieurs seaux et réservoirs d'une dizaine de litres sur votre balcon** et utiliser l'eau recueillie pour arroser vos jardinières.",
                  "pourquoi":
                      "## En quelques mots\n\nSaviez-vous qu’arroser les plantes et les fleurs de votre jardin consomme environ **15 litres d’eau par m² ?**\n\nLa solution pour faire des économies et limiter la consommation d’eau : **profiter des averses et récupérer l’eau de pluie pour arroser votre jardin.**\n\n## Quels sont les usages autorisés ?\n\n- Remplir les chasses d'eau **des toilettes** ;\n- Laver **les sols** ;\n- Laver **du linge** (en installant au préalable un système pour traiter l'eau) ;\n- Arroser **son jardin** ;\n- Nettoyer **sa voiture**.",
                  "type": "classique",
                  "thematique": "logement",
                  "kycs": [],
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Lyon",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 100,
                  "sources": [
                    {
                      "url":
                          "https://www.service-public.fr/particuliers/vosdroits/F31481",
                      "label": "Service public - Récupération de l'eau de pluie"
                    }
                  ],
                  "articles": [
                    {
                      "content_id": "204",
                      "titre": "Récupérer l'eau de pluie chez soi",
                      "soustitre": null,
                      "thematique_principale": "logement",
                      "thematiques": ["logement"],
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1727714038/david_ballew_P7saq8j11p_M_unsplash_01667ccd8a.jpg"
                    }
                  ],
                  "like_level": null,
                  "explications_recommandation": {
                    "liste_explications": [
                      {
                        "label_explication": "Vous n'avez pas de jardin",
                        "tag": "n_a_pas_de_jardin"
                      }
                    ],
                    "est_exclu": true
                  },
                  "explications_recommandation_raw": {
                    "liste_explications": [
                      {"exclusion_tag": "n_a_pas_de_jardin"}
                    ]
                  }
                }
              ]
            ]));
        await iTapOn(tester,
            "🌧️ Utiliser l'eau de pluie pour votre maison ou vos plantes");
        await iScrollDownTo(tester, 'N’est pas recommandée pour vous, car');
        await iSee(tester, 'N’est pas recommandée pour vous, car');
        await iSee(tester, "Vous n'avez pas de jardin");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''N’est pas recommandée pour vous''',
          success,
        );
      }
    });
    testWidgets('''Recommandée pour vous''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Recommandée pour vous''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/classique/action_recuperer_eau_pluie',
                200,
                {
                  "nombre_actions_en_cours": 1,
                  "nombre_actions_faites": 1,
                  "nombre_aides_disponibles": 0,
                  "code": "action_recuperer_eau_pluie",
                  "emoji": "🌧️",
                  "titre":
                      "**Utiliser l'eau de pluie** pour votre maison ou vos plantes",
                  "sous_titre": null,
                  "consigne":
                      "Cette semaine, mettez en place un système pour récupérer l'eau de pluie chez vous, au lieu d'utiliser de l'eau potable !",
                  "label_compteur":
                      "1 membres de la communauté **réduisent leur consommation d'eau** en tirant profit de la pluie.",
                  "besoins": ["recup_eau_pluie"],
                  "comment":
                      "## Comment faire ?\n\nPour récupérer l'eau de pluie qui ruisselle sur votre toiture, vous pouvez installer - ou faire installer par un professionnel - **une cuve hors-sol ou une cuve enterrée dans votre jardin.** Cet équipement s'achète dans les magasins de bricolage et coûte entre 80 et 2 500€ selon les modèles et les volumes stockés.\nEn effet, certaines cuves hors-sol peuvent recueillir jusqu'à 2 000 litres d'eau de pluie ; les récupérateurs enterrés, jusqu'à 5 000 litres.\n\nEn moyenne, **chaque m² de toiture peut recueillir environ 700 litres d'eau de pluie par an.** Ce qui représente environ 70m3 d'eau pour un toit de 100m².  \n\nPour choisir le bon modèle, **mesurez l'espace dont vous disposez** pour l'entreposer et faites le point sur le volume d'eau nécessaire aux usages : arrosage, lavage de votre véhicule ou pour des usages intérieurs.\nAttention, si la cuve est placée dans une cave, un sous-sol ou un garage, il est obligatoire d’afficher un écriteau précisant qu'il s'agit d'“Eau non potable”.\n\nDans le cas où vous utiliseriez l'eau de pluie pour des usages intérieurs (remplir les chasses d'eau des toilettes, laver vos sols, laver le linge - en ayant installé au préalable un système pour traiter l'eau -, **vous devez le déclarer en mairie et nettoyer la cuve tous les ans.**\n\nD'ailleurs, certaines communes proposent **des aides financières** et peuvent **vous accompagner dans l'installation d'un récupérateur chez vous** ! Retrouvez les aides à votre disposition ci-dessous.\n\nSi l'espace dont vous disposez ne peut pas accueillir une cuve - car par exemple, vous vivez en ville -, vous pouvez toujours **déposer plusieurs seaux et réservoirs d'une dizaine de litres sur votre balcon** et utiliser l'eau recueillie pour arroser vos jardinières.",
                  "pourquoi":
                      "## En quelques mots\n\nSaviez-vous qu’arroser les plantes et les fleurs de votre jardin consomme environ **15 litres d’eau par m² ?**\n\nLa solution pour faire des économies et limiter la consommation d’eau : **profiter des averses et récupérer l’eau de pluie pour arroser votre jardin.**\n\n## Quels sont les usages autorisés ?\n\n- Remplir les chasses d'eau **des toilettes** ;\n- Laver **les sols** ;\n- Laver **du linge** (en installant au préalable un système pour traiter l'eau) ;\n- Arroser **son jardin** ;\n- Nettoyer **sa voiture**.",
                  "type": "classique",
                  "thematique": "logement",
                  "kycs": [],
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Lyon",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 100,
                  "sources": [
                    {
                      "url":
                          "https://www.service-public.fr/particuliers/vosdroits/F31481",
                      "label": "Service public - Récupération de l'eau de pluie"
                    }
                  ],
                  "articles": [
                    {
                      "content_id": "204",
                      "titre": "Récupérer l'eau de pluie chez soi",
                      "soustitre": null,
                      "thematique_principale": "logement",
                      "thematiques": ["logement"],
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1727714038/david_ballew_P7saq8j11p_M_unsplash_01667ccd8a.jpg"
                    }
                  ],
                  "like_level": null,
                  "explications_recommandation": {
                    "liste_explications": [
                      {
                        "label_explication": "Vous avez un jardin",
                        "tag": "a_un_jardin"
                      }
                    ],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {
                    "liste_explications": [
                      {"exclusion_tag": "a_un_jardin"}
                    ]
                  }
                }
              ]
            ]));
        await iTapOn(tester,
            "🌧️ Utiliser l'eau de pluie pour votre maison ou vos plantes");
        await iScrollDownTo(tester, 'Recommandée pour vous, car');
        await iSee(tester, 'Recommandée pour vous, car');
        await iSee(tester, "Vous avez un jardin");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Recommandée pour vous''',
          success,
        );
      }
    });
    testWidgets(
        '''Appuie sur une explication ouvre la page mieux vous connaître''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Appuie sur une explication ouvre la page mieux vous connaître''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/classique/action_recuperer_eau_pluie',
                200,
                {
                  "nombre_actions_en_cours": 1,
                  "nombre_actions_faites": 1,
                  "nombre_aides_disponibles": 0,
                  "code": "action_recuperer_eau_pluie",
                  "emoji": "🌧️",
                  "titre":
                      "**Utiliser l'eau de pluie** pour votre maison ou vos plantes",
                  "sous_titre": null,
                  "consigne":
                      "Cette semaine, mettez en place un système pour récupérer l'eau de pluie chez vous, au lieu d'utiliser de l'eau potable !",
                  "label_compteur":
                      "1 membres de la communauté **réduisent leur consommation d'eau** en tirant profit de la pluie.",
                  "besoins": ["recup_eau_pluie"],
                  "comment":
                      "## Comment faire ?\n\nPour récupérer l'eau de pluie qui ruisselle sur votre toiture, vous pouvez installer - ou faire installer par un professionnel - **une cuve hors-sol ou une cuve enterrée dans votre jardin.** Cet équipement s'achète dans les magasins de bricolage et coûte entre 80 et 2 500€ selon les modèles et les volumes stockés.\nEn effet, certaines cuves hors-sol peuvent recueillir jusqu'à 2 000 litres d'eau de pluie ; les récupérateurs enterrés, jusqu'à 5 000 litres.\n\nEn moyenne, **chaque m² de toiture peut recueillir environ 700 litres d'eau de pluie par an.** Ce qui représente environ 70m3 d'eau pour un toit de 100m².  \n\nPour choisir le bon modèle, **mesurez l'espace dont vous disposez** pour l'entreposer et faites le point sur le volume d'eau nécessaire aux usages : arrosage, lavage de votre véhicule ou pour des usages intérieurs.\nAttention, si la cuve est placée dans une cave, un sous-sol ou un garage, il est obligatoire d’afficher un écriteau précisant qu'il s'agit d'“Eau non potable”.\n\nDans le cas où vous utiliseriez l'eau de pluie pour des usages intérieurs (remplir les chasses d'eau des toilettes, laver vos sols, laver le linge - en ayant installé au préalable un système pour traiter l'eau -, **vous devez le déclarer en mairie et nettoyer la cuve tous les ans.**\n\nD'ailleurs, certaines communes proposent **des aides financières** et peuvent **vous accompagner dans l'installation d'un récupérateur chez vous** ! Retrouvez les aides à votre disposition ci-dessous.\n\nSi l'espace dont vous disposez ne peut pas accueillir une cuve - car par exemple, vous vivez en ville -, vous pouvez toujours **déposer plusieurs seaux et réservoirs d'une dizaine de litres sur votre balcon** et utiliser l'eau recueillie pour arroser vos jardinières.",
                  "pourquoi":
                      "## En quelques mots\n\nSaviez-vous qu’arroser les plantes et les fleurs de votre jardin consomme environ **15 litres d’eau par m² ?**\n\nLa solution pour faire des économies et limiter la consommation d’eau : **profiter des averses et récupérer l’eau de pluie pour arroser votre jardin.**\n\n## Quels sont les usages autorisés ?\n\n- Remplir les chasses d'eau **des toilettes** ;\n- Laver **les sols** ;\n- Laver **du linge** (en installant au préalable un système pour traiter l'eau) ;\n- Arroser **son jardin** ;\n- Nettoyer **sa voiture**.",
                  "type": "classique",
                  "thematique": "logement",
                  "kycs": [],
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Lyon",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 100,
                  "sources": [
                    {
                      "url":
                          "https://www.service-public.fr/particuliers/vosdroits/F31481",
                      "label": "Service public - Récupération de l'eau de pluie"
                    }
                  ],
                  "articles": [
                    {
                      "content_id": "204",
                      "titre": "Récupérer l'eau de pluie chez soi",
                      "soustitre": null,
                      "thematique_principale": "logement",
                      "thematiques": ["logement"],
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1727714038/david_ballew_P7saq8j11p_M_unsplash_01667ccd8a.jpg"
                    }
                  ],
                  "like_level": null,
                  "explications_recommandation": {
                    "liste_explications": [
                      {
                        "label_explication": "Vous avez un jardin",
                        "tag": "a_un_jardin"
                      }
                    ],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {
                    "liste_explications": [
                      {"exclusion_tag": "a_un_jardin"}
                    ]
                  }
                }
              ],
              ['GET', '/utilisateurs/{userId}/questionsKYC_v2', 200, []]
            ]));
        await iTapOn(tester,
            "🌧️ Utiliser l'eau de pluie pour votre maison ou vos plantes");
        await iScrollDownTo(tester, 'Recommandée pour vous, car');
        await iTapOn(tester, "Vous avez un jardin");
        await iSee(tester, 'Mieux vous connaître');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Appuie sur une explication ouvre la page mieux vous connaître''',
          success,
        );
      }
    });
  });
}
