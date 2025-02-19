# Paramètres
$cheminFichierGroupes = "./groupes.txt"
$cheminFichierCSV = "./sortie.csv"

# Importe la liste des groupes depuis le fichier
try {
    $groupes = Get-Content $cheminFichierGroupes | ForEach-Object { $_.Trim() }
}
catch {
    Write-Error "Erreur lors de la lecture du fichier de groupes : $($_.Exception.Message)"
    return
}

# Vérification des paramètres
if (-not $groupes) {
    Write-Error "Le fichier de groupes est vide ou introuvable."
    return
}

# Tableau pour stocker les résultats
$resultats = @()

# Traitement des groupes
foreach ($groupe in $groupes) {
    try {
        # Récupère les informations du groupe
        $groupeAD = Get-ADGroup -Identity $groupe -Properties *

        # Récupère les membres du groupe
        $membres = Get-ADGroupMember -Identity $groupe | Get-ADUser -Properties SamAccountName, Email

        # Pour chaque membre, ajoute les informations au tableau
        foreach ($membre in $membres) {
            $resultat = [PSCustomObject]@{
                NomGroupe      = $groupeAD.Name
                SamAccountName = $membre.SamAccountName
                Email          = $membre.Email
            }
            $resultats += $resultat
        }
    }
    catch {
        Write-Error "Erreur lors du traitement du groupe '$groupe' : $($_.Exception.Message)"
    }
}

# Exporte les résultats vers un fichier CSV
try {
    $resultats | Export-Csv -Path $cheminFichierCSV -NoTypeInformation -Encoding UTF8
    Write-Host "Les résultats ont été exportés vers '$cheminFichierCSV'."
}
catch {
    Write-Error "Erreur lors de l'exportation vers le CSV : $($_.Exception.Message)"
}

Write-Host "Terminé."