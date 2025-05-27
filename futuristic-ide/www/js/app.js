// Main application logic for Futuristic IDE

function initApp() {
    // Get DOM element references
    const filenameInput = document.getElementById('filenameInput');
    const viewFileButton = document.getElementById('viewFileButton');
    const fileContentOutput = document.getElementById('fileContentOutput');
    const errorMessage = document.getElementById('errorMessage');

    // Event listener for the "View File" button
    viewFileButton.addEventListener('click', async () => {
        // Clear previous output
        fileContentOutput.textContent = '';
        errorMessage.textContent = '';

        const filename = filenameInput.value.trim();

        if (!filename) {
            errorMessage.textContent = 'Please enter a filename.';
            return;
        }

        try {
            // Construct the path relative to the www directory
            // Neutralino's resourcesPath is effectively the root for readFile here.
            // Since CLI's resourcesPath is /www/ and documentRoot is /www/,
            // and we are in www/js/app.js, accessing files in www/ needs to be relative
            // to the resourcesPath. So, './filename' or 'filename' should refer to 'www/filename'.
            // For clarity, let's assume files are directly under www.
            // If neutralino.js is at /www/neutralino.js and app.js is at /www/js/app.js,
            // and index.html is at /www/index.html,
            // Neutralino.filesystem.readFile({ fileName: 'index.html' }) might work if CWD for neu run is the project root.
            // Or, Neutralino.filesystem.readFile({ fileName: './index.html' })
            // Let's try with a simple filename, assuming it's relative to resourcesPath.
            const data = await Neutralino.filesystem.readFile({ fileName: filename });
            fileContentOutput.textContent = data.content; // readFile returns { content: '...' }
        } catch (err) {
            console.error('Error reading file:', err);
            errorMessage.textContent = `Error reading file '${filename}': ${err.message || 'File not found or permission issue.'}`;
        }
    });
}

// Initialize Neutralino and then the app
Neutralino.init();
Neutralino.events.on('ready', initApp);
