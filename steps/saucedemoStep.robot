*** Settings ***
Resource    ../pages/saucedemoPage.robot

*** Variables ***
${valid_username}    standard_user
${valid_password}    secret_sauce


*** Keywords ***
user add '${item}' to cart
    Add Item To Cart    item=${item}

user click '${menu}' menu item
    Click Menu item    ${menu}

user login with valid credential
    Input Username    username=${valid_username}
    Input Password    password=${valid_password}
    Click Login Button
    Verify Login Success

user navigated to about page
    Verify About Page Shown

user open browser and visit saucedemo page
    Open Browser And Visit Saucedemo Page

user open hamburger menu
    Click Hamburger Menu Button

user verify added item to cart
    Open Cart Menu
    Verify Item In Cart