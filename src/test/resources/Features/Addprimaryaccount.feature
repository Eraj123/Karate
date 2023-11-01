Feature: Add primary account

  Background: 
    * def gettoken = callonce read("Gettoken.feature")
    And print gettoken
    * def  token = gettoken.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create and add primary account
    And path "api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    * def getdata = Java.type('GeneretData.Data')
    * def DATA = getdata.Email()
    Then request
      """
      {
      "email": "#(DATA)",
      "firstName": "john",
      "lastName": "smith",
      "title": "Mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2023-10-30T23:35:24.031Z",
      "new": true
      }

      """
    When method post
    And status 201
    Then print response
    And assert response.email == DATA

  Scenario: Create an primary account with existing data
    And path "api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    * def getdata = Java.type('GeneretData.Data')
    * def DATA = getdata.Email()
    Then request
      """
      {
      "email": "mohammad@tekschool.us",
      "firstName": "john",
      "lastName": "smith",
      "title": "Mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2023-10-30T23:35:24.031Z",
      "new": true
      }

      """
    When method post
    And status 400
    Then print response
    And assert response.errorMessage == "Account with email mohammad@tekschool.us is exist"
