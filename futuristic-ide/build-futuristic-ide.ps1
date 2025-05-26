# PowerShell Script to Build and Launch the Futuristic IDE (Neutralinojs)
#
# This script automates the following steps:
# 1. Checks for Node.js and npm.
# 2. Checks for the Neutralinojs CLI (neu).
# 3. Builds the Neutralinojs application.
# 4. Launches the built application.
#
# Usage:
# 1. Open PowerShell.
# 2. Navigate to the directory containing this script (the 'futuristic-ide' folder).
# 3. Run the script: .\build-futuristic-ide.ps1
#
# Note: If you encounter an execution policy error, you might need to run:
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# And then re-run the script.
#

Set-StrictMode -Version Latest
Push-Location $PSScriptRoot

# Check for Node.js
Write-Host "Checking for Node.js..."
try {
    $nodeVersion = node -v
    if ($LASTEXITCODE -ne 0) {
        throw "Node.js execution failed."
    }
    Write-Host "Node.js version: $nodeVersion"
}
catch {
    Write-Error "Node.js is not found. Please install Node.js (which includes npm) from https://nodejs.org/ and ensure it's added to your PATH."
    exit 1
}

# Check for npm
Write-Host "Checking for npm..."
try {
    $npmVersion = npm -v
    if ($LASTEXITCODE -ne 0) {
        throw "npm execution failed."
    }
    Write-Host "npm version: $npmVersion"
}
catch {
    Write-Error "npm is not found. This usually comes with Node.js. Please ensure Node.js is installed correctly and npm is available in your PATH."
    exit 1
}

# Check for Neutralinojs CLI (neu)
Write-Host "Checking for Neutralinojs CLI (neu)..."
try {
    neu version | Out-Null # neu version outputs to stdout, and also to stderr on older versions
    if ($LASTEXITCODE -ne 0) {
        # This handles cases where `neu version` itself indicates an error via exit code
        throw "Neutralinojs CLI 'neu version' command failed."
    }
    # If 'neu version' ran but isn't a recognized command, Get-Command would have thrown.
    # If it ran and exited with 0, it's considered found.
    Write-Host "Neutralinojs CLI found."
}
catch {
    # This catches errors from Get-Command (neu not found) or the explicit throw above.
    Write-Host "Error details: $($_.Exception.Message)" # Optional: for more detailed error logging
    Write-Error "Neutralinojs CLI (neu) is not found. Please install it globally by running: npm install -g @neutralinojs/neu"
    exit 1
}

# Build the Neutralinojs application
Write-Host "Starting Neutralinojs application build..."
try {
    neu build --release
    if ($LASTEXITCODE -ne 0) {
        throw "Neutralinojs application build command exited with an error."
    }
    Write-Host "Neutralinojs application built successfully."

    # Define Executable Path
    $executablePath = ".\dist\futuristic-ide\futuristic-ide-win_x64.exe" # Relative to PSScriptRoot (futuristic-ide)

    # Check if Executable Exists
    Write-Host "Checking for application executable at $executablePath..."
    if (-not (Test-Path $executablePath)) {
        Write-Error "Error: Built application executable not found at $executablePath. Cannot launch."
        exit 1
    }

    # Launch Application
    Write-Host "Launching Futuristic IDE..."
    try {
        Start-Process $executablePath
        Write-Host "Futuristic IDE launched successfully."
    }
    catch {
        Write-Error "Error: Failed to launch the Futuristic IDE from $executablePath. Details: $($_.Exception.Message)"
        exit 1
    }
}
catch {
    Write-Error "Error: Neutralinojs application build failed. Check the output above for more details."
    exit 1
}

Pop-Location
