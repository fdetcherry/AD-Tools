## Explication du script

Paramètres : Définissez les chemins vers votre fichier de groupes et le fichier CSV de sortie.
Importation des données : Lecture du fichier texte et stockage de la liste des groupes dans une variable.
Vérification des paramètres : Assure que le fichier existe et n'est pas vide.
Boucle sur les groupes *:

- Récupère les informations du groupe avec Get-ADGroup.
- Récupère les membres du groupe avec Get-ADGroupMember et leurs informations (SamAccountName, Email) avec Get-ADUser.
- Pour chaque membre, crée un objet personnalisé avec les informations du groupe et de l'utilisateur.
- Ajoute cet objet à un tableau $resultats.
Exportation vers CSV : Exporte le tableau $resultats vers un fichier CSV avec Export-Csv.

## Améliorations

Gestion des erreurs: Plus robuste avec des blocs try...catch.
Informations du groupe: Inclut le nom du groupe dans le fichier CSV.
Encodage UTF8: Utilise l'encodage UTF8 pour le fichier CSV, ce qui gère mieux les caractères spéciaux.

## Comment utiliser

Créez le fichier texte:
groupes.txt: Liste des noms de groupes AD (un par ligne).
Exécutez le script:*
Ouvrez PowerShell en tant qu'administrateur.
Naviguez jusqu'au répertoire du script.
Exécutez : .\listADGroupsUsers.ps1
Le fichier CSV contiendra les informations demandées pour chaque utilisateur de chaque groupe.