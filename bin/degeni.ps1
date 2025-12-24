<#
.SYNOPSIS
    DEGENI - Claude + Gemini AI Manager
#>

param(
    [string]$Command,
    [string[]]$Arguments
)

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$DEGENI_HOME = Split-Path -Parent $SCRIPT_DIR
$BIN_DIR = $SCRIPT_DIR
$PROXY_EXE = Join-Path $BIN_DIR "cli-proxy-api.exe"
$PROXY_DIR = Join-Path $env:USERPROFILE "cliproxyapi"
$AUTH_DIR = Join-Path $env:USERPROFILE ".cli-proxy-api"
$CONFIG_FILE = Join-Path $DEGENI_HOME "config\config.json"
$LOGS_DIR = Join-Path $DEGENI_HOME "logs"
$CONFIG_DIR = Join-Path $DEGENI_HOME "config"

if (-not (Test-Path $LOGS_DIR)) { New-Item -ItemType Directory -Path $LOGS_DIR -Force | Out-Null }
if (-not (Test-Path $CONFIG_DIR)) { New-Item -ItemType Directory -Path $CONFIG_DIR -Force | Out-Null }
if (-not (Test-Path $PROXY_DIR)) { New-Item -ItemType Directory -Path $PROXY_DIR -Force | Out-Null }

function Draw-Line {
    Write-Host "--------------------------------------------------------------" -ForegroundColor Cyan
}

function Show-Header {
    Write-Host "  DEGENI MANAGER - Windows Edition" -ForegroundColor Cyan
    Write-Host ""
}

function Is-ProxyRunning {
    $process = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue
    return $null -ne $process
}

function Wait-ForInput {
    Write-Host ""
    Write-Host "  Press Enter..." -ForegroundColor Gray -NoNewline
    Read-Host
}

function Show-Status {
    Draw-Line
    Write-Host " SYSTEM STATUS"
    Draw-Line
    Write-Host ""

    if (Is-ProxyRunning) {
        $proc = Get-Process -Name "cli-proxy-api" | Select-Object -First 1
        Write-Host "  Proxy: Online (PID: $($proc.Id))" -ForegroundColor Green
    } else {
        Write-Host "  Proxy: Offline" -ForegroundColor Red
    }
    
    $accs = @(Get-ChildItem -Path $AUTH_DIR -Filter "antigravity-*.json" -ErrorAction SilentlyContinue)
    Write-Host "  Accounts: $($accs.Count) registered" -ForegroundColor Cyan
    Write-Host ""
}

function List-Accounts {
    Draw-Line
    Write-Host " ACCOUNTS"
    Draw-Line
    Write-Host ""
    
    if (Test-Path $AUTH_DIR) {
        $files = Get-ChildItem -Path $AUTH_DIR -Filter "antigravity-*.json"
        
        if ($files.Count -eq 0) {
            Write-Host "  No accounts found." -ForegroundColor Yellow
        }
        
        $i = 1
        foreach ($f in $files) {
            $name = $f.Name -replace "antigravity-","" -replace ".json",""
            Write-Host "  [$i] $name" -ForegroundColor Green
            $i++
        }
    }
}

function Add-Account {
    Write-Host "Adding account..." -ForegroundColor Cyan
    Write-Host "A browser window will open for Google Login." -ForegroundColor Yellow
    Start-Process -FilePath $PROXY_EXE -ArgumentList "--antigravity-login" -WorkingDirectory $PROXY_DIR -Wait
}

function Restart-Proxy {
    Write-Host "Stopping proxy..." -ForegroundColor Yellow
    Stop-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue -Force
    Start-Sleep -Seconds 1
    
    if (Test-Path $PROXY_EXE) {
        Write-Host "Starting proxy..." -ForegroundColor Green
        
        $startInfo = New-Object System.Diagnostics.ProcessStartInfo
        $startInfo.FileName = $PROXY_EXE
        $startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
        $startInfo.CreateNoWindow = $true
        $startInfo.UseShellExecute = $true
        
        try {
            $process = [System.Diagnostics.Process]::Start($startInfo)
            
            # Wait a bit
            Start-Sleep -Seconds 2
            
            if (Is-ProxyRunning) {
                Write-Host "Done. Proxy is running." -ForegroundColor Green
            } else {
                Write-Host "Failed to start proxy." -ForegroundColor Red
            }
        } catch {
             Write-Host "Error starting process: $_" -ForegroundColor Red
        }
    }
}

function Switch-Model {
    param([string]$Selection)

    Draw-Line
    Write-Host " SWITCH MODEL"
    Draw-Line
    Write-Host ""
    
    $models = @(
        "gemini-claude-sonnet-4-5-thinking",
        "gemini-claude-opus-4-5-thinking",
        "gemini-claude-sonnet-4-5",
        "gemini-3-pro-preview",
        "gemini-2.5-flash"
    )
    
    Write-Host "  [1] $($models[0]) (Recommended)"
    Write-Host "  [2] $($models[1])"
    Write-Host "  [3] $($models[2])"
    Write-Host "  [4] $($models[3]) (Free)"
    Write-Host "  [5] $($models[4]) (Fast)"
    Write-Host ""
    
    if (-not $Selection) {
        $Selection = Read-Host "  Select [1-5]"
    }

    if ($Selection -match "^[1-5]$") {
        $model = $models[[int]$Selection - 1]
        
        $config = @{ default_model = $model }
        if (Test-Path $CONFIG_FILE) {
            try { $existing = Get-Content $CONFIG_FILE | ConvertFrom-Json; if ($existing) { $config = $existing; $config.default_model = $model } } catch {}
        }
        $config | ConvertTo-Json | Set-Content $CONFIG_FILE
        
        $env:DEGENI_DEFAULT_MODEL = $model
        [Environment]::SetEnvironmentVariable("DEGENI_DEFAULT_MODEL", $model, "User")
        
        Write-Host "Switched to: $model" -ForegroundColor Green
    } else {
        Write-Host "Invalid selection: $Selection" -ForegroundColor Red
    }
}

function Test-Accounts {
    Draw-Line
    Write-Host " TESTING ACCOUNTS"
    Draw-Line
    Write-Host ""
    
    $accs = @(Get-ChildItem -Path $AUTH_DIR -Filter "antigravity-*.json" -ErrorAction SilentlyContinue)
    foreach ($f in $accs) {
        $name = $f.Name -replace "antigravity-","" -replace ".json",""
        Write-Host "  Testing $name ... " -NoNewline
        
        try {
            # Minimal test body
            $body = '{ "model": "gemini-claude-sonnet-4-5-thinking", "max_tokens": 1, "messages": [{"role":"user","content":"hi"}] }'
            $uri = "http://localhost:8317/v1/messages"
            $resp = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/json" -Headers @{ "x-api-key"="sk-test"; "anthropic-version"="2023-06-01" } -ErrorAction Stop
            
            if ($resp) { Write-Host "OK" -ForegroundColor Green }
        } catch {
            Write-Host "Failed" -ForegroundColor Red
        }
    }
}

function Chat-Mode {
    Clear-Host
    Show-Header
    Write-Host "Starting Interactive Chat..." -ForegroundColor Cyan
    Write-Host "Type 'exit' to quit." -ForegroundColor Gray
    Write-Host ""
    
    if (-not (Is-ProxyRunning)) { Restart-Proxy }
    
    $claude = Join-Path $BIN_DIR "claude.ps1"
    & $claude
}

function Show-Menu {
    Write-Host ""
    Write-Host " [1] Chat"
    Write-Host " [2] Status"
    Write-Host " [3] List Accounts"
    Write-Host " [4] Add Account"
    Write-Host " [5] Switch Model"
    Write-Host " [6] Restart Proxy"
    Write-Host " [7] Test Accounts"
    Write-Host " [0] Exit"
    Write-Host ""
    return Read-Host " Select"
}

if ($Command) {
    if ($Command -eq "chat") { Chat-Mode; exit }
    if ($Command -eq "status") { Show-Status; exit }
    if ($Command -eq "list") { List-Accounts; exit }
    if ($Command -eq "add") { Add-Account; exit }
    if ($Command -eq "restart") { Restart-Proxy; exit }
    if ($Command -eq "model") { Switch-Model $Arguments[0]; exit }
    if ($Command -eq "test") { Test-Accounts; exit }
    
    # Fallback to claude
    $claude = Join-Path $BIN_DIR "claude.ps1"
    & $claude $Command $Arguments
    exit
}

while ($true) {
    Clear-Host
    Show-Header
    Show-Status
    $sel = Show-Menu
    
    if ($sel -eq "1") { Chat-Mode }
    elseif ($sel -eq "2") { Show-Status; Wait-ForInput }
    elseif ($sel -eq "3") { List-Accounts; Wait-ForInput }
    elseif ($sel -eq "4") { Add-Account; Wait-ForInput }
    elseif ($sel -eq "5") { Switch-Model; Wait-ForInput }
    elseif ($sel -eq "6") { Restart-Proxy; Wait-ForInput }
    elseif ($sel -eq "7") { Test-Accounts; Wait-ForInput }
    elseif ($sel -eq "0") { exit }
    elseif ($sel -eq "q") { exit }
}
