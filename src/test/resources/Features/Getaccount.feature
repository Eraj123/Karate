Feature: Get account

  Background: 
    * def gettoken = callonce read("Gettoken.feature")
    And print gettoken
    * def token = gettoken.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get an existing account
    And path "api/accounts/get-account"
    Then header Authorization = "Bearer " + token
    When param  primaryPersonId = 1098
    And method get
    Then status 200
    And print response

  Scenario: Get an unexisting account
    And path "api/accounts/get-account"
    Then header Authorization = "Bearer " + token
    When param  primaryPersonId = 56565
    And method get
    Then status 404
    And print response
    Then assert response.errorMessage == "Account with id 56565 not found"
