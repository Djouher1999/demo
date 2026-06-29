Feature: ajouter produit

Background:
    * url 'https://api.efi-academy.com/user-api/public'

    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def slugrandom = faker.internet().slug() 
@brand1
Scenario: creer et modifier brand
    * def brand =
      """
        {
          "name": "Jean Dupont",
          "email": "jean@example.com",
          "password": "secret123",
          "role": "user"
        }
      """
    
    # post
    Given path 'brands'
    And request brand
    When method post
    Then status 201

    * def reponse = response
