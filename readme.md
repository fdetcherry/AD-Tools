## Explication du script

**Paramètres **: Définissez les chemins vers vos fichiers d'utilisateurs et de groupes.
**Importation des données **: Lecture des fichiers texte et stockage des listes dans des variables.
**Vérification des paramètres **: Assure que les fichiers existent et ne sont pas vides.
**Boucles imbriquées *:
La boucle extérieure parcourt chaque utilisateur.
La boucle intérieure parcourt chaque groupe.
**Recherche de l'utilisateur dans l'AD **: Utilise Get-ADUser avec un filtre sur l'adresse e-mail. Vous pouvez adapter le filtre si besoin (par exemple, SamAccountName).
**Ajout au groupe **: Utilise Add-ADGroupMember pour ajouter l'utilisateur au groupe.
**Gestion des erreurs **: Des blocs try...catch capturent les erreurs potentielles et affichent des messages clairs.
**Messages **:
Write-Verbose: Messages détaillés (activés avec -Verbose).
Write-Warning: Avertissements (par exemple, utilisateur non trouvé).
Write-Error: Erreurs bloquantes.
Write-Host: Message final de confirmation.

## Améliorations

Gestion des erreurs: Plus robuste avec des blocs try...catch.
Recherche flexible: Possibilité d'adapter le filtre Get-ADUser.
Messages clairs: Plus d'informations sur le déroulement du script.
Options d'identification: Vous pouvez ajouter des paramètres pour spécifier les credentials d'un utilisateur ayant les droits nécessaires dans l'AD.

## Comment utiliser

Créez les fichiers texte:
utilisateurs.txt: Liste des adresses e-mail (une par ligne).
groupes.txt: Liste des noms de groupes AD (une par ligne).
Exécutez le script:*
Ouvrez PowerShell en tant qu'administrateur.
Naviguez jusqu'au répertoire du script.
Exécutez : .\addUserToADGroup.ps1 -Verbose (le paramètre -Verbose affiche les messages détaillés).