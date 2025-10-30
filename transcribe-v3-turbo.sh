#/bin/bash

# MAKE SURE YOU HAVE ALREADY EXECUTED "dependency.sh"

# check arguments
if [ $# -lt 1 ] ;then
    echo "Usage: $0 <input_file> [LANGUAGE] [OUTPUT_NAME] [CLIP_TIMESTAMPS]"
    exit 1
fi

# mlx_whisper will give out a VTT file named "$1.vtt",
# which could be slightly different from the verbose output. 
# I choose to keep both, 
# and convert the verbose one to another VTT, "$1.tmp.vtt", for reference.

# source .venv/bin/activate
# mlx_whisper \
#   --model "mlx-community/whisper-large-v3-turbo" \
#   --language ${3:-zh} \
#   --output-format vtt \
#   --clip-timestamps "$2" \
#   "$1" | tee "$1.tmp"

TMP="${3:-1}.tmp"

uv run mlx_whisper \
  --model "mlx-community/whisper-large-v3-turbo" \
  --language ${2:-zh} \
  --output-format vtt \
  --output-name "$3" \
  --clip-timestamps "$4" \
  "$1" | tee "$TMP"

# tmp2vtt
echo "WEBVTT" > "$TMP.vtt"
echo "" >> "$TMP.vtt"
sed -E "s/\[(.*) --> (.*)\] (.*)/\1 --> \2\n\3\n/" "$TMP" >> "$TMP.vtt"
# Delete Args in WEBVTT output
sed '3d' "$TMP.vtt" > "$TMP.vtt.new" && mv "$TMP.vtt.new" "$TMP.vtt"
