#!/bin/bash
# A simple GIF recorder using byzanz. See README.md for more.

# Declaring and initializing duration variable as integer.
declare -i DURATION=0

# Defining colors for the stderr echoes.
WARNCOLOR="\e[33m\e[1m"
OKCOLOR="\e[32m\e[1m"
ERRCOLOR="\e[31m\e[1m"

# Defining default recording path.
RECPATH="recording.gif"

# Asking for the recording duration.
until [ $DURATION -gt 0 ]; do
	echo -n "¿Qué duración tendrá el GIF (en segundos)?: "
	read DURATION

	if [ $DURATION -lt 1 ]; then
		>&2 echo -e "${WARNCOLOR}>>> Duración no válida. Por favor, introduce una duración mayor a 0 segundos.\033[0m"
	fi
done
echo -e "${OKCOLOR}>>> La duración será de $DURATION segundos.\033[0m"

# Asking for recording coordinates.
read -p "A continuación se tomarán las coordenadas de grabación. Primero sitúa el cursor del ratón sobre la esquina superior izquierda del rectángulo donde se tomará la captura y cuando estés listo, pulsa <Intro>. "
sleep 1

# Take upper-left corner absolute coordinates.
eval $(xdotool getmouselocation --shell)
RX=$X
RY=$Y

read -p "Ahora sitúa el cursor sobre la esquina inferior derecha del marco de grabación. Pulsa <Intro> cuando estés listo. "
sleep 1

# Take lower-right corner absolute coordinates and evaluate if the frame is correctly defined.
# If so, calculate width and height of the rectangle.
eval $(xdotool getmouselocation --shell)

if [ $RX -gt $X ] || [ $RY -gt $Y ]; then
	>&2 echo -e "${ERRCOLOR}>>> ERROR: La geometría del marco especificado no es válido.\033[0m"
else
	RWIDTH=$(( $X - $RX+1 ))
	RHEIGHT=$(( $Y - $RY+1 ))

	# Starting to take the screencast.
	echo -ne "En 5 segundos se comenzará a grabar el GIF de ${RWIDTH}x${RHEIGHT} y se guardará en la ubicación actual.\033[0m"
	byzanz-record -c --delay=5 -x $RX -y $RY -w $RWIDTH -h $RHEIGHT -d $DURATION $RECPATH

	echo -e "\n${OKCOLOR}>>> Grabación realizada con éxito. Guardado en: $RECPATH\033[0m\n"
fi
