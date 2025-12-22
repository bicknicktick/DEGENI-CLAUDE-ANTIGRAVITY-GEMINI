<#
.SYNOPSIS
    Stop CLIProxyAPI

.DESCRIPTION
    Stops any running CLIProxyAPI processes.
#>

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

$processes = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue

if (-not $processes) {
    Write-ColorOutput "[i] CLIProxyAPI is not running" "Yellow"
    exit 0
}

Write-ColorOutput "[>>] Stopping CLIProxyAPI..." "Cyan"

foreach ($proc in $processes) {
    try {
        Stop-Process -Id $proc.Id -Force
        Write-ColorOutput "[OK] Stopped process (PID: $($proc.Id))" "Green"
    }
    catch {
        Write-ColorOutput "[ERROR] Failed to stop process (PID: $($proc.Id)): $_" "Red"
    }
}

Write-ColorOutput "[OK] CLIProxyAPI stopped" "Green"
