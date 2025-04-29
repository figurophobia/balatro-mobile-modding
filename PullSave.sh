#!/bin/bash

# Ruta temporal en el dispositivo
REMOTE_BASE="/data/local/tmp/balatro"
REMOTE_FILES="$REMOTE_BASE/files"
PACKAGE="com.unofficial.balatro"
LOCAL_SAVE_DIR="/home/davidavirn/snap/steam/common/.local/share/Steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/"  # Cambia esto por tu ruta deseada

# Limpieza previa
adb shell "rm -r $REMOTE_BASE"
adb shell "mkdir -p $REMOTE_FILES/1 $REMOTE_FILES/2 $REMOTE_FILES/3"

# Lista de archivos y rutas relativas
declare -A files=(
  ["$REMOTE_FILES/settings.jkr"]="files/save/game/settings.jkr"
  ["$REMOTE_FILES/1/profile.jkr"]="files/save/game/1/profile.jkr"
  ["$REMOTE_FILES/1/meta.jkr"]="files/save/game/1/meta.jkr"
  ["$REMOTE_FILES/1/save.jkr"]="files/save/game/1/save.jkr"
  ["$REMOTE_FILES/2/profile.jkr"]="files/save/game/2/profile.jkr"
  ["$REMOTE_FILES/2/meta.jkr"]="files/save/game/2/meta.jkr"
  ["$REMOTE_FILES/2/save.jkr"]="files/save/game/2/save.jkr"
  ["$REMOTE_FILES/3/profile.jkr"]="files/save/game/3/profile.jkr"
  ["$REMOTE_FILES/3/meta.jkr"]="files/save/game/3/meta.jkr"
  ["$REMOTE_FILES/3/save.jkr"]="files/save/game/3/save.jkr"
)

# Copiar cada archivo con run-as
for dest in "${!files[@]}"; do
  src="${files[$dest]}"
  adb shell "touch $dest"
  adb shell "run-as $PACKAGE cat $src > $dest" 2>/dev/null
done

# Eliminar archivos vacíos
adb shell "find $REMOTE_FILES -maxdepth 2 -size 0c -exec rm '{}' \;"

# Extraer al PC
adb pull "$REMOTE_FILES/." "$LOCAL_SAVE_DIR"

# Cerrar servidor ADB
adb kill-server

echo "Backup completado en: $LOCAL_SAVE_DIR"
