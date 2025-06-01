# Futuristic IDE

This is a development IDE built with Neutralinojs, designed to help you create Neutralinojs applications.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js and npm**: Required for Neutralinojs development. You can download them from [https://nodejs.org/](https://nodejs.org/).
- **Neutralinojs CLI (`neu`)**: The command-line tool for Neutralinojs. Install it globally using npm:
  ```bash
  npm install -g @neutralinojs/neu
  ```

## Development: Live Preview

To run the Futuristic IDE in development mode with live preview (auto-reloading on file changes):

1.  Navigate to the `futuristic-ide` directory:
    ```bash
    cd path/to/futuristic-ide
    ```
2.  Run the `neu run` command:
    ```bash
    neu run
    ```
    This will launch the IDE, and any changes you make to the web application files in the `www` directory will trigger an automatic reload.

## Building the Standalone Application

To package the Futuristic IDE as a standalone application for your operating system:

1.  Ensure you are in the `futuristic-ide` directory.
2.  **For Windows:**
    - Open PowerShell.
    - Run the build script:
      ```powershell
      .uild-futuristic-ide.ps1
      ```
3.  **For Linux and macOS:**
    - Open your terminal.
    - Make the build script executable (if you haven't already):
      ```bash
      chmod +x build-futuristic-ide.sh
      ```
    - Run the build script:
      ```bash
      ./build-futuristic-ide.sh
      ```

After a successful build, you will find the packaged application in the `dist/futuristic-ide` directory.

## Using the Futuristic IDE

Once built and launched, the Futuristic IDE can be used to:
- Create new Neutralinojs projects.
- Manage existing Neutralinojs projects.
- Develop and test Neutralinojs applications with an integrated live preview. (Note: This refers to the IDE's capability to help you develop *other* Neutralinojs apps, potentially by integrating `neu run` for those projects).
