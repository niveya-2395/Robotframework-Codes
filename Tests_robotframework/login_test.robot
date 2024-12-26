*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        http://the-internet.herokuapp.com/login
${BROWSER}    Chrome
${USERNAME}   tomsmith
${PASSWORD}   SuperSecretPassword!

*** Test Cases ***
Login Test
    [Documentation]    This test case logs into the example website.
    Open Browser to url   ${URL}    ${BROWSER}
    Input Text    id=username    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Click Button    css=.radius
    Wait Until Page Contains Element    css=.flash.success      10s
    [Teardown]    Close Browser

*** Keywords ***
Open Browser to url
    [Arguments]    ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
