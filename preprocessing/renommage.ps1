$maskDir = "C:\Users\kalzm\Documents\dataset\images"   # Remplacez par le chemin du répertoire de masques
$outputDir = "C:\Users\kalzm\Documents\dataset\renamed_images"   # Nouveau répertoire de destination
$counter = 1
$maxFiles = 1500  # Le nombre maximum de fichiers à copier

# Créez le répertoire de destination s'il n'existe pas
if (-not (Test-Path -Path $outputDir -PathType Container)) {
    New-Item -Path $outputDir -ItemType Directory
}

# Obtenez la liste des fichiers sans tri particulier
$maskFiles = Get-ChildItem -Path $maskDir

# Boucle pour renommer et créer des copies des fichiers
foreach ($maskFile in $maskFiles) {
    if ($counter -gt $maxFiles) {
        break  # Sortez de la boucle après avoir copié 1500 fichiers
    }

    $extension = $maskFile.Extension
    $newName = "{0:D4}{1}" -f $counter, $extension
    Copy-Item -Path $maskFile.FullName -Destination (Join-Path -Path $outputDir -ChildPath $newName)
    $counter++
}

Write-Host "Copie des fichiers de masques terminée. Les copies se trouvent dans $outputDir."
