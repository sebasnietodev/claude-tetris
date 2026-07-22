---
name: clima
description: Consulta el clima actual de una ubicación usando wttr.in, sin necesidad de API key. Por defecto consulta Cartago, Valle del Cauca, Colombia. Úsala cuando el usuario pregunte por el clima, temperatura, lluvia o pronóstico. Trigger: /clima
---

# Clima local

Esta skill consulta el clima usando el servicio público `wttr.in` (no requiere API key ni configuración). Si no se indica una ciudad, consulta por defecto **Cartago, Valle del Cauca, Colombia**.

## Cómo usarla

Ejecuta el script `scripts/get_weather.sh`:

```bash
# Clima actual en Cartago, Valle del Cauca, Colombia (formato corto, una línea)
.claude/skills/clima/scripts/get_weather.sh

# Clima actual en otra ciudad
.claude/skills/clima/scripts/get_weather.sh "Bogota"

# Reporte completo (3 días, ASCII art) de una ciudad
.claude/skills/clima/scripts/get_weather.sh "Bogota" full
```

Después de ejecutar el script, resume el resultado para el usuario en una o dos frases (temperatura, condición, y si aplica lluvia/viento relevante). No hace falta mostrar el ASCII art del modo `full` salvo que el usuario lo pida explícitamente.

## Notas

- Requiere conexión a internet y `curl` disponible en el sistema (ya viene en macOS).
- Si `wttr.in` no responde (timeout de 10s) o da error, informa al usuario que el servicio no está disponible en este momento; no inventes datos de clima.
- Los nombres de ciudad con espacios deben pasarse entre comillas y pueden usar `+` en vez de espacio si prefieres (ej. `"Ciudad+de+Mexico"`).
