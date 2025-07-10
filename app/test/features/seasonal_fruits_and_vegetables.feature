Feature: Seasonal fruits and vegetables service

  Background:
    Given I am logged in
    Given the API will return
      | 'method' | 'path'                                                                                                    | 'statusCode' | 'responseData'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 'GET'    | '/utilisateurs/%7BuserId%7D/aides_v2?thematique=alimentation'                                             |          200 | {"couverture_aides_ok":false,"liste_aides":[]}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 'GET'    | '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_alimentation/first' |          200 | {"nombre_total_questions":4,"nombre_total_questions_effectives":4,"position_courante":3,"question_courante":{"code":"MOSAIC_REDUCTION_DECHETS","question":"Quels éco-gestes mettez-vous en place pour réduire vos déchets ?","reponse_multiple":[{"code":"KYC_alimentation_compostage","label":"Compostage biodéchets","emoji":null,"image_url":"https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png","selected":false},{"code":"KYC_alimentation_reduc_gaspi_alim","label":"Réduire gaspillage alimentaire","emoji":null,"image_url":"https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png","selected":false},{"code":"KYC_alimentation_stoppub","label":"Stop pub","emoji":null,"image_url":"https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png","selected":true},{"code":"KYC_alimentation_achat_vrac","label":"Achat en vrac","emoji":null,"image_url":"https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png","selected":false}],"is_answered":true,"categorie":"mission","points":5,"type":"mosaic_boolean","is_NGC":false,"thematique":"dechet"},"is_first":false,"is_last":false,"is_out_of_range":false} |
    Given The application is launched
    When I tap on {1} text {'🍛 Me nourrir'}
    When I scroll down to {'Les fruits et légumes de septembre'}
    When I tap on {'Les fruits et légumes de septembre'}

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
