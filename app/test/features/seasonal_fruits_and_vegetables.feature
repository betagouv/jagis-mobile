Feature: Seasonal fruits and vegetables service

  Background:
    Given I am logged in
    Given The application is launched
    When I tap on {'🍛 Me nourrir'}
    When I tap on {'1 calendrier de fruits et légumes de saison'}

  Scenario: See seasonal fruits and vegetables
    Then I see {'Les fruits et légumes pour le mois de'}
    Then I see {'janvier'}
    Then I see {'Poire'}
    Then I don't see {'Fraise'}

  Scenario: Change the month to view different seasonal fruits and vegetables
    When I tap on {'janvier'}
    When I tap on {'juin'}
    Then I see {'Fraise'}
    Then I don't see {'Poire'}
