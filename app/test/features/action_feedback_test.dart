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
import './step/i_scroll_down.dart';
import './step/i_scroll_down_to.dart';
import './step/i_tap_on_semantics.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_dont_see.dart';
import './step/the_api_receives.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action Feedback''', () {
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
                    "code": "action_comparer_elecgaz",
                    "titre":
                        "Comparer et **choisir entre l'électricité et le gaz** pour équiper votre logement",
                    "sous_titre":
                        "Quelle énergie choisir quand je dois changer mon chauffage ou mes équipements (cuisine, radiateurs...) ?",
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
            ],
            [
              'GET',
              '/utilisateurs/{userId}/actions/classique/action_comparer_elecgaz',
              200,
              {
                "nombre_actions_en_cours": 0,
                "nombre_actions_faites": 0,
                "nombre_aides_disponibles": 0,
                "code": "action_comparer_elecgaz",
                "titre":
                    "Comparer et **choisir entre l'électricité et le gaz** pour équiper votre logement",
                "sous_titre":
                    "Quelle énergie choisir quand je dois changer mon chauffage ou mes équipements (cuisine, radiateurs...) ?",
                "consigne":
                    "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                "label_compteur":
                    "**0 utilisateurs** ont comparé l'électricité et le gaz pour changer leur système d'énergie et de chauffage",
                "besoins": ["gerer_conso_energie"],
                "comment":
                    "## Des conseils pratiques pour vous aider\n\n### **Comparez les coûts d’installation**\n\n- Le gaz nécessite un raccordement au réseau, l’installation d’une chaudière et un contrat spécifique.\n- **L'électricité est généralement plus simple à mettre en place et moins coûteuse**.\n\n### **Comparez les tarifs, les fournisseurs et la consommation**\n\n- **Le gaz est souvent moins cher au kWh**, mais il implique des frais d’entretien (chaudière, conduits…).\n- L’électricité est plus chère au kWh et peut être plus énergivore, mais certains équipements (pompe à chaleur, radiateurs à inertie) permettent d’optimiser la consommation.  \n*Rendez-vous [ici](https://comparateur-offres.energie-info.fr/compte/profil?profil=particulier) pour comparer les fournisseurs d'énergie en fonction de votre budget et de vos besoins.*\n\n### **Identifiez vos besoins selon votre utilisation et votre consommation**\n\n🌡️ **Pour le chauffage :** le gaz est plus adapté aux grandes surfaces (**l’électricité n’est plus recommandée pour les logements de plus de 80m2**), tandis que l’électricité convient mieux aux petits logements bien isolés.\n\n♨️ **Pour la cuisson :** le gaz est réputé pour sa précision et son coût, mais l’induction électrique consomme moins d’énergie.\n\n💧 **Pour l’eau chaude :** un ballon électrique peut être rentable selon votre consommation.\n\n### **L’impact écologique et les aides disponibles**\n\n- **L’électricité française est moins émettrice de CO₂ que le gaz**, mais son impact dépend de la source (nucléaire, hydraulique, solaire…).\n- Le gaz fossile est plus polluant, bien que le biogaz devienne une alternative plus verte.\n\nIl est aussi possible de combiner les deux énergies pour optimiser son budget et son impact environnemental : chaudière hybride, panneaux solaires + électricité, pompe à chaleur…\n\nPrenez aussi le temps de vous renseigner sur les aides pour l'efficacité énergétique du logement, qui peuvent être un argument de choix.\n\nEn résumé, le choix entre électricité et gaz dépend de votre logement, de votre consommation et de vos besoins. Prendre le temps de comparer ces options vous aidera à faire un choix durable et économique !",
                "pourquoi":
                    "## En quelques mots\n\nUne grande partie des ménages français se chauffe aujourd'hui à l’électrique (37 % en 2020). Électricité ou gaz, en comparant ces deux énergies, vous pourrez :\n\n- **Trouver la solution la plus rentable pour votre logement**,\n- **Réduire vos factures d’énergie sur le long terme**,\n- **Limiter votre impact carbone en choisissant une énergie plus verte**.\n\nAlors, **faut-il privilégier l’électricité ou le gaz** en fonction de votre budget, votre consommation et vos besoins ? Nous vous aidons à y voir plus clair !",
                "type": "classique",
                "thematique": "logement",
                "kycs": [],
                "quizzes": [],
                "aides": [],
                "services": [],
                "nom_commune": "Dole",
                "quizz_felicitations": null,
                "deja_vue": true,
                "deja_faite": false,
                "faqs": [],
                "points": 100,
                "sources": [
                  {
                    "url":
                        "https://www.energie-info.fr/fiche_pratique/comment-comparer-les-offres-delectricite-et-de-gaz-naturel/",
                    "label": "Comparer les offres - Énergie Info"
                  },
                  {
                    "url":
                        "https://www.hellowatt.fr/chauffage/electrique/chauffage-electrique-ou-gaz",
                    "label": "Électrique ou gaz en 2025 - Hello Watt"
                  }
                ],
                "articles": [],
                "like_level": null
              }
            ],
            [
              "POST",
              "/utilisateurs/{userId}/actions/classique/action_comparer_elecgaz/feedback",
              200,
              {"like_level": 4, "feedback": "Cette action est superbe."}
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Actions');
      await iTapOn(tester,
          "Comparer et choisir entre l'électricité et le gaz pour équiper votre logement");
      await iScrollDown(tester);
      await iScrollDown(tester);
      await iScrollDown(tester);
      await iScrollDown(tester);
      await iScrollDown(tester);
      await iScrollDown(tester);
      await iScrollDownTo(tester, 'Avez-vous aimé cette page ?');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Faire un retour sur une action''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Faire un retour sur une action''');
        await bddSetUp(tester);
        await iTapOnSemantics(tester, '4 étoiles sur 4');
        await iSee(tester,
            'Vos retours sont précieux et façonnent ce service. Partagez-nous vos impressions, nous nous efforcerons d’y répondre prochainement.');
        await iEnterInTheField(tester, 'Cette action est superbe.',
            'Comment pourrions-nous l’améliorer ?');
        await iScrollDownTo(tester, 'Envoyer');
        await iTapOn(tester, 'Envoyer');
        await iDontSee(tester, 'Envoyer');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "POST",
                "/utilisateurs/{userId}/actions/classique/action_comparer_elecgaz/feedback",
                200,
                {"like_level": 4, "feedback": "Cette action est superbe."}
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Faire un retour sur une action''',
          success,
        );
      }
    });
  });
}
