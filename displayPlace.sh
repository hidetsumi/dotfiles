# Encontrar el comando displayplacer
displayPlacerPATH=$(which displayplacer)

# Obtener la configuración actual de la pantalla
currentConfDisplay=$($displayPlacerPATH list | tail -n 1)

# Usar IFS para dividir la configuración en función de las comillas dobles
IFS='"' read -r _ macbookConf _ displayConfig2 _ <<<"$currentConfDisplay"

# Extraer la resolución de la MacBook
macbookResolutionX=$(echo "$macbookConf" | grep -o 'res:[0-9]*' | cut -d':' -f2)
macbookResolutionY=$(echo "$macbookConf" | grep -o 'x[0-9]*' | cut -d'x' -f2)

# Extraer valores de la pantalla secundaria desde displayConfig2
secondaryScreenId=$(echo "$displayConfig2" | grep -o 'id:[^ ]*' | cut -d':' -f2)
secondaryResolution=$(echo "$displayConfig2" | grep -o 'res:[^ ]*' | cut -d':' -f2)
secondaryResolutionX=$(echo "$secondaryResolution" | cut -d'x' -f1)
secondaryResolutionY=$(echo "$secondaryResolution" | cut -d'x' -f2)
secondaryHz=$(echo "$displayConfig2" | grep -o 'hz:[^ ]*' | cut -d':' -f2)
secondaryColorDepth=$(echo "$displayConfig2" | grep -o 'color_depth:[^ ]*' | cut -d':' -f2)
secondaryScaling=$(echo "$displayConfig2" | grep -o 'scaling:[^ ]*' | cut -d':' -f2)

# Calcular posición centrada arriba de la MacBook
verticalOriginX=$(( (macbookResolutionX - secondaryResolutionX) / 2 ))
verticalOriginY=$(( -secondaryResolutionY ))

# Calcular posición a la derecha de la MacBook
horizontalOriginX=$(( macbookResolutionX ))
horizontalOriginY=0

# Definir la configuración dinámica según la posición actual
if [[ "$displayConfig2" == *"origin:($verticalOriginX,$verticalOriginY)"* ]]; then
  # Cambiar a la posición derecha
  newOrigin="origin:($horizontalOriginX,$horizontalOriginY)"
  echo "Cambiando a posición derecha de la MacBook"
else
  # Cambiar a la posición centrada arriba
  newOrigin="origin:($verticalOriginX,$verticalOriginY)"
  echo "Cambiando a posición centrada arriba de la MacBook"
fi

# Ejecutar displayplacer con la nueva configuración
$displayPlacerPATH "$macbookConf" "id:$secondaryScreenId res:$secondaryResolution hz:$secondaryHz color_depth:$secondaryColorDepth enabled:true scaling:$secondaryScaling $newOrigin degree:0"

