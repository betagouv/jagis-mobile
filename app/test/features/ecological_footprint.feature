Feature: Ecological footprint

  Background:
    Given I am logged in

  Scenario: Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé
    Given the API will return
      | 'method' | 'path'                              | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                |
      | 'GET'    | '/utilisateurs/{userId}/home_board' |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":39,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86} |
    Given The application is launched
    Then I see {'Calculer mon\nempreinte écologique'}
    Then I see {'39%'}

  Scenario: Voir son empreinte écologique lorsqu'il est pas terminé
    Given the API will return
      | 'method' | 'path'                              | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                |
      | 'GET'    | '/utilisateurs/{userId}/home_board' |          200 | {"nom_commune":"Lyon","total_national_actions_faites":36,"total_utilisateur_actions_faites":3,"pourcentage_bilan_done":100,"nombre_aides":12,"nombre_recettes":1150,"bilan_carbone_total_kg":7569.006294661004,"pourcentage_alimentation_reco_done":100,"pourcentage_consommation_reco_done":100,"pourcentage_logement_reco_done":100,"pourcentage_transport_reco_done":33,"pourcentage_global_reco_done":86} |
    Given The application is launched
    Then I see {'Mon empreinte\nécologique'}
    Then I see {'8t\nde CO2e/an'}