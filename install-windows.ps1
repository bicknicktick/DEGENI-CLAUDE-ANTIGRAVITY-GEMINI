<#
.SYNOPSIS
    DEGENI Windows Installation Script

.DESCRIPTION
    Installs DEGENI for Windows:
    1. Downloads CLIProxyAPI if not present
    2. Adds bin/ folder to user PATH
    3. Shows next steps for authentication

.EXAMPLE
    .\install-windows.ps1
#>

param(
    [switch]$SkipDownload,
    [switch]$SkipPath
)

$ErrorActionPreference = "Stop"

# Configuration
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$BIN_DIR = Join-Path $SCRIPT_DIR "bin"
$PROXY_EXE = Join-Path $BIN_DIR "cli-proxy-api.exe"
$CLIPROXY_VERSION = "6.6.39"
$CLIPROXY_URL = "https://github.com/router-for-me/CLIProxyAPI/releases/download/v$CLIPROXY_VERSION/CLIProxyAPI_${CLIPROXY_VERSION}_windows_amd64.zip"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Write-Banner {
    Write-Host ""
    Write-ColorOutput "================================================================" "Cyan"
    Write-ColorOutput "                                                                " "Cyan"
    Write-ColorOutput "         DDDDDD  EEEEEEE  GGGGG  EEEEEEE NN   NN IIIII          " "Cyan"
    Write-ColorOutput "         DD   DD EE      GG      EE      NNN  NN  III           " "Cyan"
    Write-ColorOutput "         DD   DD EEEEE   GG  GGG EEEEE   NN N NN  III           " "Cyan"
    Write-ColorOutput "         DD   DD EE      GG   GG EE      NN  NNN  III           " "Cyan"
    Write-ColorOutput "         DDDDDD  EEEEEEE  GGGGG  EEEEEEE NN   NN IIIII          " "Cyan"
    Write-ColorOutput "                                                                " "Cyan"
    Write-ColorOutput "              Windows Installation Script                       " "Cyan"
    Write-ColorOutput "                                                                " "Cyan"
    Write-ColorOutput "================================================================" "Cyan"
    Write-Host ""
}

function Test-NodeInstalled {
    try {
        $version = node --version 2>$null
        return $true
    }
    catch {
        return $false
    }
}

function Test-ClaudeInstalled {
    try {
        $version = claude --version 2>$null
        return $true
    }
    catch {
        return $false
    }
}

function Download-CLIProxyAPI {
    if (Test-Path $PROXY_EXE) {
        Write-ColorOutput "[OK] cli-proxy-api.exe already exists" "Green"
        return
    }
    
    Write-ColorOutput "[>>] Downloading CLIProxyAPI v$CLIPROXY_VERSION..." "Cyan"
    
    $tempZip = Join-Path $env:TEMP "cliproxyapi.zip"
    $tempDir = Join-Path $env:TEMP "cliproxyapi"
    
    try {
        # Download
        Invoke-WebRequest -Uri $CLIPROXY_URL -OutFile $tempZip -UseBasicParsing
        
        # Extract
        if (Test-Path $tempDir) {
            Remove-Item $tempDir -Recurse -Force
        }
        Expand-Archive -Path $tempZip -DestinationPath $tempDir -Force
        
        # Copy executable
        Copy-Item (Join-Path $tempDir "cli-proxy-api.exe") -Destination $PROXY_EXE -Force
        
        # Cleanup
        Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        
        Write-ColorOutput "[OK] Downloaded cli-proxy-api.exe" "Green"
    }
    catch {
        Write-ColorOutput "[ERROR] Failed to download CLIProxyAPI: $_" "Red"
        Write-ColorOutput "   Please download manually from:" "Yellow"
        Write-ColorOutput "   https://github.com/router-for-me/CLIProxyAPI/releases" "Yellow"
        exit 1
    }
}

function Add-ToPath {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    
    if ($currentPath -like "*$BIN_DIR*") {
        Write-ColorOutput "[OK] bin/ folder already in PATH" "Green"
        return $false
    }
    
    Write-ColorOutput "[>>] Adding bin/ folder to PATH..." "Cyan"
    
    $newPath = "$currentPath;$BIN_DIR"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    
    # Also update current session
    $env:Path = "$env:Path;$BIN_DIR"
    
    Write-ColorOutput "[OK] Added to PATH: $BIN_DIR" "Green"
    return $true
}

# ============================================================
# Main Installation
# ============================================================

Write-Banner

Write-ColorOutput "[>>] Checking prerequisites..." "Cyan"
Write-Host ""

# Check Node.js
if (Test-NodeInstalled) {
    $nodeVersion = node --version
    Write-ColorOutput "[OK] Node.js: $nodeVersion" "Green"
}
else {
    Write-ColorOutput "[X] Node.js: Not found" "Red"
    Write-ColorOutput "   Please install Node.js from https://nodejs.org/" "Yellow"
    Write-ColorOutput "   (LTS version recommended)" "Yellow"
    Write-Host ""
}

# Check Claude CLI
if (Test-ClaudeInstalled) {
    Write-ColorOutput "[OK] Claude CLI: Installed" "Green"
}
else {
    Write-ColorOutput "[!] Claude CLI: Not found" "Yellow"
    Write-ColorOutput "   Install with: npm install -g @anthropic-ai/claude-code" "Gray"
}

Write-Host ""

# Download CLIProxyAPI
if (-not $SkipDownload) {
    Download-CLIProxyAPI
}

# Add to PATH
$pathChanged = $false
if (-not $SkipPath) {
    $pathChanged = Add-ToPath
}

Write-Host ""
Write-ColorOutput "================================================================" "Green"
Write-ColorOutput "              [OK] Installation Complete!" "Green"
Write-ColorOutput "================================================================" "Green"
Write-Host ""

Write-ColorOutput "NEXT STEPS:" "Cyan"
Write-Host ""

if ($pathChanged) {
    Write-ColorOutput "1. Restart your terminal (required for PATH changes)" "White"
    Write-Host ""
}

Write-ColorOutput "2. Authenticate with Google AI:" "White"
Write-ColorOutput "   Run: .\bin\cli-proxy-api.exe" "Gray"
Write-ColorOutput "   Follow the browser prompts to login" "Gray"
Write-Host ""

Write-ColorOutput "3. Start using Claude:" "White"
Write-ColorOutput "   claude                    # Interactive mode" "Gray"
Write-ColorOutput '   claude "your question"    # Quick question' "Gray"
Write-Host ""

Write-ColorOutput "USEFUL COMMANDS:" "Yellow"
Write-ColorOutput "   .\bin\proxy-status.ps1   # Check proxy status" "Gray"
Write-ColorOutput "   .\bin\start-proxy.ps1    # Start proxy manually" "Gray"
Write-ColorOutput "   .\bin\stop-proxy.ps1     # Stop proxy" "Gray"
Write-Host ""

Write-ColorOutput "DOCUMENTATION: README.md, WINDOWS-SETUP.md" "Magenta"
Write-Host ""
