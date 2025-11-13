*** Settings ***
Documentation    Variables globales du projet - Test E-commerce Respire.co


*** Variables ***
# Configuration navigateur
${BROWSER}              chrome
${DELAY}                0.5s
${HEADLESS}             False

# URLs Respire.co
${BASE_URL}             https://www.respire.co
${HOME_URL}             ${BASE_URL}/
${PRODUCTS_URL}         ${BASE_URL}/collections/all
${CART_URL}             ${BASE_URL}/cart
${CHECKOUT_URL}         ${BASE_URL}/checkout
${ACCOUNT_URL}          ${BASE_URL}/account
${LOGIN_URL}            ${BASE_URL}/account/login
${REGISTER_URL}         ${BASE_URL}/account/register

# Timeouts
${TIMEOUT_SHORT}        5s
${TIMEOUT_MEDIUM}       10s
${TIMEOUT_LONG}         30s
${TIMEOUT_CHECKOUT}     60s

# Données de test - Utilisateurs
${VALID_USERNAME}       test.respire@example.com
${VALID_PASSWORD}       TestRespire2024!
${INVALID_USERNAME}     invalid@example.com
${INVALID_PASSWORD}     wrongpassword
${TEST_FIRSTNAME}       Jean
${TEST_LASTNAME}        Dupont
${TEST_PHONE}           +33612345678

# Données de test - Adresse
${TEST_ADDRESS}         123 Rue de la Paix
${TEST_CITY}            Paris
${TEST_ZIPCODE}         75001
${TEST_COUNTRY}         France

# Données de test - Paiement (TEST uniquement)
${TEST_CARD_NUMBER}     4242424242424242
${TEST_CARD_EXP}        12/25
${TEST_CARD_CVV}        123

# Termes de recherche
${SEARCH_VALID}         déodorant
${SEARCH_INVALID}       xyzabc123nonexistant

# Chemins
${RESULTS_DIR}          ${CURDIR}/../results
${DATA_DIR}             ${CURDIR}/../data
${SCREENSHOTS_DIR}      ${RESULTS_DIR}/screenshots
