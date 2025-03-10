Feature: Mes actions recommandées
    Background:
        Given I am logged in
        Given The application is launched
        When I scroll down to {'Découvrir'}

    Scenario: Voir les actions recommandées
        When I tap on {1} text {'Découvrir'}
        Then I see {'Mes actions recommandées'}

    Scenario: Voir la popup si la personnalisation n'a pas été faite
        When I tap on {1} text {'Découvrir'}
        Then I see {'Envie d’avoir un vrai impact ?'}

    Scenario: Commencer les questions
        When I tap on {1} text {'Découvrir'}
        When I scroll down to {'Commencer'}
        When I tap on {'Commencer'}
        Then I see {"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?"}

    Scenario: Répondre à toutes les questions
        When I tap on {1} text {'Découvrir'}
        When I scroll down to {'Commencer'}
        When I tap on {'Commencer'}
        Then I see {"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?"}
        When I tap on {"Oui"}
        When I tap on {"Question suivante"}
        Then I see {"Êtes-vous équipé(e) d’un vélo ?"}
        When I tap on {"Non"}
        Then I have theme with actions
        When I tap on {"Question suivante"}
        When I see {'Trouver le type de voiture qui vous convient le mieux'}

    Scenario: Refaire le questionnaire
        Given I have theme with no action
        When I tap on {1} text {'Découvrir'}
        Given I have theme with customization needed
        When I scroll down to {'Refaire'}
        When I tap on {'Refaire'}
        Then I see {'Envie d’avoir un vrai impact ?'}