# Tasks: Add Native Windows Claude Command

## 1. Download & Setup CLIProxyAPI
- [x] 1.1 Download `cli-proxy-api.exe` from [GitHub releases](https://github.com/router-for-me/CLIProxyAPI/releases) (v6.6.39 or later)
- [x] 1.2 Place executable in `bin/cli-proxy-api.exe`
- [x] 1.3 Test that proxy starts correctly on Windows
- [x] 1.4 Document authentication flow (OAuth with Google AI)

## 2. Create PowerShell Launcher
- [x] 2.1 Create `bin/claude.ps1` with environment configuration
- [x] 2.2 Set `ANTHROPIC_BASE_URL=http://localhost:8317`
- [x] 2.3 Set default model `gemini-claude-sonnet-4-5-thinking`
- [x] 2.4 Add proxy health check (ping localhost:8317)
- [x] 2.5 Add auto-start proxy if not running (start cli-proxy-api.exe in background)
- [x] 2.6 Forward all arguments to `claude` command

## 3. Create CMD Wrapper
- [x] 3.1 Create `bin/claude.cmd` that calls `claude.ps1`
- [x] 3.2 Handle argument passthrough (e.g., `claude "question"`)

## 4. Create Proxy Management Scripts
- [x] 4.1 Create `bin/start-proxy.ps1` to start proxy in background
- [x] 4.2 Create `bin/stop-proxy.ps1` to stop proxy
- [x] 4.3 Create `bin/proxy-status.ps1` to check proxy status

## 5. Windows PATH Integration
- [x] 5.1 Create `install-windows.ps1` installation script
- [x] 5.2 Download latest cli-proxy-api.exe automatically
- [x] 5.3 Add `bin/` folder to user PATH
- [x] 5.4 Create uninstall script to remove from PATH

## 6. Documentation
- [x] 6.1 Update `README.md` with Windows-native usage
- [x] 6.2 Update `START-HERE.md` with new quick start for Windows
- [x] 6.3 Create `WINDOWS-SETUP.md` with detailed Windows instructions
- [x] 6.4 Add troubleshooting section for Windows-specific issues

## 7. Testing
- [x] 7.1 Test `claude` command from PowerShell
- [x] 7.2 Test `claude` command from CMD
- [x] 7.3 Test `claude "question"` quick mode
- [x] 7.4 Test proxy auto-start when not running
- [x] 7.5 Test with different models (Sonnet, Opus, Flash)
- [x] 7.6 Test on fresh Windows installation

## 8. Migration Path
- [x] 8.1 Document how to migrate credentials from WSL to Windows
- [x] 8.2 Or: Configure shared credential path accessible from both
