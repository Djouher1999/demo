Feature: test script

Background:
    * url 'https://api.practicesoftwaretesting.com'

    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def slugrandom = faker.internet().slug() 
    * def slugrandom2 = faker.internet().slug() 

@brand1
Scenario: creer et modifier brand
    * def brand =
      """
        {
        "name": "new brand",
        "slug": "#(slugrandom)"
        }
      """
    
    # post
    Given path 'brands'
    And request brand
    When method post
    Then status 201

    * def reponse = response

    And match reponse.name == brand.name
    And match reponse.slug == brand.slug

    # UPDATE 
    * def updatedBrand =
    """
        {
        "name": "updated brand",
        "slug": "#(slugrandom2)"
        }
    """
    Given path 'brands', reponse.id
    And request updatedBrand
    When method put
    Then status 200

    And match response.success == true

    # get by ID
    Given path 'brands', reponse.id
    When method get
    Then status 200
    And match response.id == reponse.id
    And match response.name == updatedBrand.name
    And match response.slug == updatedBrand.slug



