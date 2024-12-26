*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${EXPECTED_ID}    1
${EXPECTED_title}  sunt aut facere repellat provident occaecati excepturi optio reprehenderit



*** Test Cases ***
Test GET API
    [Documentation]    This test case checks the GET API
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session   mysession    /posts/1
    Should Be Equal As Numbers    ${response.status_code}    200
    ${resp.json()}=    To JSON    ${response.content}
    ${actual_title}=    Get From Dictionary    ${resp.json()}    title
    Should Be Equal As Strings    ${actual_title}    ${EXPECTED_title}
    Log    ${resp.json()}
#    Log    ${response.json(['title'])}


Test PUT API
    [Documentation]    This test case checks the PUT API
    Create Session    mysession    ${BASE_URL}
    ${request_body}=    Create Dictionary    title=foo    body=bar    userId=1
    ${response}=    PUT On Session   mysession    /posts/1    json=${request_body}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test POST API
    [Documentation]    This test case checks the POST API
    Create Session    mysession    ${BASE_URL}
    ${request_body}=    Create Dictionary    title=foo    body=bar    userId=1
    ${response}=    POST On Session    mysession    /posts    json=${request_body}
    Should Be Equal As Numbers    ${response.status_code}    201
    Log    ${response.json()}

Test DELETE API
    [Documentation]    This test case checks the DELETE API
    Create Session    mysession    ${BASE_URL}
    ${response}=    DELETE On Session  mysession    /posts/1
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}