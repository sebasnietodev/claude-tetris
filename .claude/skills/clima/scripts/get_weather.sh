#!/usr/bin/env bash
# Consulta el clima actual (por defecto en Cartago, Valle del Cauca, Colombia) usando wttr.in.
# Uso:
#   get_weather.sh                 -> clima actual en Cartago, Valle del Cauca, Colombia
#   get_weather.sh "Bogota"        -> clima actual en Bogotá
#   get_weather.sh "Bogota" full   -> reporte completo de 3 días
set -euo pipefail

DEFAULT_LOCATION="Cartago,Valle del Cauca,Colombia"
LOCATION="${1:-$DEFAULT_LOCATION}"
MODE="${2:-short}"

# wttr.in no acepta espacios sin codificar en la ruta; se reemplazan por "+".
LOCATION_ENCODED="${LOCATION// /+}"

# Formato "short": una línea con ubicación, condición y temperatura.
# Formato "full": el reporte estándar de wttr.in con ASCII art.
if [ "$MODE" = "full" ]; then
  URL="wttr.in/${LOCATION_ENCODED}"
else
  URL="wttr.in/${LOCATION_ENCODED}?format=%l:+%C+%t+(sensación+%f),+humedad+%h,+viento+%w"
fi

curl -s --max-time 10 "$URL"
echo
