git rm -r --cached .
#!/bin/bash

# Update package list and install necessary tools if not present
echo "Updating package list and installing curl and git..."
sudo apt-get update
sudo apt-get install -y curl git

# Clone Flutter SDK
echo "Cloning Flutter SDK..."
git clone https://github.com/flutter/flutter.git $HOME/flutter

# Add Flutter to PATH
echo "Adding Flutter to PATH..."
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:`flutter pub bin cache`" # Ensure Dart tools are also in PATH

# Run flutter doctor to check for dependencies
echo "Running flutter doctor to check for Flutter environment issues..."
flutter doctor

flutter pub get

echo "Flutter environment setup complete."
echo "You may need to restart your terminal or source this script to apply changes: source environment.sh"

