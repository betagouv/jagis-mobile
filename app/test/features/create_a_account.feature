Feature: Create a account

  Background:
    Given The application is launched
    When I tap on {'Je crée mon compte'}

  Scenario: Successful account creation
    Given the email don't exists
    Then I see {'Créer mon compte'}
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I tap on create my account button
    Then I see {'Vérifiez votre boîte e-mail'}
    When I'm redirect to magic link callback
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance…'}

  Scenario: See the error message when the email already exists
    Given the email already exists
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I tap on create my account button
    Then I see {'Adresse électronique joe@doe.fr déjà existante'}
