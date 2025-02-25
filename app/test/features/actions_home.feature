Feature: Par où souhaitez-vous commencer ?
    Background:
        Given initialize context
        Given I am logged in
        Given The application is launched

    Scenario: See proposals by theme
        Then I see {'D’après nos calculs, à Dole, voici ce que nous pouvons vous proposer :'}
