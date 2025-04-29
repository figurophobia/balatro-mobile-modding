#!/bin/bash

# ===============================
#  Script Bash para transferir la partida guardada de Balatro
#  Permite especificar la ruta de la save y pasarla al dispositivo Android
# ===============================

# === Configuración ===
# Ruta local de la partida guardada en la PC
SAVE_PATH_PC="/home/davidavirn/snap/steam/common/.local/share/Steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/"

# Nombre del paquete de la aplicación Balatro
PACKAGE_NAME="com.unofficial.balatro"

# === Verificar conexión ADB ===
echo "🔎 Verificando dispositivos conectados..."
adb devices | grep -w "device" > /dev/null
if [ $? -ne 0 ]; then
    echo "❌ No se detectó ningún dispositivo. Conecta tu teléfono y activa la depuración USB."
    exit 1
fi

# === Crear directorios temporales en el dispositivo ===
echo "📁 Creando directorios temporales en el dispositivo..."
adb shell mkdir -p /data/local/tmp/balatro/files/save/game

# === Subir la partida guardada al directorio temporal ===
echo "⬆️ Subiendo partida guardada al dispositivo..."
adb push "$SAVE_PATH_PC/." /data/local/tmp/balatro/files/save/game

# === Forzar cierre de la app para evitar conflictos ===
echo "🚫 Cerrando la aplicación Balatro..."
adb shell am force-stop "$PACKAGE_NAME"

# === Copiar archivos al directorio interno de la app usando permisos de la app ===
echo "📂 Moviendo la partida guardada al directorio de la app..."
adb shell run-as "$PACKAGE_NAME" cp -r /data/local/tmp/balatro/files .

# === Limpiar archivos temporales ===
echo "🧹 Eliminando archivos temporales..."
adb shell rm -r /data/local/tmp/balatro

# === Reiniciar servidor ADB (opcional) ===
echo "🔄 Reiniciando servidor ADB..."
adb kill-server

# === Final ===
echo "✅ Partida guardada transferida exitosamente."
