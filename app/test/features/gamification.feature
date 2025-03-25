Feature: Gamification

  Scenario: Voir le points au lancement de l'application
    Given I am logged in
    Given The application is launched
    Then I see {'650'} points

  Scenario: Voir le popup de reset si c'est un ancien compte
    Given I am logged in
    Given the API will return
      | 'method' | 'path'                                                | 'statusCode' | 'responseData'                                                           |
      | 'GET'    | '/utilisateurs/{userId}'                              |          200 | {"pseudo":"Lucas","is_onboarding_done":true,"popup_reset_est_vue":false} |
      | "POST"   | "/utilisateurs/{userId}/gamification/popup_reset_vue" |          200 | {}                                                                       |
    Given The application is launched
    Then I see {'Il y a du nouveau sur J’agis !'}
    When I tap on {'Continuer'}
    Then I see {'Merci pour votre soutien !'}
    When I tap on {'Récolter'}
    Then the API receives
      | 'method' | 'path'                                                | 'statusCode' | 'requestData' |
      | "POST"   | "/utilisateurs/{userId}/gamification/popup_reset_vue" |          200 | null          |
    Then I don't see {'Merci pour votre soutien !'}
