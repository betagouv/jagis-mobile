Feature: Mes actions recommandées
    Background:
        Given I am logged in
        Given The application is launched
        When I scroll down to {'Découvrir'}
        When I tap on {1} text {'Découvrir'}

    Scenario: Voir les actions recommandées
        Then I see {'Mes actions recommandées'}

    Scenario: Voir la popup si la personnalisation n'a pas été faite
        Then I see {'Envie d’avoir un vrai impact ?'}

    Scenario: Commencer les questions
        When I scroll down to {'Commencer'}
        When I tap on {'Commencer'}
        Then I see {"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?"}

    Scenario: Répondre à toutes les questions
        When I scroll down to {'Commencer'}
        When I tap on {'Commencer'}
        Then I see {"Avez-vous pris l'avion au moins une fois ces 3 dernières années ?"}
        When I tap on {"Oui"}
        When I tap on {"Question suivante"}
        Then I see {"Êtes-vous équipé(e) d’un vélo ?"}
        When I tap on {"Non"}
        When I tap on {"Question suivante"}