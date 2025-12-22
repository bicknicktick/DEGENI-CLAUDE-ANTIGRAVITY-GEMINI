<#
.SYNOPSIS
    Start CLIProxyAPI in background

.DESCRIPTION
    Starts the CLI Proxy API as a hidden background process.
    The proxy will listen on localhost:8317.
#>

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PROXY_EXE = Join-Path $SCRIPT_DIR "cli-proxy-api.exe"
$PROXY_PORT = 8317

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

# Check if already running
$existingProcess = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue
if ($existingProcess) {
    Write-ColorOutput "[!] CLIProxyAPI is already running (PID: $($existingProcess.Id))" "Yellow"
    exit 0
}

# Check if executable exists
if (-not (Test-Path $PROXY_EXE)) {
    Write-ColorOutput "[ERROR] cli-proxy-api.exe not found" "Red"
    Write-ColorOutput "   Expected location: $PROXY_EXE" "Yellow"
    Write-ColorOutput "   Run install-windows.ps1 to download it" "Yellow"
    exit 1
}

Write-ColorOutput "[>>] Starting CLIProxyAPI..." "Cyan"

# Start as hidden background process
$startInfo = New-Object System.Diagnostics.ProcessStartInfo
$startInfo.FileName = $PROXY_EXE
$startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$startInfo.CreateNoWindow = $true
$startInfo.UseShellExecute = $true

$process = [System.Diagnostics.Process]::Start($startInfo)

Write-ColorOutput "[OK] CLIProxyAPI started (PID: $($process.Id))" "Green"
Write-ColorOutput "[*] Listening on http://localhost:$($PROXY_PORT)" "Cyan"
Write-ColorOutput ""
Write-ColorOutput "Tip: Use stop-proxy.ps1 to stop the proxy" "Gray"
