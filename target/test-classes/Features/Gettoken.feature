Feature: gettoken

  Scenario: Validate and Verify user request
    Given url "https://tek-insurance-api.azurewebsites.net"
    Then path "/api/token"
    And request
      """
      {
      "username": "Supervisor",
      "password": "tek_supervisor"
      }
      """
    When method post
    Then status 200
    And print response
    Then assert response.username == "SUPERVISOR"
