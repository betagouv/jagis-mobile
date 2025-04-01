Feature: France Connect

  Scenario: Login with FranceConnect is successful
    Given The application is launched
    # TODO(lsaudon): à réactiver quand ce sera prêt côté backend
    # When I tap on {"J’ai déjà un compte"}
    # When I tap on {"FranceConnect"}
    # When I'm redirect to FranceConnect callback
    # Then I see {'Bienvenue sur J’agis ! Faisons connaissance…'}

  Scenario: Login with FranceConnect is cancelled
    Given The application is launched
    # TODO(lsaudon): à réactiver quand ce sera prêt côté backend
    # When I tap on {"J’ai déjà un compte"}
    # When I tap on {"FranceConnect"}
    # When I'm redirect to FranceConnect callback cancelled
    # Then I see {'J’ai déjà un compte'}
