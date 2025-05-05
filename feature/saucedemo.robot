*** Settings ***
Documentation       Saucedemo web automation
Resource            ../steps/saucedemoStep.robot

*** Test Cases ***
User Successfully Add Item To Cart
    [Template]    User add item to cart
    #Item
    Sauce Labs Backpack
    Sauce Labs Fleece Jacket

User Successfully Open About Page
    Given user open browser and visit saucedemo page
    And user login with valid credential
    When user open hamburger menu
    And user click 'About' menu item
    Then user navigated to about page
    [Teardown]    Close Browser

*** Keywords ***
User add item to cart
    [Arguments]    ${item}
    Given user open browser and visit saucedemo page
    And user login with valid credential
    When user add '${item}' to cart
    Then user verify added item to cart
    [Teardown]    Close Browser