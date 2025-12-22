@echo off
REM ============================================================
REM DEGENI Claude Launcher - CMD Wrapper
REM ============================================================
REM This is a simple wrapper that calls the PowerShell script.
REM For best experience, use PowerShell directly.
REM ============================================================

setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"

REM Check if PowerShell is available
where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PowerShell not found. Please install PowerShell.
    exit /b 1
)

REM Run the PowerShell script with all arguments
powershell -ExecutionPolicy Bypass -NoProfile -File "%SCRIPT_DIR%claude.ps1" %*
