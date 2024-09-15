#!/bin/bash

DOWNLOAD_DIR="$HOME/Downloads"
FOLDERS=("1. Bilder" "2. Vektor" "3. Videos" "4. Musik" "5. PDF" "6. Texte" "7. Excel" "8. Zip" "9. Sonstige" "10. Ordner" "11. Fonts")

# Ordner erstellen, falls sie nicht vorhanden sind
for folder in "${FOLDERS[@]}"; do
    if [ ! -d "$DOWNLOAD_DIR/$folder" ]; then
        mkdir "$DOWNLOAD_DIR/$folder"
    fi
done

files_moved_count=0
folders_moved_count=0

# Dateien im Download-Ordner prüfen und in die entsprechenden Ordner verschieben
for file in "$DOWNLOAD_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        extension="${filename##*.}"
        case "$extension" in
            jpg|jpeg|png|gif|bmp|tiff|heic)
                mv "$file" "$DOWNLOAD_DIR/1. Bilder/$filename"
                ((files_moved_count++))
                ;;
            ai|eps|svg|cdr)
                mv "$file" "$DOWNLOAD_DIR/2. Vektor/$filename"
                ((files_moved_count++))
                ;;
            mp4|mov|avi|mkv|flv|webm)
                mv "$file" "$DOWNLOAD_DIR/3. Videos/$filename"
                ((files_moved_count++))
                ;;
            mp3|wav|flac|ogg|m4a)
                mv "$file" "$DOWNLOAD_DIR/4. Musik/$filename"
                ((files_moved_count++))
                ;;
            pdf)
                mv "$file" "$DOWNLOAD_DIR/5. PDF/$filename"
                ((files_moved_count++))
                ;;
            txt|doc|docx|rtf|odt)
                mv "$file" "$DOWNLOAD_DIR/6. Texte/$filename"
                ((files_moved_count++))
                ;;
            xls|xlsx|csv|ods)
                mv "$file" "$DOWNLOAD_DIR/7. Excel/$filename"
                ((files_moved_count++))
                ;;
            zip|rar|7z|tar|gz|bz2)
                mv "$file" "$DOWNLOAD_DIR/8. Zip/$filename"
                ((files_moved_count++))
                ;;
            ttf|otf|woff|woff2|eot)
                mv "$file" "$DOWNLOAD_DIR/11. Fonts/$filename"
                ((files_moved_count++))
                ;;
            *)
                mv "$file" "$DOWNLOAD_DIR/9. Sonstige/$filename"
                ((files_moved_count++))
                ;;
        esac
    fi
done

# Dateien in den Unterordnern basierend auf ihrem Dateityp in weitere Unterordner verschieben
for folder in "${FOLDERS[@]}"; do
    if [ "$folder" != "9. Sonstige" ]; then
        for file in "$DOWNLOAD_DIR/$folder"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                extension="${filename##*.}"
                subdir="$DOWNLOAD_DIR/$folder/$extension"
                if [ ! -d "$subdir" ]; then
                    mkdir "$subdir"
                fi
                mv "$file" "$subdir/$filename"
            fi
        done
    fi
done

# Zusätzliche Ordner im Download-Ordner prüfen und in den Ordner "10. Ordner" verschieben
for file in "$DOWNLOAD_DIR"/*; do
    if [ -d "$file" ]; then
        is_main_folder=0
        for main_folder in "${FOLDERS[@]}"; do
            if [ "$file" == "$DOWNLOAD_DIR/$main_folder" ]; then
                is_main_folder=1
                break
            fi
        done
        if [ $is_main_folder -eq 0 ]; then
            filename=$(basename "$file")
            mv "$file" "$DOWNLOAD_DIR/10. Ordner/$filename"
            ((folders_moved_count++))
        fi
    fi
done

echo "----------------------------------------"
echo "Verschobene Dateien: $files_moved_count"
echo "Verschobene Ordner: $folders_moved_count"
echo "----------------------------------------
"
echo "DE: Ihr findet meine Mac-Scripts hilfreich? Wenn ihr möchtet, könnt ihr mich mit einem virtuellen Kaffee unterstützen: paypal.me/krisch. Ich würde mich sehr darüber freuen! Vielen Dank! - Support: info@nickdesignz.de

"
echo "----------------------------------------"
