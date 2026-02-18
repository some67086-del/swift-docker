#!/bin/bash

# install-swiftly.sh - Script for installing Swiftly

# Set up environment variables
SWIFTLY_VERSION="latest"
SWIFTLY_INSTALL_DIR="/usr/local/bin"

# Function to verify checksum
verify_checksum() {
    local file_path=$1
    local expected_checksum=$2
    local calculated_checksum=$(sha256sum "$file_path" | awk '{ print $1 }')
    if [[ "$calculated_checksum" != "$expected_checksum" ]]; then
        echo "Error: Checksum verification failed for $file_path"
        exit 1
    fi
}

# Download and install Swiftly
install_swiftly() {
    echo "Downloading Swiftly..."
    curl -L "https://github.com/swiftly-cli/swiftly/releases/download/v$SWIFTLY_VERSION/swiftly-linux-amd64" -o "$SWIFTLY_INSTALL_DIR/swiftly"

    # Check for curl success
    if [[ $? -ne 0 ]]; then
        echo "Error: Download failed"
        exit 1
    fi

    # Ensure the downloaded file is executable
    chmod +x "$SWIFTLY_INSTALL_DIR/swiftly"

    # Calculate and verify checksum (assuming the expected checksum is known)
    expected_checksum="<EXPECTED_CHECKSUM_HERE>"
    verify_checksum "$SWIFTLY_INSTALL_DIR/swiftly" "$expected_checksum"

    echo "Swiftly installed successfully!"
}

# Main script execution
install_swiftly
