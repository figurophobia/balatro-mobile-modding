#!/bin/bash

# ===============================
#  Script Bash para gestionar la transferencia de partidas de Balatro localmente
#  1. Copia y ejecuta FolderSetup.sh en el directorio de Balatro en tu equipo.
#  2. Ejecuta SaveTransfer.sh localmente.
#  3. Copia y ejecuta FolderClean.sh en el directorio de Balatro.
#  4. Elimina los archivos copiados del directorio.
# ===============================

# === Configuración ===
# Archivos locales (en el mismo directorio que este script)
FOLDER_SETUP_SCRIPT="FolderSetup.sh"
PUSH_SAVE_SCRIPT="PushSave.sh"
FOLDER_CLEAN_SCRIPT="FolderClean.sh"


chmod +x "$FOLDER_SETUP_SCRIPT" 
"./$FOLDER_SETUP_SCRIPT"
chmod +x "$PUSH_SAVE_SCRIPT"
"./$PUSH_SAVE_SCRIPT"


chmod +x "$FOLDER_CLEAN_SCRIPT"
"./$FOLDER_CLEAN_SCRIPT"

# === Final ===
echo "Completed."
