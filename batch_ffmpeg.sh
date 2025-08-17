#!/bin/zsh

# Batch script to process all movies for Samsung TV compatibility
# - Picks the main MKV file ending with ETRG.mkv
# - Embeds English subtitles (ends with English.srt)
# - Copies video
# - Keeps original audio + adds AC3 track
# - Outputs new file with _tv.mkv suffix

for dir in */; do
    movie_file=$(find "$dir" -type f -name "*ETRG.mkv" ! -iname "*sample*" | head -n 1)
    sub_file=$(find "$dir" -type f -path "*/Subtitles/*English.srt" | head -n 1)

    if [[ -n "$movie_file" && -n "$sub_file" ]]; then
        output_file="${movie_file%.mkv}_tv.mkv"
        echo "Processing: $movie_file with subs: $sub_file"

        ffmpeg -i "$movie_file" -i "$sub_file" \
            -map 0:v -map 0:a:0 -map 0:a:0 -map "1:s?" \
            -c:v copy \
            -c:a:0 copy \
            -c:a:1 ac3 -b:a:1 448k -ar 48000 -ac 6 \
            -c:s srt \
            -disposition:a:1 default -disposition:a:0 0 \
            -disposition:s:0 default \
            -metadata:s:s:0 language=eng \
            "$output_file"
    else
        echo "Skipping $dir (no matching MKV or English subtitles)"
    fi
done
