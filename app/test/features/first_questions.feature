Feature: Onboarding

  Background:
    Given The application is launched
    Given the email don't exists
    When I tap on {'Je crée mon compte'}
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I accept the terms of use
    When I tap on create my account button
    When I enter {'999999'} in the pin field

  Scenario: Répondre aux premieres questions
    When I enter {'Joe'} in the {'Mon pseudonyme'} field
    When I scroll down to {'Ma date de naissance'}
    When I select {'15/01/1974'} date in the {'Ma date de naissance'} field
    When I tap on {'Continuer'}
    Then I see {'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.'}
    When I enter {'39100'} in the {'Code postal'} field
    When I select {'DOLE'} in the {'Commune'} field
    When I tap on {'Continuer'}
    Then I see {'J’agis est encore en expérimentation !'}
    When I tap on {'J’ai compris'}
    Then I see {'C’est presque terminé !'}
    When I tap on {'La cuisine et l’alimentation'}
    When I tap on {'Continuer'}
    Then I see {'Tout est prêt !'}
    When I tap on {'C’est parti !'}
    Then I see the home page

  Scenario: Saisir un pseudonyme invalide
    When I enter {'123'} in the {'Mon pseudonyme'} field
    Then I see {'Le pseudonyme n’est pas valide.'}

  Scenario: Saisir un pseudonyme valide et recevoir une erreur de l'API
    Given the API will return
      | 'method' | 'path'                           | 'statusCode' | 'responseData'                            |
      | "PATCH"  | "/utilisateurs/{userId}/profile" |          400 | { "message": "Une erreur est survenue." } |
    When I enter {'Lucas'} in the {'Mon pseudonyme'} field
    When I scroll down to {'Ma date de naissance'}
    When I select {'15/01/1974'} date in the {'Ma date de naissance'} field
    When I tap on {'Continuer'}
    Then I see {'Une erreur est survenue.'}

  Scenario: Vérifier l'accessibilité sur la page du pseudonyme
    Then I see {'Question 1 sur 3'} semantics
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance…'} semantics
    Then I see {'Nous avons quelques questions à vous poser pour personnaliser votre expérience !'} semantics
    Then I see {'Mon pseudonyme'} semantics
    Then I see {'Continuer'} semantics
