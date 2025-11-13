"""
Bibliothèque personnalisée de keywords Python pour Robot Framework
"""
import json
import re
from datetime import datetime
from pathlib import Path


class CustomKeywords:
    """Keywords personnalisés pour étendre les fonctionnalités de Robot Framework"""

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.data_dir = Path(__file__).parent.parent / 'data'

    def charger_donnees_json(self, filename):
        """
        Charge un fichier JSON depuis le dossier data

        Args:
            filename: Nom du fichier JSON à charger

        Returns:
            dict: Données JSON chargées

        Example:
            | ${data}= | Charger Donnees JSON | test_data.json |
        """
        filepath = self.data_dir / filename
        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)

    def generer_email_unique(self, prefix='test'):
        """
        Génère une adresse email unique avec un timestamp

        Args:
            prefix: Préfixe pour l'email

        Returns:
            str: Email unique

        Example:
            | ${email}= | Generer Email Unique | user |
            | # Retourne: user_20240113_143052@test.com |
        """
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        return f"{prefix}_{timestamp}@test.com"

    def valider_format_email(self, email):
        """
        Valide le format d'une adresse email

        Args:
            email: Adresse email à valider

        Returns:
            bool: True si valide, False sinon

        Example:
            | ${valid}= | Valider Format Email | user@example.com |
        """
        pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return bool(re.match(pattern, email))

    def nettoyer_texte(self, text):
        """
        Nettoie un texte en supprimant les espaces superflus

        Args:
            text: Texte à nettoyer

        Returns:
            str: Texte nettoyé

        Example:
            | ${clean}= | Nettoyer Texte | ${raw_text} |
        """
        return ' '.join(text.split())

    def comparer_listes(self, list1, list2):
        """
        Compare deux listes et retourne les différences

        Args:
            list1: Première liste
            list2: Deuxième liste

        Returns:
            dict: Dictionnaire avec les éléments uniques de chaque liste

        Example:
            | ${diff}= | Comparer Listes | ${list_a} | ${list_b} |
        """
        set1 = set(list1)
        set2 = set(list2)
        return {
            'only_in_list1': list(set1 - set2),
            'only_in_list2': list(set2 - set1),
            'common': list(set1 & set2)
        }

    def generer_timestamp(self, format='%Y-%m-%d %H:%M:%S'):
        """
        Génère un timestamp au format spécifié

        Args:
            format: Format du timestamp (défaut: '%Y-%m-%d %H:%M:%S')

        Returns:
            str: Timestamp formaté

        Example:
            | ${timestamp}= | Generer Timestamp |
            | ${timestamp}= | Generer Timestamp | %Y%m%d |
        """
        return datetime.now().strftime(format)
