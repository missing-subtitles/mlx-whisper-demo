#!/bin/bash

# pyenv local 3.13
# python3 -m venv .venv

# source .venv/bin/activate
# pip install mlx mlx-whisper huggingface_hub
# hf download --local-dir whisper-large-v3-turbo mlx-community/whisper-large-v3-turbo

uv python pin 3.13
uv sync
uv run hf download \
  --local-dir models/whisper-large-v3-turbo \
  mlx-community/whisper-large-v3-turbo