*** Settings ***
Documentation    Sélecteurs d'éléments de Respire.co (Shopify)


*** Variables ***
# === NAVIGATION PRINCIPALE ===
${NAV_COMPTE}               xpath=//a[contains(@href, '/account')]
${NAV_PANIER}               xpath=//a[contains(@href, '/cart')]
${NAV_RECHERCHE}            css=.search-button
${NAV_MENU_MOBILE}          css=.mobile-menu-button

# === CONNEXION / INSCRIPTION ===
${LOGIN_EMAIL_FIELD}        id=CustomerEmail
${LOGIN_PASSWORD_FIELD}     id=CustomerPassword
${LOGIN_SUBMIT_BUTTON}      css=button[type='submit']
${LOGIN_ERROR_MESSAGE}      css=.errors
${REGISTER_FIRSTNAME}       id=FirstName
${REGISTER_LASTNAME}        id=LastName
${REGISTER_EMAIL}           id=Email
${REGISTER_PASSWORD}        id=CreatePassword
${REGISTER_SUBMIT}          css=button[type='submit']

# === PAGE PRODUITS ===
# NOTE: Ces sélecteurs sont génériques. Inspectez le site pour les personnaliser.
${PRODUCT_CARD}             xpath=//article
${PRODUCT_TITLE}            xpath=//h2
${PRODUCT_PRICE}            xpath=//span[contains(@class, 'price')]
${PRODUCT_IMAGE}            xpath=//img[1]
${PRODUCT_LINK}             xpath=//a[contains(@href, '/products/')]
${ADD_TO_CART_BUTTON}       xpath=//button[contains(., 'Ajouter') or contains(., 'Add to cart') or @name='add']
${PRODUCT_QUANTITY}         css=input[name='quantity']
${PRODUCT_VARIANT}          css=select[name='id']

# === RECHERCHE ===
${SEARCH_INPUT}             css=input[name='q']
${SEARCH_BUTTON}            css=.search-submit
${SEARCH_RESULTS}           css=.search-results
${SEARCH_NO_RESULTS}        xpath=//*[contains(text(), 'Aucun résultat')]

# === PANIER ===
${CART_ICON}                css=a[href*='/cart']
${CART_ITEM}                css=.cart-item
${CART_ITEM_NAME}           css=.cart-item__name
${CART_ITEM_PRICE}          css=.cart-item__price
${CART_ITEM_QUANTITY}       css=input[name='updates[]']
${CART_REMOVE_BUTTON}       css=.cart-remove
${CART_UPDATE_BUTTON}       css=button[name='update']
${CART_CHECKOUT_BUTTON}     css=button[name='checkout']
${CART_TOTAL}               css=.cart-total
${CART_EMPTY_MESSAGE}       xpath=//*[contains(text(), 'Votre panier est vide')]

# === CHECKOUT (Paiement) ===
${CHECKOUT_EMAIL}           id=checkout_email
${CHECKOUT_FIRSTNAME}       id=checkout_shipping_address_first_name
${CHECKOUT_LASTNAME}        id=checkout_shipping_address_last_name
${CHECKOUT_ADDRESS}         id=checkout_shipping_address_address1
${CHECKOUT_CITY}            id=checkout_shipping_address_city
${CHECKOUT_ZIPCODE}         id=checkout_shipping_address_zip
${CHECKOUT_PHONE}           id=checkout_shipping_address_phone
${CHECKOUT_CONTINUE}        id=continue_button
${CHECKOUT_PAYMENT_METHOD}  css=.payment-method-list input
${CHECKOUT_CARD_NUMBER}     id=number
${CHECKOUT_CARD_NAME}       id=name
${CHECKOUT_CARD_EXPIRY}     id=expiry
${CHECKOUT_CARD_CVV}        id=verification_value
${CHECKOUT_COMPLETE}        css=button#continue_button

# === COMPTE CLIENT ===
${ACCOUNT_ORDERS}           xpath=//a[contains(@href, '/account') and contains(text(), 'Commandes')]
${ACCOUNT_ADDRESSES}        xpath=//a[contains(@href, '/account/addresses')]
${ACCOUNT_LOGOUT}           xpath=//a[contains(@href, '/account/logout')]

# === MESSAGES & NOTIFICATIONS ===
${SUCCESS_MESSAGE}          css=.alert-success
${ERROR_MESSAGE}            css=.errors
${LOADING_SPINNER}          css=.loading

# === FILTRES & TRI ===
${FILTER_BUTTON}            css=.filter-button
${SORT_DROPDOWN}            id=SortBy
${FILTER_PRICE}             css=input[type='range']
${FILTER_CATEGORY}          css=.collection-filter

# === COOKIES & POPUPS ===
${COOKIE_ACCEPT}            xpath=//button[contains(text(), 'Accepter')]
${POPUP_CLOSE}              css=.modal-close

# === FORMULAIRES COMMUNS ===
${SUBMIT_BUTTON}            css=button[type='submit']
${CANCEL_BUTTON}            css=button.cancel
${CLOSE_BUTTON}             css=button.close
