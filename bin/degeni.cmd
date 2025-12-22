@echo off
REM ============================================================
REM DEGENI Manager - CMD Wrapper
REM ============================================================

setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PowerShell not found. Please install PowerShell.
    exit /b 1
)

powershell -ExecutionPolicy Bypass -NoProfile -File "%SCRIPT_DIR%degeni.ps1" %*
