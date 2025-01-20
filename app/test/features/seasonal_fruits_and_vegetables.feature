Feature: Seasonal fruits and vegetables service
  Background:
    Given initialize context
    Given I am logged in
    Given The application is launched

  Scenario: See seasonal fruits and vegetables
    When I tap on {'Me nourrir'}
    When I scroll down
    When I tap on {'Fruits et légumes de saison'}
    Then I see {'Les fruits et légumes pour le mois de'}
