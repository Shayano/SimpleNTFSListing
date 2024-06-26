# SimpleNTFSListing

Ce script PowerShell permet d'exporter les droits NTFS associés à un dossier et à ses sous-dossiers jusqu'à une profondeur de 2 niveaux, sous forme de fichier CSV avec des séparateurs de colonnes en point-virgule (;).

## Prérequis

- PowerShell
- Module `NTFSSecurity`

## Installation du module NTFSSecurity

Pour installer le module `NTFSSecurity`, exécutez la commande suivante dans PowerShell :

```powershell
Install-Module -Name NTFSSecurity -Force
```

## Utilisation

1. Clonez ce dépôt ou copiez le script dans un fichier `.ps1` local.
2. Modifiez les variables `$rootPath` et `$outputCsv` dans le script pour définir le chemin du dossier à analyser et le fichier CSV de sortie.
3. Exécutez le script PowerShell.

# Définition du chemin du dossier racine et du fichier CSV de sortie
$rootPath = "C:\Chemin\Vers\Votre\Dossier"
$outputCsv = "C:\Chemin\Vers\Votre\Fichier.csv"

# Obtenir les ACLs jusqu'à une profondeur de 2 niveaux
Get-NTFSPermissions -Path $rootPath -Depth 2
