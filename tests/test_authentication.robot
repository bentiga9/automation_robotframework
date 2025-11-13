*** Settings ***
Documentation    Tests d'authentification pour Respire.co
...              Rôle: Test Analyst - Cas de test détaillés pour inscription, connexion, déconnexion
Library          SeleniumLibrary
Library          ../libraries/custom_keywords.py
Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot
Resource         ../resources/locators.robot

Suite Setup      Ouvrir le navigateur
Suite Teardown   Fermer le navigateur

*** Variables ***
${TEST_USER_EMAIL}    ${EMPTY}


*** Test Cases ***
TC01 - Inscription d'un nouvel utilisateur avec des données valides
    [Documentation]    Vérifie qu'un utilisateur peut créer un compte avec des données valides
    [Tags]    authentification    inscription    critique
    ${email_unique}=    Generer Email Unique    testuser
    Set Suite Variable    ${TEST_USER_EMAIL}    ${email_unique}
    Créer un compte utilisateur    ${TEST_FIRSTNAME}    ${TEST_LASTNAME}    ${email_unique}    ${VALID_PASSWORD}
    Vérifier que l'URL contient    account
    Capturer une capture d'écran    inscription_reussie

TC02 - Connexion avec des identifiants valides
    [Documentation]    Vérifie qu'un utilisateur peut se connecter avec des identifiants valides
    [Tags]    authentification    connexion    critique
    Se connecter avec les identifiants    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Sleep    2s
    Vérifier que l'URL contient    account
    Capturer une capture d'écran    connexion_reussie

TC03 - Connexion avec un mot de passe invalide
    [Documentation]    Vérifie que la connexion échoue avec un mot de passe incorrect
    [Tags]    authentification    connexion    negatif
    Se connecter avec les identifiants    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Vérifier le message d'erreur
    Capturer une capture d'écran    connexion_echec_mdp

TC04 - Connexion avec un email invalide
    [Documentation]    Vérifie que la connexion échoue avec un email incorrect
    [Tags]    authentification    connexion    negatif
    Se connecter avec les identifiants    ${INVALID_USERNAME}    ${VALID_PASSWORD}
    Vérifier le message d'erreur
    Capturer une capture d'écran    connexion_echec_email

TC05 - Déconnexion d'un utilisateur connecté
    [Documentation]    Vérifie qu'un utilisateur peut se déconnecter
    [Tags]    authentification    deconnexion
    Se connecter avec les identifiants    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Sleep    2s
    Se déconnecter
    Sleep    2s
    Vérifier que l'URL contient    login
    Capturer une capture d'écran    deconnexion_reussie

TC06 - Validation du format email lors de l'inscription
    [Documentation]    Vérifie que le système valide le format de l'email
    [Tags]    authentification    validation
    ${email_valide}=    Valider Format Email    ${VALID_USERNAME}
    Should Be True    ${email_valide}
    ${email_invalide}=    Valider Format Email    email_invalide
    Should Not Be True    ${email_invalide}
