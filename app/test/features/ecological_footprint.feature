Feature: Ecological footprint

  Background:
    Given I am logged in

  Scenario: Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé
    Given the API will return
      | 'method' | 'path'                              | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                               |
      | 'GET'    | '/utilisateurs/{userId}/home_board' |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":39,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86} |
    Given The application is launched
    Then I see {'Calculer mon\nempreinte écologique'}
    Then I see {'39%'}

  Scenario: Voir son empreinte écologique lorsqu'il est terminé
    Given the API will return
      | 'method' | 'path'                              | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                |
      | 'GET'    | '/utilisateurs/{userId}/home_board' |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":100,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86} |
    Given The application is launched
    Then I see {'Mon empreinte\nécologique'}
    Then I see {'8t\nde CO2e/an'}

  Scenario: Répondre à une question liées à mon empreinte écologique lorsque je reviens en arrière alors le pourcentage doit être mis à jour
    Given the API will return
      | 'method' | 'path'                                                                                      | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 'GET'    | '/utilisateurs/{userId}/home_board'                                                         |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":39,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86}                                                                                                                                                                                      |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_bilan_transport'       |          200 | [{"code":"KYC_transport_avion_3_annees","question":"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false},{"code":"ne_sais_pas","label":"Je ne sais pas","selected":false}],"is_answered":false,"categorie":"mission","points":5,"type":"choix_unique","is_NGC":true,"thematique":"transport"}]                                                                                                                                                                      |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_bilan_transport/first' |          200 | {"nombre_total_questions":13,"nombre_total_questions_effectives":11,"position_courante":1,"question_courante":{"code":"KYC_transport_avion_3_annees","question":"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false},{"code":"ne_sais_pas","label":"Je ne sais pas","selected":false}],"is_answered":false,"categorie":"mission","points":5,"type":"choix_unique","is_NGC":true,"thematique":"transport"},"is_first":true,"is_last":false,"is_out_of_range":false} |
      | 'GET'    | '/utilisateurs/{userId}/questionsKYC_v2/KYC_transport_avion_3_annees'                       |          200 | {"code":"KYC_transport_avion_3_annees","question":"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?","reponse_multiple":[{"code":"oui","label":"Oui","selected":false},{"code":"non","label":"Non","selected":false},{"code":"ne_sais_pas","label":"Je ne sais pas","selected":false}],"is_answered":false,"categorie":"mission","points":5,"type":"choix_unique","is_NGC":true,"thematique":"transport"}                                                                                                                                                                        |
    Given The application is launched
    Then I see {'39%'}
    When I tap on {'Calculer mon\nempreinte écologique'}
    When I tap on {'Transport'}
    When I tap on {'Oui'}
    When I go back
    Given the API will return
      | 'method' | 'path'                              | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                               |
      | 'GET'    | '/utilisateurs/{userId}/home_board' |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":69,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86} |
    When I go back
    Then I see {'69%'}
