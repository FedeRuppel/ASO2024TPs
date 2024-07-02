#!/bin/bash


API_KEY="e3e1bb3df1ce4baa9bd191629242206" 
CIUDAD="Berlin"        


URL="http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$CIUDAD"

curl -s "$URL" -o response.json

if [ $? -ne 0 ]; then
    echo "Error: No se pudo obtener el clima. Verifica tu conexión a internet o intenta más tarde."
    exit 1
fi

echo "Clima actual en $CIUDAD:"
echo "=============================="

jq -r '.current | "Temperatura: \(.temp_c)°C\nCondición: \(.condition.text)\nViento: \(.wind_kph) km/h\nHumedad: \(.humidity)%"' response.json
rm response.json
