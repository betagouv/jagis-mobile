Feature: User

  Scenario: On voit le pseudonyme sur la page d'accueil
    Given I am logged in
    Given The application is launched
    Then I see {'Bonjour Joe,'}
