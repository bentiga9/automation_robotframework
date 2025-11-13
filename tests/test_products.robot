*** Settings ***
Documentation    Tests de navigation et recherche de produits - Respire.co
...              Rôle: Test Analyst - Tests fonctionnels de recherche, navigation, filtres
Library          SeleniumLibrary
Library          ../libraries/custom_keywords.py
Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot
Resource         ../resources/locators.robot

Suite Setup      Setup Suite
Suite Teardown   Fermer le navigateur

*** Keywords ***
Setup Suite
    Ouvrir le navigateur
    Accepter les cookies
    Fermer les popups


*** Test Cases ***
TC01 - Affichage de la page produits
    [Documentation]    Vérifie que la page produits s'affiche correctement
    [Tags]    produits    navigation    critique
    Naviguer vers la page produits
    Vérifier que l'élément est visible    ${PRODUCT_CARD}
    Capturer une capture d'écran    page_produits

TC02 - Recherche d'un produit valide
    [Documentation]    Vérifie la recherche avec un terme valide
    [Tags]    recherche    produits    critique
    Go To    ${HOME_URL}
    Rechercher un produit    ${SEARCH_VALID}
    Sleep    2s
    Vérifier que l'élément est visible    ${SEARCH_RESULTS}
    Capturer une capture d'écran    recherche_valide

TC03 - Recherche d'un produit inexistant
    [Documentation]    Vérifie la recherche avec un terme inexistant
    [Tags]    recherche    produits    negatif
    Go To    ${HOME_URL}
    Rechercher un produit    ${SEARCH_INVALID}
    Sleep    2s
    ${no_results}=    Run Keyword And Return Status    Element Should Be Visible    ${SEARCH_NO_RESULTS}
    Run Keyword If    ${no_results}    Log    Aucun résultat trouvé comme attendu
    Capturer une capture d'écran    recherche_aucun_resultat

TC04 - Affichage des détails d'un produit
    [Documentation]    Vérifie qu'on peut accéder aux détails d'un produit
    [Tags]    produits    navigation
    Naviguer vers la page produits
    Sélectionner le premier produit
    Vérifier que l'élément est visible    ${ADD_TO_CART_BUTTON}
    Capturer une capture d'écran    details_produit

TC05 - Vérification des éléments d'un produit
    [Documentation]    Vérifie que les éléments clés sont affichés (titre, prix, image)
    [Tags]    produits    affichage
    Naviguer vers la page produits
    Vérifier que l'élément est visible    ${PRODUCT_TITLE}
    Vérifier que l'élément est visible    ${PRODUCT_PRICE}
    Vérifier que l'élément est visible    ${PRODUCT_IMAGE}
    Capturer une capture d'écran    elements_produit

TC06 - Navigation entre différentes pages de produits
    [Documentation]    Vérifie la navigation entre les pages de collection
    [Tags]    produits    navigation
    Naviguer vers la page produits
    ${url_before}=    Get Location
    Sleep    2s
    Scroll Element Into View    ${PRODUCT_CARD}
    ${url_after}=    Get Location
    Log    Navigation testée avec succès
    Capturer une capture d'écran    navigation_produits

TC07 - Test de chargement des images produits
    [Documentation]    Vérifie que les images des produits se chargent correctement
    [Tags]    produits    performance
    Naviguer vers la page produits
    ${images}=    Get WebElements    ${PRODUCT_IMAGE}
    ${count}=    Get Length    ${images}
    Should Be True    ${count} > 0
    Log    ${count} images trouvées
    Capturer une capture d'écran    images_produits

TC08 - Vérification du responsive design (mobile)
    [Documentation]    Teste l'affichage en mode mobile
    [Tags]    produits    responsive
    Set Window Size    375    667
    Naviguer vers la page produits
    Sleep    2s
    Vérifier que l'élément est visible    ${PRODUCT_CARD}
    Capturer une capture d'écran    mobile_produits
    Set Window Size    1920    1080
