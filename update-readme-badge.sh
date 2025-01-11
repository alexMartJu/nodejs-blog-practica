#!/usr/bin/env bash
set -e # Activa el modo de "error inmediato", lo que significa que si un comando falla, el script se detendrá.

OUTCOME=$1 # Asigna el primer argumento recibido al script al valor de OUTCOME (success o failure).
README_FILE="README.md" # Define la ruta al archivo README.md, donde se agregará el badge.

# Rutas de los badges
BADGE_FAILURE="https://img.shields.io/badge/test-failure-red" # Define la URL para el badge de "fallo".
BADGE_SUCCESS="https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg" # Define la URL para el badge de "éxito".

# Texto que indica dónde añadiremos el badge
SEARCH_TEXT="RESULTADOS DE LOS ÚLTIMOS TESTS" # Define el texto que buscará en el README.md para colocar el badge después.

# Dependiendo del OUTCOME, elegimos un badge
if [ "$OUTCOME" = "success" ]; then # Si el OUTCOME es "success", usa el badge de éxito.
    BADGE="$BADGE_SUCCESS" # Asigna la URL del badge de éxito a la variable BADGE.
else
    BADGE="$BADGE_FAILURE" # Si el OUTCOME no es "success" (es "failure"), asigna el badge de fallo.
fi

# Añade la línea del badge al final del README, después de la línea de SEARCH_TEXT
# Verifica si ya existe la sección "RESULTAT DELS ÚLTIMS TESTS"
if grep -q "$SEARCH_TEXT" "$README_FILE"; then # Si el texto ya existe en el README, se añade el badge después de él.
    sed -i "/$SEARCH_TEXT/a ![Cypress test badge]($BADGE)" "$README_FILE" # Inserta el badge debajo de la línea con SEARCH_TEXT.
else
    # Si no existe el texto, lo añadimos al final
    echo "" >> "$README_FILE" # Agrega una línea vacía al final del archivo README.md.
    echo "$SEARCH_TEXT" >> "$README_FILE" # Añade el texto de búsqueda al final del README.md.
    echo "![Cypress test badge]($BADGE)" >> "$README_FILE" # Inserta el badge justo después.
fi

echo "README.md modificado con el badge ($OUTCOME): $BADGE" # Imprime un mensaje confirmando que el README ha sido modificado con el badge.
