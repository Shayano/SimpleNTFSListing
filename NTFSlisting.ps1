# Importation du module NTFSSecurity
Import-Module NTFSSecurity

# Définition du chemin du dossier racine et du fichier CSV de sortie
$rootPath = "E:\Shares"
$outputCsv = "C:\output\output.csv"

# Fonction pour obtenir les ACLs jusqu'à une profondeur spécifiée
function Get-NTFSPermissions {
    param (
        [string]$Path,
        [int]$Depth
    )

    # Si la profondeur est atteinte, retourner
    if ($Depth -le 0) {
        return
    }

    # Obtenir les ACL pour le dossier actuel
    $acl = Get-NTFSAccess $Path

    # Créer un objet pour chaque entrée ACL et l'ajouter à la liste
    foreach ($entry in $acl) {
        $obj = [PSCustomObject]@{
            Path           = $Path
            Identity       = $entry.Account
            Rights         = ($entry.AccessRights -join "; ")
            Inheritance    = ($entry.InheritanceFlags -join "; ")
            Propagation    = ($entry.PropagationFlags -join "; ")
            AccessControl  = $entry.AccessControlType
            IsInherited    = $entry.IsInherited
        }
        $global:aclList += $obj
    }

    # Obtenir les sous-dossiers et répéter le processus
    $subDirs = Get-ChildItem -Path $Path -Directory
    foreach ($dir in $subDirs) {
        Get-NTFSPermissions -Path $dir.FullName -Depth ($Depth - 1)
    }
}

# Initialiser la liste globale pour stocker les ACLs
$global:aclList = @()

# Obtenir les ACLs jusqu'à une profondeur de 2 niveaux
Get-NTFSPermissions -Path $rootPath -Depth 2

# Exporter la liste des ACLs vers un fichier CSV avec point-virgule comme délimiteur
$global:aclList | Export-Csv -Path $outputCsv -NoTypeInformation -Delimiter ';' -Encoding UTF8

Write-Host "Exportation des ACLs NTFS terminée. Le fichier est enregistré à $outputCsv"
