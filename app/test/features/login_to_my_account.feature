Feature: Login to my account

  Scenario: Login to my account is successful
    Given The application is launched
    When I tap on {"J’ai déjà un compte"}
    Then I see {'Connexion à J’agis'}
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I tap on login button
    Then I see {'Vérifiez votre boîte e-mail'}
    When I tap on {"Rentrer le code manuellement"}
    Then I see {'Entrez le code reçu par e-mail !'}
    When I enter {'999999'} in the pin field
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance…'}

  Scenario: Login with magic link
    Given The application is launched
    When I tap on {"J’ai déjà un compte"}
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I tap on login button
    Then I see {'Vérifiez votre boîte e-mail'}
    When I'm redirect to magic link callback
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance…'}

  Scenario: Already logged in
    Given I am logged in
    Given The application is launched
    Then I see the home page

  Scenario: Logout
    Given I am logged in
    Given The application is launched
    When I tap on the menu button
    When I tap on {'Se déconnecter'}
    Then I see {'Ensemble, améliorons nos habitudes au jour le jour'}
