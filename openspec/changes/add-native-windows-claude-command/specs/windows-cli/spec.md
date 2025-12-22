# Windows CLI Capability

## ADDED Requirements

### Requirement: Native Windows Claude Command
The system SHALL provide a `claude` command that works natively in Windows Terminal (PowerShell and CMD) without requiring WSL or manual proxy configuration.

#### Scenario: Basic Claude invocation from PowerShell
- **GIVEN** the user has installed DEGENI on Windows
- **WHEN** user types `claude` in PowerShell
- **THEN** Claude Code CLI starts with Antigravity proxy configured
- **AND** the default model is `gemini-claude-sonnet-4-5-thinking`

#### Scenario: Basic Claude invocation from CMD
- **GIVEN** the user has installed DEGENI on Windows
- **WHEN** user types `claude` in Command Prompt
- **THEN** Claude Code CLI starts with Antigravity proxy configured

#### Scenario: Quick question mode
- **GIVEN** the user has installed DEGENI on Windows
- **WHEN** user types `claude "explain docker in one sentence"`
- **THEN** Claude Code processes the question and returns the answer
- **AND** exits after responding

---

### Requirement: Automatic Proxy Connection
The system SHALL automatically configure environment variables to connect Claude Code CLI to the CLIProxyAPI running on localhost:8317.

#### Scenario: Environment variables set correctly
- **WHEN** `claude` command is executed
- **THEN** `ANTHROPIC_BASE_URL` is set to `http://localhost:8317`
- **AND** `ANTHROPIC_MODEL` is set to the configured default model

#### Scenario: Model override via argument
- **WHEN** user runs `claude --model gemini-claude-opus-4-5-thinking`
- **THEN** the specified model is used instead of the default

---

### Requirement: Native Windows Proxy
The system SHALL use the native Windows binary of CLIProxyAPI (`cli-proxy-api.exe`) instead of requiring WSL.

#### Scenario: Proxy runs as native Windows process
- **GIVEN** CLIProxyAPI is installed in bin/ folder
- **WHEN** proxy is started
- **THEN** it runs as a native Windows background process
- **AND** listens on localhost:8317
- **AND** does NOT require WSL

#### Scenario: Proxy authentication
- **GIVEN** proxy is running for the first time
- **WHEN** user needs to authenticate
- **THEN** browser opens for OAuth with Google AI
- **AND** credentials are stored in `~/.cli-proxy-api/`

---

### Requirement: Proxy Auto-Start
The system SHALL automatically start the CLIProxyAPI if it is not already running when the user invokes the `claude` command.

#### Scenario: Proxy not running
- **GIVEN** CLIProxyAPI is not running
- **WHEN** user types `claude`
- **THEN** the system starts `cli-proxy-api.exe` as a background process
- **AND** waits for proxy to become healthy (max 10 seconds)
- **AND** then launches Claude Code CLI

#### Scenario: Proxy already running
- **GIVEN** CLIProxyAPI is already running on port 8317
- **WHEN** user types `claude`
- **THEN** Claude Code CLI starts immediately without restart

#### Scenario: Proxy fails to start
- **GIVEN** CLIProxyAPI cannot be started
- **WHEN** user types `claude`
- **THEN** the system displays a clear error message
- **AND** provides troubleshooting suggestions

---

### Requirement: Windows PATH Integration
The system SHALL provide an installation mechanism to add the `claude` command to the Windows PATH so it can be invoked from any directory.

#### Scenario: Fresh installation
- **GIVEN** user runs `install-windows.ps1`
- **WHEN** installation completes
- **THEN** `claude` command is available in new terminal windows
- **AND** `cli-proxy-api.exe` is downloaded to bin/ folder
- **AND** user is notified to restart terminal for PATH changes

#### Scenario: Uninstallation
- **GIVEN** user wants to remove DEGENI from PATH
- **WHEN** user runs uninstall script
- **THEN** `claude` command is removed from PATH
- **AND** existing files are preserved

---

### Requirement: Model Selection
The system SHALL support selecting different AI models via command-line argument or environment variable.

#### Scenario: Use Opus model
- **WHEN** user runs `claude --model gemini-claude-opus-4-5-thinking`
- **THEN** Claude Code uses Opus 4.5 model for the session

#### Scenario: Default model configuration
- **GIVEN** user has set `DEGENI_DEFAULT_MODEL` environment variable
- **WHEN** user runs `claude` without model argument
- **THEN** the configured default model is used

---

### Requirement: Zero WSL Dependency
The system SHALL work without requiring Windows Subsystem for Linux (WSL) for basic Claude Code usage.

#### Scenario: Fresh Windows without WSL
- **GIVEN** a Windows machine without WSL installed
- **WHEN** user installs DEGENI using install-windows.ps1
- **AND** authenticates with Google AI
- **WHEN** user types `claude`
- **THEN** Claude Code works correctly
- **AND** no WSL-related errors occur
