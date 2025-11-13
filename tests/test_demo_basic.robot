*** Settings ***
Documentation    Test de démonstration basique pour vérifier que le framework fonctionne
Library          SeleniumLibrary

Suite Setup      Open Browser    https://www.respire.co    chrome
Suite Teardown   Close All Browsers

*** Test Cases ***
TC01 - Vérifier que le site s'ouvre
    [Documentation]    Vérifie que le navigateur s'ouvre et charge le site
    [Tags]    demo    basique
    ${title}=    Get Title
    Should Not Be Empty    ${title}
    Log    Titre de la page: ${title}
    Capture Page Screenshot    demo_site_ouvert.png

TC02 - Vérifier la présence d'éléments basiques
    [Documentation]    Vérifie que des éléments HTML de base sont présents
    [Tags]    demo    basique
    Page Should Contain Element    xpath=//body
    Page Should Contain Element    xpath=//header
    Capture Page Screenshot    demo_elements_presents.png

TC03 - Naviguer vers la page collections
    [Documentation]    Teste la navigation vers la page produits
    [Tags]    demo    navigation
    Go To    https://www.respire.co/collections/all
    Sleep    3s
    Location Should Contain    collections
    Capture Page Screenshot    demo_page_collections.png

TC04 - Vérifier la présence de liens
    [Documentation]    Vérifie qu'il y a des liens sur la page
    [Tags]    demo    elements
    ${link_count}=    Get Element Count    xpath=//a
    Should Be True    ${link_count} > 0
    Log    Nombre de liens trouvés: ${link_count}
    Capture Page Screenshot    demo_liens_trouves.png
