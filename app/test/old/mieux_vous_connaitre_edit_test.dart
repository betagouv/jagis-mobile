import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/step/i_enter_in_the_field.dart';
import '../features/step/i_see.dart';
import '../features/step/i_tap_on.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';
import 'steps/set_up_widgets.dart';

void main() {
  testWidgets('Aller sur la page de la question libre', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'code': 'KYC005',
        'type': 'libre',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    await iSee(tester, question);
    await iSee(tester, reponse);
  });

  testWidgets('Modifier la réponse à une question libre', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    const nouvelleReponse = "Je n'ai pas d'emploi";
    await iEnterInTheField(tester, nouvelleReponse, Localisation.maReponse);
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, nouvelleReponse);
  });

  testWidgets('Modifier la réponse à une question entier', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = '10000';
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    const nouvelleReponse = '1000';
    await iEnterInTheField(tester, nouvelleReponse, Localisation.maReponse);
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, nouvelleReponse);
  });

  testWidgets('Ne pas modifier la réponse à une question entier', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = '10000';
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    const nouvelleReponse = 'Michel';
    await iEnterInTheField(tester, nouvelleReponse, Localisation.maReponse);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, reponse);
    ielNeVoitPasLeTexte(nouvelleReponse);
  });

  testWidgets('Valider sans mettre à jour', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, reponse);
  });

  testWidgets('Modifier la réponse à une question choix unique', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    const nouvelleReponse = "Je n'ai pas d'emploi";
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_unique',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse, 'selected': true},
          {'code': '', 'label': nouvelleReponse, 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    await iTapOn(tester, nouvelleReponse);
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_unique',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse, 'selected': false},
          {'code': '', 'label': nouvelleReponse, 'selected': true},
        ],
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, nouvelleReponse);
  });

  testWidgets('Modifier la réponse à une question choix multiple', (final tester) async {
    setUpWidgets(tester);
    const question = 'Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?';
    const reponses = ['Famille ou génération future', 'Conscience écologique'];
    const reponseEnPlus = 'Économies financières';

    leServeurRetourneCesQuestions([
      {
        'type': 'choix_multiple',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponses.first, 'selected': true},
          {'code': '', 'label': reponses[1], 'selected': true},
          {'code': '', 'label': reponseEnPlus, 'selected': false},
          {'code': '', 'label': 'Autre raison', 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    await iTapOn(tester, reponseEnPlus);
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_multiple',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponses.first, 'selected': true},
          {'code': '', 'label': reponses[1], 'selected': true},
          {'code': '', 'label': reponseEnPlus, 'selected': true},
          {'code': '', 'label': 'Autre raison', 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, [...reponses, reponseEnPlus].join(' - '));
  });

  testWidgets('Modifier plusieurs questions', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';

    const question2 = 'Qui joue en première base ?';
    const reponse2 = 'Personne ne joue en première base';
    const nouvelleReponse2 = "C'est qui qui qui joue en première base";
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': true},
          {'code': '', 'label': nouvelleReponse2, 'selected': false},
        ],
        'points': 5,
      },
    ]);

    await _allerSurMieuxVousConnaitre(tester);
    await iTapOn(tester, question);
    const nouvelleReponse = "Je n'ai pas d'emploi";
    await iEnterInTheField(tester, nouvelleReponse, Localisation.maReponse);
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': true},
          {'code': '', 'label': nouvelleReponse2, 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, nouvelleReponse);
    await iTapOn(tester, question2);
    await iTapOn(tester, nouvelleReponse2);
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': false},
          {'code': '', 'label': nouvelleReponse2, 'selected': true},
        ],
        'points': 5,
      },
    ]);
    await iTapOn(tester, Localisation.mettreAJour);
    await iSee(tester, Localisation.mieuxVousConnaitre);
    await iSee(tester, nouvelleReponse2);
  });
}

Future<void> _allerSurMieuxVousConnaitre(final WidgetTester tester) async {
  ielEstConnecte();

  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await iTapOn(tester, Localisation.monProfil);
  await iTapOn(tester, Localisation.mieuxVousConnaitre);
}
