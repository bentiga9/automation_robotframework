*** Settings ***
Documentation    Tests End-to-End complets pour Respire.co
...              Rôle: QA Engineer - Tests d'intégration complets du parcours utilisateur
...              Couvre le parcours complet: Visite > Recherche > Produit > Panier > Checkout
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
TC01 - Parcours utilisateur complet: Visiteur non connecté
    [Documentation]    Simule le parcours complet d'un visiteur qui découvre le site
    ...                Visite > Explore > Recherche > Sélectionne > Ajoute > Checkout
    [Tags]    e2e    critique    parcours-complet

    # Étape 1: Visite du site
    Log    === ÉTAPE 1: Arrivée sur le site ===
    Go To    ${HOME_URL}
    Sleep    2s
    Capturer une capture d'écran    e2e_01_accueil

    # Étape 2: Navigation vers les produits
    Log    === ÉTAPE 2: Exploration des produits ===
    Naviguer vers la page produits
    Sleep    2s
    Vérifier que l'élément est visible    ${PRODUCT_CARD}
    Capturer une capture d'écran    e2e_02_liste_produits

    # Étape 3: Recherche d'un produit spécifique
    Log    === ÉTAPE 3: Recherche de produit ===
    Rechercher un produit    ${SEARCH_VALID}
    Sleep    2s
    Capturer une capture d'écran    e2e_03_resultats_recherche

    # Étape 4: Consultation des détails d'un produit
    Log    === ÉTAPE 4: Consultation détails produit ===
    Sélectionner le premier produit
    Sleep    2s
    Vérifier que l'élément est visible    ${ADD_TO_CART_BUTTON}
    Capturer une capture d'écran    e2e_04_details_produit

    # Étape 5: Ajout au panier
    Log    === ÉTAPE 5: Ajout au panier ===
    Ajouter le produit au panier
    Sleep    3s
    Capturer une capture d'écran    e2e_05_produit_ajoute

    # Étape 6: Consultation du panier
    Log    === ÉTAPE 6: Consultation du panier ===
    Aller au panier
    Sleep    2s
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    e2e_06_panier

    # Étape 7: Début du processus de commande
    Log    === ÉTAPE 7: Passage au checkout ===
    Procéder au paiement
    Sleep    3s
    Vérifier que l'URL contient    checkout
    Capturer une capture d'écran    e2e_07_checkout

    # Étape 8: Remplissage des informations (Guest)
    Log    === ÉTAPE 8: Remplissage formulaire ===
    ${email_unique}=    Generer Email Unique    e2e_guest
    Remplir les informations de livraison
    ...    ${email_unique}
    ...    ${TEST_FIRSTNAME}
    ...    ${TEST_LASTNAME}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_ZIPCODE}
    ...    ${TEST_PHONE}
    Sleep    3s
    Capturer une capture d'écran    e2e_08_formulaire_complet

    Log    === PARCOURS COMPLET TERMINÉ ===

TC02 - Parcours utilisateur: Comparaison de produits
    [Documentation]    Parcours où l'utilisateur compare plusieurs produits avant d'acheter
    [Tags]    e2e    comparaison

    Log    === Parcours de comparaison ===

    # Consulter plusieurs produits
    Naviguer vers la page produits
    Sleep    2s
    Sélectionner le premier produit
    Sleep    2s
    Capturer une capture d'écran    comparaison_produit1

    # Retour à la liste
    Naviguer vers la page produits
    Sleep    2s

    # Consulter un deuxième produit
    ${products}=    Get WebElements    ${PRODUCT_CARD}
    ${count}=    Get Length    ${products}
    Run Keyword If    ${count} > 1    Click Element    ${products}[1]
    Sleep    2s
    Capturer une capture d'écran    comparaison_produit2

    # Décision: Ajouter au panier
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    comparaison_panier_final

TC03 - Parcours utilisateur: Modification du panier
    [Documentation]    L'utilisateur ajoute des produits puis modifie son panier
    [Tags]    e2e    modification-panier

    Log    === Parcours avec modifications ===

    # Ajouter premier produit
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s

    # Continuer les achats
    Naviguer vers la page produits
    Sleep    2s
    ${products}=    Get WebElements    ${PRODUCT_CARD}
    ${count}=    Get Length    ${products}
    Run Keyword If    ${count} > 1    Click Element    ${products}[1]
    Sleep    1s
    Run Keyword If    ${count} > 1    Ajouter le produit au panier
    Sleep    2s

    # Aller au panier
    Aller au panier
    Capturer une capture d'écran    panier_deux_produits

    # Supprimer un article
    Supprimer un article du panier
    Sleep    2s
    Capturer une capture d'écran    panier_apres_suppression

    Log    === Modifications terminées ===

TC04 - Test de performance: Temps de chargement des pages clés
    [Documentation]    Mesure les temps de chargement des pages principales
    [Tags]    e2e    performance

    # Page d'accueil
    ${start}=    Get Time    epoch
    Go To    ${HOME_URL}
    Sleep    3s
    ${end}=    Get Time    epoch
    ${duration}=    Evaluate    ${end} - ${start}
    Log    Temps de chargement accueil: ${duration}s

    # Page produits
    ${start}=    Get Time    epoch
    Naviguer vers la page produits
    Sleep    3s
    ${end}=    Get Time    epoch
    ${duration}=    Evaluate    ${end} - ${start}
    Log    Temps de chargement produits: ${duration}s

    Capturer une capture d'écran    test_performance

TC05 - Test de compatibilité multi-navigateurs (Chrome)
    [Documentation]    Vérifie le fonctionnement sur Chrome
    [Tags]    e2e    compatibilite

    # Parcours basique sur Chrome
    Naviguer vers la page produits
    Sleep    2s
    Vérifier que l'élément est visible    ${PRODUCT_CARD}

    Sélectionner le premier produit
    Sleep    1s
    Ajouter le produit au panier
    Sleep    2s

    Aller au panier
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    chrome_test_complet

TC06 - Test de sécurité: Validation des données
    [Documentation]    Teste la validation et la sécurité des entrées utilisateur
    [Tags]    e2e    securite

    # Test d'injection XSS basique dans la recherche
    ${xss_test}=    Set Variable    <script>alert('test')</script>
    Go To    ${HOME_URL}
    Sleep    2s
    Rechercher un produit    ${xss_test}
    Sleep    2s
    Log    Test de sécurité XSS effectué
    Capturer une capture d'écran    securite_xss_test

    # Test d'injection SQL basique dans la recherche
    ${sql_test}=    Set Variable    ' OR '1'='1
    Rechercher un produit    ${sql_test}
    Sleep    2s
    Log    Test de sécurité SQL effectué
    Capturer une capture d'écran    securite_sql_test

TC07 - Test d'accessibilité: Navigation au clavier
    [Documentation]    Teste la navigation avec le clavier (Tab, Enter)
    [Tags]    e2e    accessibilite

    Naviguer vers la page produits
    Sleep    2s

    # Simuler la navigation au clavier
    Press Keys    None    TAB
    Sleep    0.5s
    Press Keys    None    TAB
    Sleep    0.5s
    Press Keys    None    TAB
    Sleep    0.5s

    Log    Test de navigation au clavier effectué
    Capturer une capture d'écran    accessibilite_clavier

TC08 - Test de régression: Parcours standard
    [Documentation]    Test de régression pour détecter les régressions sur le parcours standard
    [Tags]    e2e    regression    critique

    Log    === Test de régression ===

    # Parcours standard simplifié
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Aller au panier
    Vérifier que le panier contient des articles
    Procéder au paiement
    Sleep    2s
    Vérifier que l'URL contient    checkout

    Capturer une capture d'écran    regression_parcours_ok
    Log    === Test de régression PASSÉ ===
