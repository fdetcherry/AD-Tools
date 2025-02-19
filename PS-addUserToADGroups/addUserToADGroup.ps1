# Paramètres
$cheminFichierUtilisateurs = "./utilisateurs.txt"
$cheminFichierGroupes = "./groupes.txt"

# Importe les listes depuis les fichiers
try {
    $utilisateurs = Get-Content $cheminFichierUtilisateurs | ForEach-Object { $_.Trim() }
    $groupes = Get-Content $cheminFichierGroupes | ForEach-Object { $_.Trim() }
}
catch {
    Write-Error "Erreur lors de la lecture des fichiers : $($_.Exception.Message)"
    return
}

# Vérification des paramètres
if (-not $utilisateurs) {
    Write-Error "Le fichier d'utilisateurs est vide ou introuvable."
    return
}
if (-not $groupes) {
    Write-Error "Le fichier de groupes est vide ou introuvable."
    return
}

# Traitement des utilisateurs et groupes
foreach ($utilisateur in $utilisateurs) {
    # Recherche l'utilisateur dans l'AD (plusieurs options possibles)
    $utilisateurAD = Get-ADUser -Filter "Email -eq '$utilisateur'" -Properties Email, SamAccountName
    # Si l'utilisateur n'est pas trouvé, on passe au suivant
    if (-not $utilisateurAD) {
        Write-Warning "Utilisateur '$utilisateur' non trouvé dans l'AD."
        continue
    }

    foreach ($groupe in $groupes) {
        try {
            # Ajoute l'utilisateur au groupe
            Add-ADGroupMember -Identity $groupe -Members $utilisateurAD.SamAccountName
            Write-Verbose "Utilisateur '$utilisateur' ajouté au groupe '$groupe'."
        }
        catch {
            Write-Error "Erreur lors de l'ajout de '$utilisateur' à '$groupe' : $($_.Exception.Message)"
        }
    }
}

Write-Host "Terminé."