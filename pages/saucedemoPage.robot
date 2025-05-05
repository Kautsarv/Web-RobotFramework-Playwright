*** Settings ***
Library         Browser    timeout=30s
Library         OperatingSystem
Library         String

*** Variables ***
${BROWSER}              Chromium
${HEADLESS}             false
${PAGE_URL}             https://www.saucedemo.com/

${btn_about}                id=about_sidebar_link
${btn_all_items}            id=inventory_sidebar_link
${btn_cart}                 id=shopping_cart_container
${btn_hamburger_menu}       id=react-burger-menu-btn
${btn_login}                id=login-button
${btn_logout}               id=logout_sidebar_link
${btn_reset_app_state}      id=reset_sidebar_link
${cart_contents}            id=cart_contents_container
${input_password}           id=password
${input_username}           id=user-name
${inventory_list}           xpath=//div[@class="inventory_list"]
${lbl_cart_item}            xpath=//div[@data-test="inventory-item-name"]
${lbl_cart_item_desc}       xpath=//div[@data-test="inventory-item-desc"]
${savedItem}
${savedItemDesc}

*** Keywords ***
Add Item To Cart
    [Arguments]    ${item}
    ${itemLowerCase} =	Convert To Lowercase	${item}
    ${itemID} =    Replace String    string=${itemLowerCase}    search_for=${SPACE}    replace_with=-
    Click    selector=id=add-to-cart-${itemID}
    ${savedItemDesc}    Get Text    selector=xpath=//div[text()='${item}']/parent::a/following-sibling::div[@data-test="inventory-item-desc"]
    Set Test Variable    ${savedItem}    ${item}
    Set Test Variable    ${savedItemDesc}    ${savedItemDesc}

Click Hamburger Menu Button
    Click    selector=${btn_hamburger_menu}
    Get Attribute     selector=xpath=//div[@class="bm-menu-wrap"]    attribute=aria-hidden    assertion_operator=equal    assertion_expected=false

Click Login Button
    Click    selector=${btn_login}

Click Menu item
    [Arguments]    ${menu}
    IF    '${menu}' == 'All Items'
        Click    selector=${btn_all_items}
    ELSE IF    '${menu}' == 'About'
        Click    selector=${btn_about}
    ELSE IF    '${menu}' == 'Logout'
        Click    selector=${btn_logout}
    ELSE IF    '${menu}' == 'Reset App State'
        Click    selector=${btn_reset_app_state}
    ELSE
        Fail    msg=Menu item ${menu} not found
    END
    
Input Username
    [Arguments]    ${username}
    Type Text    selector=${input_username}    txt=${username}

Input Password
    [Arguments]    ${password}
    Type Text    selector=${input_password}    txt=${password}
    
Open Browser And Visit Saucedemo Page
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    ${PAGE_URL}
    Wait For Elements State    selector=${btn_login}    state=visible
    Take Screenshot

Open Cart Menu
    Click    selector=${btn_cart} 
    Get Url    equal    https://www.saucedemo.com/cart.html
    Wait For Elements State     selector=${cart_contents}    state=visible
    Take Screenshot

Verify About Page Shown
    Get Url    equal    https://saucelabs.com/
    Take Screenshot

Verify Item In Cart
    Get Text    selector=${lbl_cart_item}    assertion_operator=equal    assertion_expected=${savedItem}
    Get Text    selector=${lbl_cart_item_desc}    assertion_operator=equal    assertion_expected=${savedItemDesc}

Verify Login Success
    Get Url    equal    https://www.saucedemo.com/inventory.html
    Wait For Elements State     selector=${inventory_list}    state=visible
    Take Screenshot