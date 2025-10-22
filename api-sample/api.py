# this is almost equivalent to the commands below:
# pip install mlx mlx-whisper huggingface_hub
# hf download --local-dir whisper-large-v3-turbo mlx-community/whisper-large-v3-turbo
# mlx_whisper --model "mlx-community/whisper-large-v3-turbo" <AUDIO_FILE>

import mlx_whisper
import sys

result = mlx_whisper.transcribe(
    audio=sys.argv[1],
    path_or_hf_repo="mlx-community/whisper-large-v3-turbo",
    verbose=False,
)

segments = result["segments"]

for segment in segments:
    print(
        segment["start"], 
        segment["end"], 
        segment["text"]
    )
