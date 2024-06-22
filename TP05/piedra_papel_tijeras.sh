#!/bin/bash

function obtener_eleccion_computadora {
    opciones=("piedra" "papel" "tijeras")
    indice=$(( RANDOM % 3 ))
    echo "${opciones[$indice]}"
}

function determinar_ganador {
    usuario=$1
    computadora=$2

    if [ "$usuario" == "$computadora" ]; then
        resultado="Empate"
    elif [ "$usuario" == "piedra" ] && [ "$computadora" == "tijeras" ]; then
        resultado="¡Ganaste! Piedra rompe tijeras."
    elif [ "$usuario" == "papel" ] && [ "$computadora" == "piedra" ]; then
        resultado="¡Ganaste! Papel envuelve piedra."
    elif [ "$usuario" == "tijeras" ] && [ "$computadora" == "papel" ]; then
        resultado="¡Ganaste! Tijeras cortan papel."
    else
        resultado="¡Perdiste! La computadora eligió $computadora."
    fi

    echo "$resultado"
}

echo "Bienvenido al juego de piedra, papel o tijeras."
echo "Elige tu jugada: piedra, papel o tijeras."

read -p "Tu elección: " eleccion_usuario


case "$eleccion_usuario" in
    "piedra" | "papel" | "tijeras")
        eleccion_computadora=$(obtener_eleccion_computadora)
        echo "La computadora eligió: $eleccion_computadora"

        # Determinar el ganador
        resultado=$(determinar_ganador "$eleccion_usuario" "$eleccion_computadora")
        echo "$resultado"
        ;;
    *)
        echo "Elección inválida. Por favor elige piedra, papel o tijeras."
        ;;
esac
