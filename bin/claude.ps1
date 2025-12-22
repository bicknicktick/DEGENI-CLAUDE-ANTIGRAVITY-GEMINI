<#
.SYNOPSIS
    DEGENI Claude Launcher - Native Windows wrapper for Claude Code CLI

.DESCRIPTION
    Launches Claude Code CLI with Antigravity proxy configuration.
    Automatically starts the proxy if not running.

.EXAMPLE
    claude
    # Starts interactive Claude Code session

.EXAMPLE
    claude "explain docker"
    # Quick question mode
#>

param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

# ============================================================
# Configuration
# ============================================================
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$DEGENI_HOME = Split-Path -Parent $SCRIPT_DIR
$CONFIG_FILE = Join-Path $DEGENI_HOME "config\config.json"

if (Test-Path $CONFIG_FILE) {
    try {
        $Config = Get-Content $CONFIG_FILE | ConvertFrom-Json
        if ($Config.default_model) {
            $env:DEGENI_DEFAULT_MODEL = $Config.default_model
        }
    } catch {}
}

$PROXY_PORT = 8317
$PROXY_URL = "http://localhost:$PROXY_PORT"
$DEFAULT_MODEL = "gemini-claude-sonnet-4-5-thinking"
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PROXY_EXE = Join-Path $SCRIPT_DIR "cli-proxy-api.exe"
$STARTUP_TIMEOUT = 15  # seconds to wait for proxy to start

# ============================================================
# Helper Functions
# ============================================================

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Test-ProxyRunning {
    try {
        $response = Invoke-WebRequest -Uri "$PROXY_URL/v1/models" -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Test-ProxyProcess {
    $process = Get-Process -Name "cli-proxy-api" -ErrorAction SilentlyContinue
    return $null -ne $process
}

function Start-Proxy {
    Write-ColorOutput "[>>] Starting CLIProxyAPI..." "Cyan"
    
    if (-not (Test-Path $PROXY_EXE)) {
        Write-ColorOutput "[ERROR] cli-proxy-api.exe not found at $PROXY_EXE" "Red"
        Write-ColorOutput "   Please run install-windows.ps1 first" "Yellow"
        exit 1
    }
    
    # Start proxy as background process (hidden window)
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $PROXY_EXE
    $startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $startInfo.CreateNoWindow = $true
    $startInfo.UseShellExecute = $true
    
    $process = [System.Diagnostics.Process]::Start($startInfo)
    
    Write-ColorOutput "[..] Waiting for proxy to start..." "Yellow"
    
    # Wait for proxy to become available
    $elapsed = 0
    while ($elapsed -lt $STARTUP_TIMEOUT) {
        Start-Sleep -Seconds 1
        $elapsed++
        
        if (Test-ProxyRunning) {
            Write-ColorOutput "[OK] Proxy started successfully!" "Green"
            return $true
        }
        
        Write-Host "." -NoNewline
    }
    
    Write-Host ""
    Write-ColorOutput "[ERROR] Proxy failed to start within $STARTUP_TIMEOUT seconds" "Red"
    Write-ColorOutput "   Try running 'cli-proxy-api.exe' manually to see errors" "Yellow"
    return $false
}

function Show-Banner {
    Write-Host ""
    Write-ColorOutput "============================================================" "Cyan"
    Write-ColorOutput "          DEGENI - Claude Code via Antigravity              " "Cyan"
    Write-ColorOutput "============================================================" "Cyan"
    Write-Host ""
}

# ============================================================
# Main Script
# ============================================================

# Show banner for interactive mode
if ($Arguments.Count -eq 0) {
    Show-Banner
}

# Check if proxy is running
if (-not (Test-ProxyRunning)) {
    if (Test-ProxyProcess) {
        Write-ColorOutput "[!] Proxy process exists but not responding. Waiting..." "Yellow"
        
        # Wait up to 10 seconds for proxy to become responsive
        $retries = 0
        while ($retries -lt 10) {
            Start-Sleep -Seconds 1
            $retries++
            if (Test-ProxyRunning) {
                break
            }
        }
        
        if (-not (Test-ProxyRunning)) {
            Write-ColorOutput "[ERROR] Proxy still not responding. Please check cli-proxy-api.exe" "Red"
            exit 1
        }
    }
    else {
        # Proxy not running, try to start it
        if (-not (Start-Proxy)) {
            exit 1
        }
    }
}
else {
    if ($Arguments.Count -eq 0) {
        Write-ColorOutput "[OK] Proxy is running on $PROXY_URL" "Green"
    }
}

# Set environment variables for Claude Code
# First, remove any existing auth tokens (from Giga or other services)
Remove-Item Env:ANTHROPIC_AUTH_TOKEN -ErrorAction SilentlyContinue
Remove-Item Env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue

# Now set our proxy URL (unless updating)
if ($Arguments -contains "update") {
    Write-ColorOutput "[!] Update command detected: Bypassing proxy to allow connection to Anthropic servers." "Yellow"
    Remove-Item Env:ANTHROPIC_BASE_URL -ErrorAction SilentlyContinue
}
else {
    $env:ANTHROPIC_BASE_URL = $PROXY_URL
}

# Set the Antigravity API key (used by existing working scripts)
$env:ANTHROPIC_API_KEY = "sk-ycY2nDJ7VvvnWPnYEAf3pc84n9sdDQFjD8tb8nlb2f7Du"

# Set default model if not already set
# Determine model
$targetModel = $DEFAULT_MODEL

if ($env:DEGENI_DEFAULT_MODEL) {
    $targetModel = $env:DEGENI_DEFAULT_MODEL
}

# Force update ANTHROPIC_MODEL to ensure the correct one is used
$env:ANTHROPIC_MODEL = $targetModel

if ($Arguments.Count -eq 0) {
    Write-ColorOutput "[*] Using model: $($env:ANTHROPIC_MODEL)" "Magenta"
    Write-Host ""
}

# Launch Claude Code CLI
$CLAUDE_EXE = $null

# Priority 1: Check standard NPM global path
$NPM_CLAUDE = Join-Path $env:APPDATA "npm\claude.cmd"
if (Test-Path $NPM_CLAUDE) {
    $CLAUDE_EXE = $NPM_CLAUDE
}

# Priority 2: Check .local/bin (Standalone installer)
if (-not $CLAUDE_EXE) {
    $LOCAL_CLAUDE = "C:\Users\Amrem\.local\bin\claude.exe"
    if (Test-Path $LOCAL_CLAUDE) {
        $CLAUDE_EXE = $LOCAL_CLAUDE
    }
}

# Priority 3: Fallback to PATH search (excluding wrapper)
if (-not $CLAUDE_EXE) {
    $allClaudes = where.exe claude
    $CLAUDE_EXE = ($allClaudes | Where-Object { $_ -notlike "*DEGENI*" }) | Select-Object -First 1
}

try {
    if ($Arguments.Count -gt 0) {
        # Pass all arguments to claude
        & $CLAUDE_EXE @Arguments
    }
    else {
        # Interactive mode
        & $CLAUDE_EXE
    }
}
catch {
    Write-ColorOutput "[ERROR] Error launching Claude Code: $_" "Red"
    Write-ColorOutput "   Make sure Claude Code CLI is installed: npm install -g @anthropic-ai/claude-code" "Yellow"
    exit 1
}
