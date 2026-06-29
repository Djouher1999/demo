Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get all users and then get the first user by idpost
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200


    @post
  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com", 
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

* def reponse = response

    And match reponse.name == user.name
    And match reponse.email == user.email
    And match reponse.username == user.username
    And match reponse.address.street == user.address.street
    And match reponse.address.suite == user.address.suite
    And match reponse.address.city == user.address.city
    And match reponse.address.zipcode == user.address.zipcode
    
    # When method get
    # Then status 200
    # And match response contains user

    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then status 200

    Given path reponse.id
    When method get
    Then status 200


  