#!/usr/bin/env python3

# Remarque importante : 
# Avant d'exécuter ce script, assurez-vous de faire les actions suivantes :
# 1. Modifier les informations de connexion à la base de données PostgreSQL dans les variables 'user', 'password', 'host', 'port' et 'database'.
# 2. Télécharger le fichier 'output.zip' contenant les fichiers Excel avec les données des terminologies récupérées via l'API.
# 3. Extraire le contenu de 'output.zip' dans le dossier 'output' (ou le dossier de votre choix).
#    Assurez-vous que le dossier 'output' contient les fichiers Excel avant d'exécuter le script.

import os
import glob
import pandas as pd
from sqlalchemy import create_engine, text

# Paramètres de connexion PostgreSQL (à adapter selon votre environnement)
user = "postgres_user"
password = "mot_de_passe_postgres"
host = "host_postgres"
port = "5432"
database = "schéma"  # Dans notre exemple, "schéma" est "inc"

# Construction de la chaîne de connexion PostgreSQL
connection_string = f"postgresql://{user}:{password}@{host}:{port}/{database}"
engine = create_engine(connection_string)

# Chemin du dossier contenant les fichiers Excel
folder_path = "output"  # Adapter le chemin si nécessaire

# Affichage du chemin absolu pour vérification
print(f"Chemin absolu : {os.path.abspath(folder_path)}")

# Recherche de tous les fichiers Excel (.xlsx) dans le dossier spécifié
excel_files = glob.glob(os.path.join(folder_path, "*.xlsx"))

# Affichage des fichiers trouvés
print(f"Fichiers trouvés : {excel_files}")

# Liste pour stocker les DataFrames (tables de données)
df_list = []

# Lecture de chaque fichier Excel et ajout dans la liste
for file in excel_files:
    print(f"Lecture du fichier : {file}")
    df = pd.read_excel(file)  # Chargement du fichier dans un DataFrame pandas
    df_list.append(df)  # Ajout du DataFrame à la liste

# Concaténation de tous les DataFrames en un seul
combined_df = pd.concat(df_list, ignore_index=True)

# Dictionnaire de correspondance pour renommer les colonnes
column_mapping = {
    "Niveau code": "Niveau"  # Renommage de la colonne "Niveau code" en "Niveau"
}

# Application du renommage
combined_df.rename(columns=column_mapping, inplace=True)
print(combined_df.head())  # Affichage des premières lignes du DataFrame pour vérification

# Transformation du DataFrame en liste de dictionnaires (format compatible avec SQLAlchemy)
records = combined_df.to_dict(orient="records")

# Insertion des données dans PostgreSQL en évitant les doublons
with engine.connect() as conn:
    trans = conn.begin()  # Démarrer une transaction
    try:
        conn.execute(text("""
            INSERT INTO osiris.terminologies ("Item_ID", "Parent_ID", "Niveau", "Description_EN", "Description_FR", "Table_ID", "Version_ID")
            VALUES (:Item_ID, :Parent_ID, :Niveau, :Description_EN, :Description_FR, :Table_ID, :Version_ID)
            ON CONFLICT ("Item_ID", "Table_ID", "Version_ID") DO NOTHING;
        """), records)  # Insertion en masse avec gestion des conflits (évite les doublons)
        
        trans.commit()  # Validation de la transaction
        print("✅ Insertion validée avec succès.")
    except Exception as e:
        trans.rollback()  # Annulation de la transaction en cas d'erreur
        print(f"❌ Erreur : {e}")

print("✅ Insertion terminée sans erreur de doublon.")
