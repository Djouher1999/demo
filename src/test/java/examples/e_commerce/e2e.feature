Feature: ajouter produit

Background:
    * url 'https://api.efi-academy.com/user-api/public'

    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def name = faker.name().name()
    * def email = faker.internet().emailAddress()
    * def password = faker.internet().password()
    * def randomNum = faker.number().numberBetween(0, 100)
    * def role = randomNum < 40 ? 'user' : 'admin'
    * def randomStock = faker.number().numberBetween(10, 50)
    * def randomPrix = faker.number().numberBetween(200, 1000)
    * def imageUrl = faker.avatar().image()

@ecommerce
Scenario: creer compte et ajout produit
    * def register =
      """
        {
          "name": "#(name)",
          "email": "#(email)",
          "password": "#(password)",
          "role": "#(role)"
        }
      """
    
    # post
    Given path 'register'
    And request register
    When method post
    Then status 201

    * def reponse = response

    * def connecter =
      """
        {
          "email": "#(register.email)",
          "password": "#(register.password)",
        }
      """
    
    # post
    Given path 'login'
    And request connecter
    When method post
    Then status 200
    * def reponse = response

    * def token = reponse.token

    * def produit =
      """
        {
        "name": "Webcam HD",
        "description": "Webcam 1080p",
        "price": "#(randomPrix)",
        "stock": "#(randomStock)",
        "image_url": "#(imageUrl)"
        }
      """
    
    # post
    Given path 'products'
    And header Authorization = 'Bearer ' + token
    And request produit
    When method post
    * def expectedStatus = register.role == 'admin' ? 201 : 403
    * match responseStatus == expectedStatus

    