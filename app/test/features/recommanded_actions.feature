Feature: Mes actions recommandées
    Background:
        Given I am logged in
        Given The application is launched
        Given I tap on {'🍛 Me nourrir'}

    Scenario: La première fois que j'arrive sur la page Me nourrir alors la popup s'affiche
        Then I see {"Envie d’avoir un vrai impact ?"}
