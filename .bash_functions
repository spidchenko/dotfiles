

# ffmpeg shortcut - compress and remove sound:
# Usage: ff input_file [output_file]
ff() {
    if [ $# -lt 1 ]; then
        echo "Usage: ff input_file [output_file]"
        return 1
    fi
    in="$1"
    out="${2:-${in%.*}_converted.mp4}"
    ffmpeg -i "$in" -c:v libx265 -preset slow -crf 23 -an -threads 10 "$out"
}



# Cleaning signing info from: $jarfile
# Usage: cleanjar <jar-file>
cleanjar() {
    if [ $# -lt 1 ]; then
        echo "Usage: cleanjar <jar-file>"
        return 1
    fi

    jarfile="$1"

    if [ ! -f "$jarfile" ]; then
        echo "Error: File '$jarfile' not found"
        return 2
    fi

    echo "Cleaning signing info from: $jarfile"
    zip -d "$jarfile" 'META-INF/*.SF' 'META-INF/*.DSA' 'META-INF/*.RSA'
}


# Extract card numbers from export file
# Usage: cleancsv <input.csv> [output.csv]
cleancsv() {
    if [ $# -lt 1 ]; then
        echo "Usage: cleancsv <input.csv> [output.csv]"
        return 1
    fi

    input="$1"
    output="${2:-$1}"  # default: overwrite input

    if [ ! -f "$input" ]; then
        echo "Error: File '$input' not found"
        return 2
    fi

    # Create temp file safely
    tmpfile=$(mktemp)


    grep -v 'Adres klienta\|uszkodzona\|NA OKAZICIELA' "$input" \
    | tac \
    | cut -d',' -f7 \
    | awk '{print 0$0}' \
    | tee "$tmpfile" \
    | tr '\n' ','


    mv "$tmpfile" "$output"
    echo "Processed CSV written to: $output"
}
