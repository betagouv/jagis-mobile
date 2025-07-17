Feature: Actions

  Background:
    Given I am logged in
    Given The application is launched
    When I tap on the menu button

  Scenario: See all actions
    Given I have actions in my library
      | 'type'      | 'code' | 'title'                                        | 'nb_aids_available' |
      | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**'    |                   2 |
      | 'classique' | '2'    | 'Contribuer à la **bonne santé de son sol**'   |                   0 |
      | 'classique' | '3'    | 'Tester une **nouvelle recette végétarienne**' |                   1 |
    When I tap on {'Actions'}
    Then I see {'🌧️ Contribuer à la bonne santé de son sol'}
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I see {'🌧️ Faire réparer une paire de chaussures'}
    Then I don't see {'0 aide'}
    Then I see {'1 aide'}
    Then I see {'2 aides'}

  Scenario: Filter actions by title
    Given I have actions in my library
      | 'type'      | 'code' | 'title'                                        | 'nb_aids_available' |
      | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**'    |                   2 |
      | 'classique' | '2'    | 'Contribuer à la **bonne santé de son sol**'   |                   0 |
      | 'classique' | '3'    | 'Tester une **nouvelle recette végétarienne**' |                   1 |
    When I tap on {'Actions'}
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I see {'🌧️ Faire réparer une paire de chaussures'}
    When I enter {'végétarienne'} in the search by title field actions
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I don't see {'Faire réparer une paire de chaussures'}

  Scenario: Filter actions by theme
    Given I have actions in my library
      | 'type'      | 'code' | 'title'                                        | 'nb_aids_available' |
      | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**'    |                   2 |
      | 'classique' | '2'    | 'Contribuer à la **bonne santé de son sol**'   |                   0 |
      | 'classique' | '3'    | 'Tester une **nouvelle recette végétarienne**' |                   1 |
    When I tap on {'Actions'}
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I see {'🌧️ Faire réparer une paire de chaussures'}
    When I filter with {'🥦 Alimentation'} action theme
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I don't see {'Faire réparer une paire de chaussures'}

  Scenario: Filter actions by already consulted
    Given I have actions in my library
      | 'type'      | 'code' | 'title'                                        | 'nb_aids_available' |
      | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**'    |                   2 |
      | 'classique' | '2'    | 'Contribuer à la **bonne santé de son sol**'   |                   0 |
      | 'classique' | '3'    | 'Tester une **nouvelle recette végétarienne**' |                   1 |
    When I tap on {'Actions'}
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I see {'🌧️ Faire réparer une paire de chaussures'}
    When I filter by {'Déjà consultées'} action
    Then I see {'🌧️ Tester une nouvelle recette végétarienne'}
    Then I don't see {'Faire réparer une paire de chaussures'}

  Scenario: Go to details action classic
    Given I have actions in my library
      | 'type'      | 'code' | 'title'                                     | 'nb_aids_available' |
      | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**' |                   2 |
    Given I have action detail in my library
      | 'id' | 'title'                                     | 'subTitle'                                                                   | 'how'                                                                                                                                                                                                                                                                                                                          | 'why'                                                                                                                                                                                                                                                                                                       | 'service_id'        | 'service_category' |
      | '1'  | 'Faire réparer une **paire de chaussures**' | 'Faites des économies en donnant une seconde vie à vos paires de chaussures' | '# Nos astuces\n\n- **Choisissez un cordonnier agréé** : pour profiter de l’aide d’État sur vos réparations\n\n- **Bottes, chaussures de ski, baskets** : toutes les chaussures sont éligibles\n\n- **Si vos chaussures sont trop abimées** : Déposez-les dans un point de collecte pour que valoriser les matériaux utilisés' | '# En quelques mots\n\n- Pour chaque paire de chaussure réparée, vous économisez **entre 20 et 60€**\n\n- Les paires de chaussures jetées représentent plusieurs **milliers de tonnes** de déchets généralement non recyclables. \n\n- Chaque année, un Français achète en moyenne 4 paires de chaussures.' | 'longue_vie_objets' | 'reparer'          |
    Given I have lvao services in my library
    When I tap on {'Actions'}
    When I tap on {'🌧️ Faire réparer une paire de chaussures'}
    Then I see {'Faites des économies en donnant une seconde vie à vos paires de chaussures'}
