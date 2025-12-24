<#
.SYNOPSIS
    Check CLIProxyAPI status

.DESCRIPTION
    Shows the current status of CLIProxyAPI including:
    - Process status
    - Port availability
    - API health check
#>

$PROXY_PORT = 8317
$PROXY_URL = "http://localhost:$PROXY_PORT"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

Write-Host ""
Write-ColorOutput "=============================================" "Cyan"
Write-ColorOutput "      CLIProxyAPI Status Check" "Cyan"
Write-ColorOutput "=============================================" "Cyan"
Write-Host ""

# Check process
$processes = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue

if ($processes) {
    foreach ($proc in $processes) {
        Write-ColorOutput "[OK] Process: Running (PID: $($proc.Id))" "Green"
        Write-ColorOutput "   Memory: $([math]::Round($proc.WorkingSet64 / 1MB, 2)) MB" "Gray"
        Write-ColorOutput "   Started: $($proc.StartTime)" "Gray"
    }
}
else {
    Write-ColorOutput "[X] Process: Not running" "Red"
}

Write-Host ""

# Check port
$tcpConnection = Get-NetTCPConnection -LocalPort $PROXY_PORT -ErrorAction SilentlyContinue
if ($tcpConnection) {
    Write-ColorOutput "[OK] Port $($PROXY_PORT): Listening" "Green"
}
else {
    Write-ColorOutput "[X] Port $($PROXY_PORT): Not listening" "Red"
}

Write-Host ""

# Check API health
try {
    $response = Invoke-WebRequest -Uri "$PROXY_URL/v1/models" -TimeoutSec 5 -ErrorAction Stop
    Write-ColorOutput "[OK] API Health: Responding" "Green"
    Write-ColorOutput "   URL: $PROXY_URL" "Gray"
}
catch {
    Write-ColorOutput "[X] API Health: Not responding" "Red"
    Write-ColorOutput "   Error: $($_.Exception.Message)" "Gray"
}

Write-Host ""
Write-ColorOutput "=============================================" "Cyan"
