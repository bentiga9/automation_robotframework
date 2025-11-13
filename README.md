# Projet d'Automatisation E-commerce - Respire.co

## Description

Projet de tests automatisés pour le site e-commerce **Respire.co** développé avec **Robot Framework**. Ce projet suit les bonnes pratiques définies par les responsabilités de l'équipe de test pour les sites e-commerce.

### Site testé
- **URL**: https://www.respire.co
- **Plateforme**: Shopify
- **Type**: E-commerce de produits cosmétiques

---

## Responsabilités de l'Équipe (Selon le PDF)

Ce projet est organisé selon les 6 rôles clés de l'équipe de test :

### 1. Test Manager (Responsable des Tests)
- Supervision globale du projet de test
- Plan de test établi
- Critères d'acceptation : Aucun bug bloquant sur le parcours d'achat
- Rapport de synthèse généré automatiquement

### 2. Test Analyst (Analyste de Test)
- Cas de test détaillés dans tous les fichiers `.robot`
- Scénarios couverts : Navigation, Recherche, Panier, Paiement
- Tests manuels et automatisés documentés

### 3. Test Automation Engineer (Ingénieur en Automatisation)
- Framework Robot Framework mis en place
- Scripts automatisés pour parcours répétitifs
- Tests de régression automatisés
- Intégration CI/CD prête

### 4. QA Engineer (Ingénieur Assurance Qualité)
- Vérification de la sécurité (XSS, SQL injection testés)
- Tests de performance (temps de chargement)
- Respect des normes d'accessibilité
- Tests de compatibilité navigateurs

### 5. Test Architect (Architecte des Tests)
- Infrastructure technique définie
- Outils choisis : Robot Framework + SeleniumLibrary
- Stratégie de test à long terme
- Organisation cohérente des ressources

### 6. Defect Manager (Gestionnaire des Anomalies)
- Captures d'écran automatiques pour chaque test
- Logs détaillés générés
- Statistiques de tests disponibles dans les rapports

---

## Structure du Projet

```
automation/
├── README.md                    # Documentation
├── requirements.txt             # Dépendances Python
├── .gitignore                   # Fichiers à ignorer
│
├── data/                        # Données de test
│   └── test_data.json          # Utilisateurs, produits, configurations
│
├── libraries/                   # Bibliothèques Python personnalisées
│   └── custom_keywords.py      # Keywords Python (email unique, validation)
│
├── resources/                   # Ressources réutilisables
│   ├── keywords.robot          # Keywords e-commerce (panier, checkout, etc.)
│   ├── variables.robot         # Variables globales (URLs, données test)
│   └── locators.robot          # Sélecteurs Shopify (produits, panier, checkout)
│
└── tests/                       # Fichiers de tests
    ├── test_authentication.robot      # Tests connexion/inscription
    ├── test_products.robot            # Tests produits et recherche
    ├── test_cart.robot                # Tests du panier
    ├── test_checkout.robot            # Tests du processus de paiement
    └── test_e2e_complete.robot        # Tests end-to-end complets
```

---

## Installation

### Prérequis

- **Python 3.8+**
- **Google Chrome** (ou Firefox)
- **Git** (optionnel)

### Étapes d'installation

1. **Créer un environnement virtuel**
   ```bash
   python -m venv venv

   # Windows
   venv\Scripts\activate

   # Linux/Mac
   source venv/bin/activate
   ```

2. **Installer les dépendances**
   ```bash
   cd automation
   pip install -r requirements.txt
   ```

3. **Vérifier l'installation**
   ```bash
   robot --version
   ```

---

## Exécution des Tests

### Exécuter tous les tests
```bash
robot tests/
```

### Exécuter un fichier de test spécifique
```bash
# Tests d'authentification
robot tests/test_authentication.robot

# Tests de produits
robot tests/test_products.robot

# Tests du panier
robot tests/test_cart.robot

# Tests du checkout
robot tests/test_checkout.robot

# Tests end-to-end
robot tests/test_e2e_complete.robot
```

### Exécuter par tags

```bash
# Tests critiques uniquement
robot --include critique tests/

# Tests d'authentification
robot --include authentification tests/

# Tests de panier
robot --include panier tests/

# Tests end-to-end
robot --include e2e tests/

# Exclure les tests négatifs
robot --exclude negatif tests/
```

### Options avancées

```bash
# Spécifier un navigateur
robot --variable BROWSER:firefox tests/

# Mode headless (sans interface)
robot --variable HEADLESS:True tests/

# Générer des rapports personnalisés
robot --outputdir results --name "Tests_Respire" tests/

# Paralléliser les tests (Pabot)
pabot --processes 4 tests/
```

---

## Cas de Test Couverts

### 1. Authentification (`test_authentication.robot`)
- ✅ Inscription avec données valides
- ✅ Connexion avec identifiants valides
- ✅ Connexion avec mot de passe invalide (négatif)
- ✅ Connexion avec email invalide (négatif)
- ✅ Déconnexion
- ✅ Validation du format email

### 2. Produits et Recherche (`test_products.robot`)
- ✅ Affichage de la page produits
- ✅ Recherche d'un produit valide
- ✅ Recherche d'un produit inexistant (négatif)
- ✅ Affichage des détails d'un produit
- ✅ Vérification des éléments (titre, prix, image)
- ✅ Navigation entre pages de produits
- ✅ Test de chargement des images
- ✅ Test responsive (mobile)

### 3. Panier (`test_cart.robot`)
- ✅ Ajout d'un produit au panier
- ✅ Vérification du contenu du panier
- ✅ Suppression d'un article
- ✅ Ajout de plusieurs produits
- ✅ Modification de la quantité
- ✅ Vérification du total
- ✅ Navigation vers le checkout
- ✅ Persistance du panier après rechargement

### 4. Checkout (`test_checkout.robot`)
- ✅ Accès à la page de paiement
- ✅ Vérification des champs obligatoires
- ✅ Remplissage du formulaire de livraison
- ✅ Validation du format email
- ✅ Test du bouton retour au panier
- ✅ Vérification du résumé de commande
- ✅ Validation des champs vides (négatif)
- ✅ Parcours complet jusqu'au paiement (sans finaliser)
- ✅ Test responsive checkout (mobile)

### 5. End-to-End (`test_e2e_complete.robot`)
- ✅ Parcours utilisateur complet (visiteur non connecté)
- ✅ Parcours de comparaison de produits
- ✅ Parcours avec modification du panier
- ✅ Test de performance (temps de chargement)
- ✅ Test de compatibilité multi-navigateurs
- ✅ Test de sécurité (XSS, SQL injection)
- ✅ Test d'accessibilité (navigation clavier)
- ✅ Test de régression (parcours standard)

**Total : 44+ cas de test automatisés**

---

## Rapports de Test

Après chaque exécution, les rapports sont générés automatiquement :

- **report.html** : Rapport de synthèse visuel
- **log.html** : Log détaillé de chaque action
- **output.xml** : Résultats au format XML
- **Screenshots** : Captures d'écran pour chaque étape importante

### Consulter les rapports
```bash
# Ouvrir le rapport HTML
start report.html    # Windows
open report.html     # Mac
xdg-open report.html # Linux
```

---

## Configuration

### Variables principales (`resources/variables.robot`)

```robot
${BASE_URL}             https://www.respire.co
${BROWSER}              chrome
${TIMEOUT_MEDIUM}       10s
${VALID_USERNAME}       test.respire@example.com
${SEARCH_VALID}         déodorant
```

### Modifier les configurations
1. Ouvrir `resources/variables.robot`
2. Modifier les valeurs selon vos besoins
3. Sauvegarder et relancer les tests

---

## Développement

### Ajouter un nouveau test

1. Créer un fichier dans `tests/`
2. Utiliser le template :

```robot
*** Settings ***
Documentation    Description de votre test
Library          SeleniumLibrary
Resource         ../resources/keywords.robot

Suite Setup      Ouvrir le navigateur
Suite Teardown   Fermer le navigateur

*** Test Cases ***
Mon Nouveau Test
    [Documentation]    Description détaillée
    [Tags]    mon-tag
    Naviguer vers la page produits
    # Vos étapes ici
    Capturer une capture d'écran    mon_test
```

### Ajouter un keyword personnalisé

**Dans `resources/keywords.robot` (Robot)**
```robot
Mon Nouveau Keyword
    [Documentation]    Description
    [Arguments]    ${arg1}    ${arg2}
    Log    Mon keyword avec ${arg1} et ${arg2}
```

**Dans `libraries/custom_keywords.py` (Python)**
```python
def mon_nouveau_keyword(self, arg1, arg2):
    """Description du keyword"""
    return f"{arg1} - {arg2}"
```

---

## Intégration CI/CD

### GitHub Actions (exemple)

```yaml
name: Tests E-commerce

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - run: pip install -r automation/requirements.txt
      - run: robot --variable HEADLESS:True automation/tests/
      - uses: actions/upload-artifact@v2
        with:
          name: test-reports
          path: automation/*.html
```

---

## Bonnes Pratiques

### Selon les Responsabilités du PDF

1. **Test Manager** : Toujours documenter les critères d'acceptation
2. **Test Analyst** : Écrire des cas de test clairs et détaillés
3. **Test Automation Engineer** : Maintenir les scripts à jour avec l'évolution du site
4. **QA Engineer** : Vérifier la qualité globale (sécurité, performance, accessibilité)
5. **Test Architect** : Garder une architecture cohérente et scalable
6. **Defect Manager** : Capturer des screenshots et logs pour chaque anomalie

### Conseils Techniques

- ✅ Toujours utiliser des attentes explicites (`Wait Until...`)
- ✅ Capturer des screenshots aux étapes clés
- ✅ Utiliser des tags pour organiser les tests
- ✅ Nettoyer les données de test après chaque suite
- ✅ Exécuter les tests critiques en priorité
- ⚠️ Ne JAMAIS finaliser un vrai paiement dans les tests

---

## Dépannage

### Problème : Tests échouent sur les locators

**Cause** : Le site Shopify peut avoir des sélecteurs différents
**Solution** :
1. Inspecter l'élément dans le navigateur
2. Mettre à jour `resources/locators.robot`
3. Relancer les tests

### Problème : Timeouts fréquents

**Cause** : Site lent ou connexion internet
**Solution** : Augmenter les timeouts dans `variables.robot`
```robot
${TIMEOUT_LONG}    60s
```

### Problème : WebDriver introuvable

**Solution** : Réinstaller les dépendances
```bash
pip install --upgrade selenium webdriver-manager
```

---

## Statistiques du Projet

- **Fichiers de test** : 5
- **Cas de test** : 44+
- **Keywords personnalisés** : 30+
- **Locators définis** : 60+
- **Couverture** :
  - Authentification : ✅ 100%
  - Navigation/Produits : ✅ 100%
  - Panier : ✅ 100%
  - Checkout : ✅ 80% (sans paiement réel)
  - E2E : ✅ 100%

---

## Contact & Support

- **Projet** : Tests E-commerce Respire.co
- **Framework** : Robot Framework 7.x
- **Maintenu par** : Équipe QA

### Ressources
- [Documentation Robot Framework](https://robotframework.org/)
- [SeleniumLibrary Docs](https://robotframework.org/SeleniumLibrary/)
- [Shopify Testing Best Practices](https://help.shopify.com/en/manual)

---

**Note** : Ce projet est à des fins de test uniquement. Ne jamais effectuer de vrais paiements lors des tests automatisés.
