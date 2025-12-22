<#
.SYNOPSIS
    DEGENI Windows Uninstallation Script

.DESCRIPTION
    Removes DEGENI from Windows PATH.
    Does NOT delete files - only removes PATH entry.

.EXAMPLE
    .\uninstall-windows.ps1
#>

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$BIN_DIR = Join-Path $SCRIPT_DIR "bin"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

Write-Host ""
Write-ColorOutput "DEGENI Windows Uninstaller" "Cyan"
Write-Host ""

# Stop proxy if running
$processes = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue
if ($processes) {
    Write-ColorOutput "[>>] Stopping CLIProxyAPI..." "Yellow"
    Stop-Process -Name "cli-proxy-api" -Force -ErrorAction SilentlyContinue
    Write-ColorOutput "[OK] Stopped proxy" "Green"
}

# Remove from PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -like "*$BIN_DIR*") {
    Write-ColorOutput "[>>] Removing from PATH..." "Cyan"
    
    $pathParts = $currentPath -split ";" | Where-Object { $_ -ne $BIN_DIR -and $_ -ne "" }
    $newPath = $pathParts -join ";"
    
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    
    Write-ColorOutput "[OK] Removed from PATH" "Green"
}
else {
    Write-ColorOutput "[i] bin/ folder was not in PATH" "Yellow"
}

Write-Host ""
Write-ColorOutput "========================================================" "Green"
Write-ColorOutput "              [OK] Uninstallation Complete!" "Green"
Write-ColorOutput "========================================================" "Green"
Write-Host ""
Write-ColorOutput "Files preserved in: $SCRIPT_DIR" "Gray"
Write-ColorOutput "   Delete manually if you want to remove everything" "Gray"
Write-Host ""
