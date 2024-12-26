*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${ENDPOINT}    /users/1

# Expected values for validation
${EXPECTED_NAME}        Leanne Graham
${EXPECTED_EMAIL}       Sincere@april.biz
${EXPECTED_CITY}        Gwenborough
${EXPECTED_LAT}         -37.3159
${EXPECTED_LNG}         81.1496

*** Test Cases ***
Validate JSON Response Content
    [Documentation]    Validate the content of the JSON response (string, integer, object, arrays).
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session    mysession    ${ENDPOINT}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Parse JSON response
    ${response_json}=    To JSON    ${response.content}

    # Validate content
    Validate Name    ${response_json}    ${EXPECTED_NAME}
    Validate Email   ${response_json}    ${EXPECTED_EMAIL}
    Validate Address Content    ${response_json}
    Validate Geo Content    ${response_json}

    Log    JSON response content validation passed.

*** Keywords ***
Validate Name
    [Arguments]    ${response_json}    ${expected_name}
    ${actual_name}=    Get From Dictionary    ${response_json}    name
    Should Be Equal As Strings    ${actual_name}    ${expected_name}

Validate Email
    [Arguments]    ${response_json}    ${expected_email}
    ${actual_email}=    Get From Dictionary    ${response_json}    email
    Should Be Equal As Strings    ${actual_email}    ${expected_email}

Validate Address Content
    [Arguments]    ${response_json}
    ${address}=    Get From Dictionary    ${response_json}    address
#    Should Contain Key    ${address}    street
#    Should Contain Key    ${address}    suite
#    Should Contain Key    ${address}    city
#    Should Contain Key    ${address}    zipcode
    ${actual_city}=    Get From Dictionary    ${address}    city
    Should Be Equal As Strings    ${actual_city}    ${EXPECTED_CITY}

Validate Geo Content
    [Arguments]    ${response_json}
    ${address}=    Get From Dictionary    ${response_json}    address
    ${geo}=    Get From Dictionary    ${address}    geo
    ${actual_lat}=    Get From Dictionary    ${geo}    lat
    Should Be Equal As Strings    ${actual_lat}    ${EXPECTED_LAT}
    ${actual_lng}=    Get From Dictionary    ${geo}    lng
    Should Be Equal As Strings    ${actual_lng}    ${EXPECTED_LNG}
