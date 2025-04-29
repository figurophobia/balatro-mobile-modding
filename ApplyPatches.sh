#!/bin/bash
#Paths
BALATRO_DIR="/home/davidavirn/snap/steam/common/.local/share/Steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/"
MODS_DIR="$BALATRO_DIR/Mods"

# Check if the Mods directory exists
if [ ! -d "$MODS_DIR" ]; then
    echo "Error: Mods directory not found at $MODS_DIR"
    exit 1
fi
PATCHES_DIR="./Patches"

# Check if the specific patch directory exists in Patches
for PATCH_DIR in "$PATCHES_DIR"/*; do
    PATCH_NAME=$(basename "$PATCH_DIR")
    MOD_DIR="$MODS_DIR/$PATCH_NAME"

    if [ -d "$MOD_DIR" ]; then
        echo "Directory $PATCH_NAME exists in Mods. Replacing it with the one from Patches."
        cp -r "$PATCH_DIR" "$MODS_DIR/"
        echo "Replaced $PATCH_NAME in Mods."
    else
        echo "Directory $PATCH_NAME does not exist in Mods. Skipping."
    fi
done