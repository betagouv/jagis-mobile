Feature: My home

  Background:
    Given I am logged in
    Given The application is launched
    When I tap on the menu button
    When I tap on {'Mon profil'}

  Scenario: Voir la page avec les informations minimales
    Given the API will return
      | 'method' | 'path'                            | 'statusCode' | 'responseData'                                                                                                   |
      | 'GET'    | '/utilisateurs/{userId}/logement' |          200 | {"code_postal":"38280","commune":"Villette-d'Anthon","commune_label":"Villette-d'Anthon","code_commune":"38557"} |
      | 'GET'    | '/communes?code_postal=38280'     |          200 | ["ANTHON","JANNEYRIAS","VILLETTE D ANTHON"]                                                                      |
    When I tap on {'Mon logement'}
    Then I see {'38280'}
    Then I see {"Villette-d'Anthon"}

  Scenario: Mettre à jour
    Given the API will return
      | 'method' | 'path'                            | 'statusCode' | 'responseData'                                                                                                   |
      | 'GET'    | '/utilisateurs/{userId}/logement' |          200 | {"code_postal":"38280","commune":"Villette-d'Anthon","commune_label":"Villette-d'Anthon","code_commune":"38557"} |
      | 'GET'    | '/communes?code_postal=38280'     |          200 | ["ANTHON","JANNEYRIAS","VILLETTE D ANTHON"]                                                                      |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {}                                                                                                               |
    When I tap on {'Mon logement'}
    When I scroll down to {'Un appartement'}
    When I tap on {'Un appartement'}
    When I tap on {'Mettre à jour mes informations'}
    Then the API receive
      | 'method' | 'path'                            | 'statusCode' | 'requestData'                                                        |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {"code_postal":"38280","code_commune":"38557","type":"appartement",} |

  Scenario: Supprimer mon adresse
    Given the API will return
      | 'method' | 'path'                            | 'statusCode' | 'responseData'                                                                                                                                                                                      |
      | 'GET'    | '/utilisateurs/{userId}/logement' |          200 | {"code_postal":"38280","commune":"Villette-d'Anthon","rue":"Rue des Cyprès","numero_rue":"36","longitude":5.115947,"latitude":45.793095,"commune_label":"Villette-d'Anthon","code_commune":"38557"} |
      | 'GET'    | '/communes?code_postal=38280'     |          200 | ["ANTHON","JANNEYRIAS","VILLETTE D ANTHON"]                                                                                                                                                         |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {}                                                                                                                                                                                                  |
    When I tap on {'Mon logement'}
    Then I see {"36 Rue des Cyprès 38280 Villette-d'Anthon"}
    When I tap on {'Supprimer mon adresse'}
    Then the API receive
      | 'method' | 'path'                            | 'statusCode' | 'requestData'                                                   |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {"latitude":null,"longitude":null,"numero_rue":null,"rue":null} |

  Scenario: Mettre l'adresse complète
    Given the API will return
      | 'method' | 'path'                            | 'statusCode' | 'responseData'                                                                                                                                                                                      |
      | 'GET'    | '/utilisateurs/{userId}/logement' |          200 | {"code_postal":"38280","commune":"Villette-d'Anthon","rue":"Rue des Cyprès","numero_rue":"36","longitude":5.115947,"latitude":45.793095,"commune_label":"Villette-d'Anthon","code_commune":"38557"} |
      | 'GET'    | '/communes?code_postal=38280'     |          200 | ["ANTHON","JANNEYRIAS","VILLETTE D ANTHON"]                                                                                                                                                         |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {}                                                                                                                                                                                                  |
    When I tap on {'Mon logement'}
    When I enter {"110 Rue Garibaldi"} in the autocomplete field
    When I tap on {'110 Rue Garibaldi 69006 Lyon'}
    When I tap on {'Mettre à jour mes informations'}
    Then the API receive
      | 'method' | 'path'                            | 'statusCode' | 'requestData'                                                                                                                     |
      | 'PATCH'  | '/utilisateurs/{userId}/logement' |          200 | {"latitude":45.766368,"longitude":4.850666,"numero_rue":"110","rue":"Rue Garibaldi","code_postal":"69006","code_commune":"69386"} |
