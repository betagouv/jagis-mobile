Feature: Save notification token
    Scenario: Login to my account is successful and notification token is saved
        Given I am logged in
        Given The application is launched
        Then The notification token save endpoint has been called
