#!/bin/bash

# Configuración
API_KEY="e3e1bb3df1ce4baa9bd191629242206"  # Reemplaza con tu API Key de weatherapi.com
CIUDAD="Berlin"         # Reemplaza con la ciudad que deseas consultar

# URL de la API
URL="http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$CIUDAD"

# Realizar la solicitud HTTP GET a la API y guardar la respuesta en un archivo temporal
curl -s "$URL" -o response.json

# Verificar si la solicitud fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: No se pudo obtener el clima. Verifica tu conexión a internet o intenta más tarde."
    exit 1
fi

# Parsear y mostrar la información del clima utilizando jq
echo "Clima actual en $CIUDAD:"
echo "=============================="

# Extraer información relevante utilizando jq
jq -r '.current | "Temperatura: \(.temp_c)°C\nCondición: \(.condition.text)\nViento: \(.wind_kph) km/h\nHumedad: \(.humidity)%"' response.json

# Eliminar el archivo temporal
rm response.json
