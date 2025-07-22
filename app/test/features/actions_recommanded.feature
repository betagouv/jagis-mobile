Feature: Mes actions recommandées

  Background:
    Given I am logged in
    Given the API will return
      | 'method' | 'path'                                                                                                                                 | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 'GET'    | '/utilisateurs/%7BuserId%7D/aides_v2?thematique=transport'                                                                             |          200 | {"couverture_aides_ok":false,"liste_aides":[]}                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/first'                                 |          200 | {"nombre_total_questions":3,"nombre_total_questions_effectives":3,"position_courante":2,"question_courante":{"code":"KYC003","question":"Êtes-vous équipé(e) d’un vélo ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false}],"is_answered":false,"categorie":"mission","points":5,"type":"choix_unique","is_NGC":false,"thematique":"transport"},"is_first":false,"is_last":false,"is_out_of_range":false}                        |
      | 'GET'    | '/utilisateurs/{userId}/questionsKYC_v2/KYC003'                                                                                        |          200 | {"code":"KYC003","question":"Êtes-vous équipé(e) d’un vélo ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false}],"is_answered":false,"categorie":"mission","points":5,"type":"choix_unique","is_NGC":false,"thematique":"transport"}                                                                                                                                                                                              |
      | "PUT"    | '/utilisateurs/{userId}/questionsKYC_v2/KYC003'                                                                                        |          200 | {}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | 'POST'   | '/utilisateurs/{userId}/questionsKYC_v2/KYC003/skip'                                                                                   |          200 | {}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/following/KYC003'                      |          200 | {"nombre_total_questions":3,"nombre_total_questions_effectives":3,"position_courante":3,"question_courante":{"code":"KYC_possede_voiture_oui_non","question":"Possédez-vous une voiture ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false}],"is_answered":false,"categorie":"recommandation","points":5,"type":"choix_unique","is_NGC":false,"thematique":"transport"},"is_first":false,"is_last":true,"is_out_of_range":false} |
      | 'GET'    | '/utilisateurs/{userId}/questionsKYC_v2/KYC_possede_voiture_oui_non'                                                                   |          200 | {"code":"KYC_possede_voiture_oui_non","question":"Possédez-vous une voiture ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false}],"is_answered":false,"categorie":"recommandation","points":5,"type":"choix_unique","is_NGC":false,"thematique":"transport"}                                                                                                                                                                      |
      | "PUT"    | '/utilisateurs/{userId}/questionsKYC_v2/KYC_possede_voiture_oui_non'                                                                   |          200 | {}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/following/KYC_possede_voiture_oui_non' |          200 | {"nombre_total_questions":3,"nombre_total_questions_effectives":3,"position_courante":-1,"is_first":false,"is_last":true,"is_out_of_range":false}                                                                                                                                                                                                                                                                                                                                               |
    Given The application is launched

  Scenario: Voir la popup si la personnalisation n'a pas été faite
    When I tap on {1} text {'🚅 Me déplacer'}
    Then I see {'3 questions pour…'}

  Scenario: Commencer les questions
    When I tap on {1} text {'🚅 Me déplacer'}
    When I scroll down to {'Commencer'}
    When I tap on {'Commencer'}
    Then I see {"Êtes-vous équipé(e) d’un vélo ?"}

  Scenario: Répondre à toutes les questions
    When I tap on {1} text {'🚅 Me déplacer'}
    When I scroll down to {'Commencer'}
    When I tap on {'Commencer'}
    When I tap on {'Non'}
    When I tap on {"Question suivante"}
    When I tap on {'Non'}
    Then I have theme with actions
    When I tap on {"Question suivante"}
    When I see {'🌧️ Trouver le type de voiture qui vous convient le mieux'}

  Scenario: Passez une question
    When I tap on {1} text {'🚅 Me déplacer'}
    When I scroll down to {'Commencer'}
    When I tap on {'Commencer'}
    When I tap on {"Passer la question"}
    Then the API receive
      | 'method' | 'path'                                               | 'statusCode' | 'requestData' |
      | 'POST'   | '/utilisateurs/{userId}/questionsKYC_v2/KYC003/skip' |          200 | null          |

  Scenario: Refaire le questionnaire
    Given I have theme with no action
    When I tap on {1} text {'🚅 Me déplacer'}
    Given I have theme with customization needed
    When I scroll down to {'Refaire'}
    When I tap on {'Refaire'}
    Then I see {'3 questions pour…'}
