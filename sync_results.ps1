# --- CONFIGURATION ---
$SourceRepo = "https://github.com/DontSlipOnDirt/NL2Vis.git"
$SourceFolder = "results"
$DestinationFolder = "results_synced"
$TempDir = ".temp_sync"

# 1. Clean up old temp data
if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir }

# 2. Clone the source repo shallowly (faster, only gets latest version)
Write-Host "Cloning latest data from NL2Vis..." -ForegroundColor Cyan
git clone --depth 1 --filter=blob:none --sparse $SourceRepo $TempDir

# 3. Use sparse-checkout in the temp folder to get only the results folder
cd $TempDir
git sparse-checkout set $SourceFolder
cd ..

# 4. Move the folder to thesis repo
if (Test-Path $DestinationFolder) { 
    Write-Host "Updating existing results folder..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $DestinationFolder 
}

Move-Item -Path "$TempDir\$SourceFolder" -Destination $DestinationFolder

# 5. Final Cleanup
Remove-Item -Recurse -Force $TempDir

Write-Host "Success! Latest results are now in /$DestinationFolder" -ForegroundColor Green