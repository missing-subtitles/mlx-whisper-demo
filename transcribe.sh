#/bin/bash

# MAKE SURE YOU HAVE ALREADY EXECUTED "dependency.sh"

# check arguments
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 <input_file> [CLIP_TIMESTAMPS]"
    exit 1
fi

# mlx_whisper will give out a VTT file named "$1.vtt",
# which could be slightly different from the verbose output. 
# I choose to keep both, 
# and convert the verbose one to another VTT, "$1.tmp.vtt", for reference.

uv run mlx_whisper \
  --model "mlx-community/whisper-large-v3-turbo" \
  --language zh \
  --output-format vtt \
  --clip-timestamps "$2" \
  "$1" | tee "$1.tmp"

# tmp2vtt
echo "WEBVTT" > "$1.tmp.vtt"
echo "" >> "$1.tmp.vtt"
sed -E "s/\[(.*) --> (.*)\] (.*)/\1 --> \2\n\3\n/" "$1.tmp" >> "$1.tmp.vtt"
# Delete Args in WEBVTT output
sed '3d' "$1.tmp.vtt" > "$1.tmp.vtt.new" && mv "$1.tmp.vtt.new" "$1.tmp.vtt"
