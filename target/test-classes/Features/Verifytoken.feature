Feature: Verify token

  Background: 
    * def gettoken = callonce read("Gettoken.feature")
    Then print gettoken
    * def token = gettoken.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify the token that is valid
    And path "api/token/verify"
    Then param token = token
    And param  username = "Supervisor"
    Then method get
    When status 200
    Then print response
    And assert response.message == "Token is valid"

  Scenario: Verify the token with invalid username
    And path "api/token/verify"
    Then param token = token
    And param  username = "super"
    Then method get
    When status 400
    Then print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  Scenario: Verify the token with invalid token
    And path "api/token/verify"
    Then param token = "Wrong token"
    And param  username = "Supervisor"
    Then method get
    When status 400
    Then print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
