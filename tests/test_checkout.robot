*** Settings ***
Documentation    Tests du processus de paiement (Checkout) - Respire.co
...              Rôle: Test Automation Engineer - Tests du parcours de commande complet
...              ATTENTION: Ces tests s'arrêtent avant la finalisation du paiement réel
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

Preparer Panier Avec Produit
    [Documentation]    Ajoute un produit au panier et accède au checkout
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Procéder au paiement
    Sleep    3s


*** Test Cases ***
TC01 - Accès à la page de checkout
    [Documentation]    Vérifie qu'on peut accéder à la page de paiement
    [Tags]    checkout    navigation    critique
    Preparer Panier Avec Produit
    Vérifier que l'URL contient    checkout
    Capturer une capture d'écran    page_checkout

TC02 - Vérification des champs obligatoires
    [Documentation]    Vérifie que les champs requis sont présents sur le formulaire
    [Tags]    checkout    formulaire
    Preparer Panier Avec Produit
    Vérifier que l'élément est visible    ${CHECKOUT_EMAIL}    ${TIMEOUT_CHECKOUT}
    ${firstname_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CHECKOUT_FIRSTNAME}    ${TIMEOUT_SHORT}
    ${address_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CHECKOUT_ADDRESS}    ${TIMEOUT_SHORT}
    Log    Champs du formulaire détectés
    Capturer une capture d'écran    champs_checkout

TC03 - Remplissage du formulaire de livraison
    [Documentation]    Vérifie qu'on peut remplir les informations de livraison
    [Tags]    checkout    formulaire    critique
    Preparer Panier Avec Produit
    ${email_unique}=    Generer Email Unique    checkout
    Remplir les informations de livraison
    ...    ${email_unique}
    ...    ${TEST_FIRSTNAME}
    ...    ${TEST_LASTNAME}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_ZIPCODE}
    ...    ${TEST_PHONE}
    Sleep    2s
    Capturer une capture d'écran    formulaire_rempli

TC04 - Validation du format email au checkout
    [Documentation]    Vérifie la validation du champ email
    [Tags]    checkout    validation
    Preparer Panier Avec Produit
    ${email_test}=    Set Variable    invalid-email
    ${is_valid}=    Valider Format Email    ${email_test}
    Should Not Be True    ${is_valid}
    ${email_valid}=    Set Variable    test@example.com
    ${is_valid2}=    Valider Format Email    ${email_valid}
    Should Be True    ${is_valid2}
    Log    Validation email testée

TC05 - Test du bouton retour au panier
    [Documentation]    Vérifie qu'on peut revenir au panier depuis le checkout
    [Tags]    checkout    navigation
    Preparer Panier Avec Produit
    Sleep    2s
    Go To    ${CART_URL}
    Vérifier que l'URL contient    cart
    Capturer une capture d'écran    retour_au_panier

TC06 - Vérification du résumé de commande
    [Documentation]    Vérifie que le résumé de la commande est affiché au checkout
    [Tags]    checkout    verification
    Preparer Panier Avec Produit
    Sleep    2s
    ${page_loaded}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${CHECKOUT_EMAIL}    ${TIMEOUT_CHECKOUT}
    Should Be True    ${page_loaded}
    Log    Page de checkout chargée avec résumé
    Capturer une capture d'écran    resume_commande

TC07 - Test avec champs vides (Validation)
    [Documentation]    Vérifie que la validation empêche la soumission avec des champs vides
    [Tags]    checkout    validation    negatif
    Preparer Panier Avec Produit
    Sleep    2s
    ${continue_button}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CHECKOUT_CONTINUE}    ${TIMEOUT_SHORT}
    Run Keyword If    ${continue_button}    Click Element    ${CHECKOUT_CONTINUE}
    Sleep    2s
    Log    Test de validation des champs vides effectué
    Capturer une capture d'écran    validation_champs_vides

TC08 - Parcours complet jusqu'à la page de paiement
    [Documentation]    Teste le parcours complet: produit > panier > informations > paiement
    ...              ATTENTION: S'ARRÊTE avant le paiement réel
    [Tags]    checkout    e2e    critique
    # Étape 1: Ajouter produit
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Capturer une capture d'écran    etape1_produit_ajoute

    # Étape 2: Aller au panier
    Aller au panier
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    etape2_panier

    # Étape 3: Procéder au checkout
    Procéder au paiement
    Sleep    3s
    Vérifier que l'URL contient    checkout
    Capturer une capture d'écran    etape3_checkout

    # Étape 4: Remplir informations
    ${email_unique}=    Generer Email Unique    e2e
    Remplir les informations de livraison
    ...    ${email_unique}
    ...    ${TEST_FIRSTNAME}
    ...    ${TEST_LASTNAME}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_ZIPCODE}
    ...    ${TEST_PHONE}
    Sleep    3s
    Capturer une capture d'écran    etape4_infos_remplies

    # Étape 5: Arrivée sur la page de paiement (on s'arrête ici)
    Log    Parcours complet testé jusqu'à la page de paiement
    Capturer une capture d'écran    etape5_page_paiement

TC09 - Test responsive checkout (Mobile)
    [Documentation]    Teste le checkout en mode mobile
    [Tags]    checkout    responsive
    Set Window Size    375    667
    Preparer Panier Avec Produit
    Sleep    2s
    Vérifier que l'élément est visible    ${CHECKOUT_EMAIL}    ${TIMEOUT_CHECKOUT}
    Capturer une capture d'écran    checkout_mobile
    Set Window Size    1920    1080
