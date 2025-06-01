#!/bin/bash

# Script to Build the Futuristic IDE (Neutralinojs) for Linux and macOS
#
# This script automates the following steps:
# 1. Checks for Node.js and npm.
# 2. Checks for the Neutralinojs CLI (neu).
# 3. Builds the Neutralinojs application.
#
# Usage:
# 1. Open your terminal.
# 2. Navigate to the 'futuristic-ide' folder.
# 3. Make the script executable: chmod +x build-futuristic-ide.sh
# 4. Run the script: ./build-futuristic-ide.sh

echo "Checking for Node.js..."
if ! command -v node &> /dev/null
then
    echo "Error: Node.js is not found. Please install Node.js (which includes npm) from https://nodejs.org/ and ensure it's in your PATH."
    exit 1
fi
echo "Node.js version: $(node -v)"

echo "Checking for npm..."
if ! command -v npm &> /dev/null
then
    echo "Error: npm is not found. This usually comes with Node.js. Please ensure Node.js is installed correctly and npm is available in your PATH."
    exit 1
fi
echo "npm version: $(npm -v)"

echo "Checking for Neutralinojs CLI (neu)..."
if ! command -v neu &> /dev/null
then
    echo "Error: Neutralinojs CLI (neu) is not found. Please install it globally by running: npm install -g @neutralinojs/neu"
    exit 1
fi
echo "Neutralinojs CLI found. Version: $(neu version)" # Assuming 'neu version' prints version and exits cleanly if found

echo "Starting Neutralinojs application build..."
# Navigate to the script's directory to ensure 'neu build' runs in the correct context
cd "$(dirname "$0")" || exit

if neu build --release; then
    echo "Neutralinojs application built successfully."
    echo "You can find the built application in the 'dist/futuristic-ide' directory."
else
    echo "Error: Neutralinojs application build failed. Check the output above for more details."
    exit 1
fi
