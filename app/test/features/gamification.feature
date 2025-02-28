Feature: Gamification
  Scenario: View points at application startup
    Given I am logged in
    Given The application is launched
    Then I see {'650'} points