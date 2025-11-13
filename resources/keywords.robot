*** Settings ***
Documentation    Keywords réutilisables pour les tests E-commerce Respire.co
Library          SeleniumLibrary
Library          ../libraries/custom_keywords.py
Resource         variables.robot
Resource         locators.robot


*** Keywords ***
# === NAVIGATION & SETUP ===
Ouvrir le navigateur
    [Documentation]    Ouvre le navigateur sur l'URL de base
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Set Selenium Timeout    ${TIMEOUT_MEDIUM}

Fermer le navigateur
    [Documentation]    Ferme le navigateur et nettoie la session
    Close All Browsers

Accepter les cookies
    [Documentation]    Accepte les cookies si la popup apparaît
    ${cookie_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${COOKIE_ACCEPT}    5s
    Run Keyword If    ${cookie_present}    Click Element    ${COOKIE_ACCEPT}

Fermer les popups
    [Documentation]    Ferme les popups qui peuvent apparaître
    ${popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${POPUP_CLOSE}    3s
    Run Keyword If    ${popup_present}    Click Element    ${POPUP_CLOSE}

# === AUTHENTIFICATION ===
Se connecter avec les identifiants
    [Documentation]    Connexion avec email et mot de passe
    [Arguments]    ${email}    ${password}
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    ${LOGIN_EMAIL_FIELD}    ${TIMEOUT_MEDIUM}
    Input Text    ${LOGIN_EMAIL_FIELD}    ${email}
    Input Password    ${LOGIN_PASSWORD_FIELD}    ${password}
    Click Element    ${LOGIN_SUBMIT_BUTTON}
    Sleep    2s

Créer un compte utilisateur
    [Documentation]    Inscription d'un nouvel utilisateur
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${password}
    Go To    ${REGISTER_URL}
    Wait Until Element Is Visible    ${REGISTER_FIRSTNAME}    ${TIMEOUT_MEDIUM}
    Input Text    ${REGISTER_FIRSTNAME}    ${firstname}
    Input Text    ${REGISTER_LASTNAME}    ${lastname}
    Input Text    ${REGISTER_EMAIL}    ${email}
    Input Password    ${REGISTER_PASSWORD}    ${password}
    Click Element    ${REGISTER_SUBMIT}
    Sleep    2s

Se déconnecter
    [Documentation]    Déconnexion du compte utilisateur
    Go To    ${ACCOUNT_URL}
    Wait Until Element Is Visible    ${ACCOUNT_LOGOUT}    ${TIMEOUT_MEDIUM}
    Click Element    ${ACCOUNT_LOGOUT}

# === NAVIGATION PRODUITS ===
Naviguer vers la page produits
    [Documentation]    Accède à la page de tous les produits
    Go To    ${PRODUCTS_URL}
    Wait Until Element Is Visible    ${PRODUCT_CARD}    ${TIMEOUT_LONG}

Rechercher un produit
    [Documentation]    Recherche un produit par mot-clé
    [Arguments]    ${search_term}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    ${TIMEOUT_MEDIUM}
    Input Text    ${SEARCH_INPUT}    ${search_term}
    Click Element    ${SEARCH_BUTTON}
    Sleep    2s

Sélectionner le premier produit
    [Documentation]    Clique sur le premier produit de la liste
    Wait Until Element Is Visible    ${PRODUCT_CARD}    ${TIMEOUT_MEDIUM}
    Click Element    ${PRODUCT_CARD}
    Sleep    1s

# === PANIER ===
Ajouter le produit au panier
    [Documentation]    Ajoute le produit actuellement affiché au panier
    Wait Until Element Is Visible    ${ADD_TO_CART_BUTTON}    ${TIMEOUT_MEDIUM}
    Click Element    ${ADD_TO_CART_BUTTON}
    Sleep    2s

Aller au panier
    [Documentation]    Navigue vers la page du panier
    Go To    ${CART_URL}
    Sleep    2s

Vérifier que le panier contient des articles
    [Documentation]    Vérifie que le panier n'est pas vide
    Wait Until Element Is Visible    ${CART_ITEM}    ${TIMEOUT_MEDIUM}
    Element Should Be Visible    ${CART_ITEM}

Vérifier que le panier est vide
    [Documentation]    Vérifie que le panier est vide
    Wait Until Element Is Visible    ${CART_EMPTY_MESSAGE}    ${TIMEOUT_MEDIUM}
    Element Should Be Visible    ${CART_EMPTY_MESSAGE}

Supprimer un article du panier
    [Documentation]    Supprime le premier article du panier
    Wait Until Element Is Visible    ${CART_REMOVE_BUTTON}    ${TIMEOUT_MEDIUM}
    Click Element    ${CART_REMOVE_BUTTON}
    Sleep    2s

Procéder au paiement
    [Documentation]    Clique sur le bouton de paiement
    Wait Until Element Is Visible    ${CART_CHECKOUT_BUTTON}    ${TIMEOUT_MEDIUM}
    Click Element    ${CART_CHECKOUT_BUTTON}
    Sleep    3s

# === CHECKOUT ===
Remplir les informations de livraison
    [Documentation]    Remplit le formulaire d'adresse de livraison
    [Arguments]    ${email}    ${firstname}    ${lastname}    ${address}    ${city}    ${zipcode}    ${phone}
    Wait Until Element Is Visible    ${CHECKOUT_EMAIL}    ${TIMEOUT_CHECKOUT}
    Input Text    ${CHECKOUT_EMAIL}    ${email}
    Input Text    ${CHECKOUT_FIRSTNAME}    ${firstname}
    Input Text    ${CHECKOUT_LASTNAME}    ${lastname}
    Input Text    ${CHECKOUT_ADDRESS}    ${address}
    Input Text    ${CHECKOUT_CITY}    ${city}
    Input Text    ${CHECKOUT_ZIPCODE}    ${zipcode}
    Input Text    ${CHECKOUT_PHONE}    ${phone}
    Click Element    ${CHECKOUT_CONTINUE}
    Sleep    3s

# === VÉRIFICATIONS ===
Vérifier que l'élément est visible
    [Documentation]    Vérifie qu'un élément est visible sur la page
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT_MEDIUM}
    Wait Until Element Is Visible    ${locator}    ${timeout}

Vérifier le message de succès
    [Documentation]    Vérifie qu'un message de succès apparaît
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}    ${TIMEOUT_MEDIUM}
    Element Should Be Visible    ${SUCCESS_MESSAGE}

Vérifier le message d'erreur
    [Documentation]    Vérifie qu'un message d'erreur apparaît
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    ${TIMEOUT_MEDIUM}
    Element Should Be Visible    ${ERROR_MESSAGE}

Vérifier que l'URL contient
    [Documentation]    Vérifie que l'URL actuelle contient un texte spécifique
    [Arguments]    ${expected_text}
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${expected_text}

# === UTILITAIRES ===
Capturer une capture d'écran
    [Documentation]    Prend une capture d'écran avec un nom personnalisé
    [Arguments]    ${name}=screenshot
    ${timestamp}=    Generer Timestamp    %Y%m%d_%H%M%S
    Capture Page Screenshot    ${name}_${timestamp}.png

Attendre le chargement de la page
    [Documentation]    Attend que la page soit complètement chargée
    [Arguments]    ${timeout}=${TIMEOUT_LONG}
    Wait Until Element Is Not Visible    ${LOADING_SPINNER}    ${timeout}    ignore_error=True
    Sleep    1s
