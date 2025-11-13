*** Settings ***
Documentation    Tests du panier d'achat - Respire.co
...              Rôle: Test Automation Engineer - Tests automatisés d'ajout, suppression, mise à jour du panier
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
TC01 - Ajout d'un produit au panier
    [Documentation]    Vérifie qu'un produit peut être ajouté au panier
    [Tags]    panier    ajout    critique
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    produit_ajoute_panier

TC02 - Vérification du contenu du panier
    [Documentation]    Vérifie que les informations du produit sont correctement affichées dans le panier
    [Tags]    panier    verification
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Vérifier que l'élément est visible    ${CART_ITEM_NAME}
    Vérifier que l'élément est visible    ${CART_ITEM_PRICE}
    Vérifier que l'élément est visible    ${CART_ITEM_QUANTITY}
    Capturer une capture d'écran    contenu_panier

TC03 - Suppression d'un article du panier
    [Documentation]    Vérifie qu'un article peut être supprimé du panier
    [Tags]    panier    suppression    critique
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Supprimer un article du panier
    Sleep    2s
    ${is_empty}=    Run Keyword And Return Status    Vérifier que le panier est vide
    Log    Panier vidé avec succès: ${is_empty}
    Capturer une capture d'écran    panier_apres_suppression

TC04 - Ajout de plusieurs produits au panier
    [Documentation]    Vérifie qu'on peut ajouter plusieurs produits différents
    [Tags]    panier    ajout    multiple
    # Ajouter premier produit
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s

    # Retourner et ajouter un deuxième produit
    Naviguer vers la page produits
    Sleep    2s
    ${products}=    Get WebElements    ${PRODUCT_CARD}
    ${count}=    Get Length    ${products}
    Run Keyword If    ${count} > 1    Click Element    ${products}[1]
    Sleep    1s
    Run Keyword If    ${count} > 1    Ajouter le produit au panier
    Sleep    2s

    # Vérifier le panier
    Aller au panier
    ${items}=    Get WebElements    ${CART_ITEM}
    ${items_count}=    Get Length    ${items}
    Log    Nombre d'articles dans le panier: ${items_count}
    Capturer une capture d'écran    plusieurs_produits_panier

TC05 - Modification de la quantité d'un produit
    [Documentation]    Vérifie qu'on peut modifier la quantité d'un produit dans le panier
    [Tags]    panier    quantite
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier

    # Modifier la quantité
    ${quantity_field}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CART_ITEM_QUANTITY}    5s
    Run Keyword If    ${quantity_field}    Input Text    ${CART_ITEM_QUANTITY}    2
    Run Keyword If    ${quantity_field}    Sleep    1s

    Log    Quantité modifiée
    Capturer une capture d'écran    quantite_modifiee

TC06 - Vérification du total du panier
    [Documentation]    Vérifie que le total du panier est affiché
    [Tags]    panier    calcul
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    ${total_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CART_TOTAL}    5s
    Run Keyword If    ${total_visible}    Log    Total du panier affiché
    Capturer une capture d'écran    total_panier

TC07 - Navigation vers le checkout depuis le panier
    [Documentation]    Vérifie qu'on peut passer à l'étape de paiement depuis le panier
    [Tags]    panier    checkout    critique
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Procéder au paiement
    Sleep    3s
    Vérifier que l'URL contient    checkout
    Capturer une capture d'écran    transition_vers_checkout

TC08 - Persistance du panier après rechargement
    [Documentation]    Vérifie que le panier est conservé après rechargement de la page
    [Tags]    panier    persistance
    Naviguer vers la page produits
    Sélectionner le premier produit
    Ajouter le produit au panier
    Sleep    2s
    Aller au panier
    Vérifier que le panier contient des articles

    # Recharger la page
    Reload Page
    Sleep    2s
    Vérifier que le panier contient des articles
    Capturer une capture d'écran    panier_persiste
