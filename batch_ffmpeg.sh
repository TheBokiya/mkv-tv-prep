#!/bin/bash

# Loop through all movie folders
for dir in */; do
    # Skip if not a movie folder
    [[ "$dir" == "Screenshots/" ]] && continue
    [[ "$dir" == "External AC3/" ]] && continue

    echo "📂 Entering $dir"

    # Find the real MKV (ends with ETRG.mkv, exclude sample)
    mkvfile=$(find "$dir" -maxdepth 1 -type f -name "*ETRG.mkv" ! -name "*Sample*")
    [ -z "$mkvfile" ] && echo "❌ No main MKV found in $dir, skipping..." && continue

    # Extract basename
    basename=$(basename "$mkvfile" .mkv)

    # Look for English subtitle in the Subtitles subfolder
    subfile=$(find "${dir}Subtitles" -type f -iname "*English.srt" | head -n 1)

    if [ -n "$subfile" ]; then
        echo "🎬 Processing $mkvfile with subs $subfile ..."
        ffmpeg -i "$mkvfile" -i "$subfile" \
        -map 0:v -map 0:a -map 1:s \
        -c:v copy \
        -c:a:0 copy \
        -c:a:1 ac3 -b:a:1 384k \
        -c:s srt \
        -disposition:a:1 default \
        -disposition:s:0 default+forced \
        -metadata:s:s:0 language=eng \
        "${dir}${basename}_tv_ready.mkv"
    else
        echo "⚠ No English subtitle found in $dir, adding audio only..."
        ffmpeg -i "$mkvfile" \
        -map 0:v -map 0:a \
        -c:v copy \
        -c:a:0 copy \
        -c:a:1 ac3 -b:a:1 384k \
        -disposition:a:1 default \
        "${dir}${basename}_tv_ready.mkv"
    fi
done
