#!/bin/bash
# Conversion pour le Web
# reduction de la taille
# reduction de la qualite
# on enleve les metadonnées inutiles dans la photo
# Pour une photo:
# convert maphoto.jpg -resize 1024x768 -strip -quality 50 -interlace line maphotoWeb.jpg

# on cree un sous-dossier web
if [ ! -d web ]
	then 
	mkdir web
	echo "Dossier web créé"
fi

# on renomme les .JPG en .jpg dans web
# et on remplace les blancs par des _

FICMAJ="*.JPG"
for fic in $FICMAJ; do
    #mv "$file" "`basename $file .JPG`.jpg"
    newName=$(echo "$fic" | tr '[:blank:]' [_])
    echo $fic "=>" web/$newName 
    cp "$fic" web/$newName
    mv "web/$newName" "web/${newName%.JPG}.jpg"
done

# Renommage pour enlever les espaces dans les noms 
# de fichiers .jpg et .png et copie des fichiers d'origine 
# dans le dossier web sous leur nouveau nom

FILES="*.jpg *.png"
for fic in $FILES
	do
		newName=$(echo "$fic" | tr '[:blank:]' [_])
		echo $fic "=>" web/$newName
		cp "$fic" web/$newName
	done


#Redimensionnement de tous les fichiers 
# situes dans le dossier Web
mogrify  -resize 910x700 -strip -quality 60 -interlace line web/$FILES

# est-ce qu'il existe des fichiers un peu grands
# encore ?
cd web
for fic in $FILES
	do
		if [ $(identify -format "%b" $fic | cut -d'B' -f1) -gt 1000000 ] 
			then
				echo $fic
		fi
	done


