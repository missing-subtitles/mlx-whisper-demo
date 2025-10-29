# MLX_Whisper Demo

This repo is a demo of running OpenAI's Whisper model with MLX framework.

## Dependency

We rely on `uv` to manage dependency and run the program.

Python packages:

`mlx mlx-whisper huggingface_hub`

They can be installed by executing `dependency.sh`

## Models

Use Whisper Large models, appearently.

Speedup, (media duraion)/(process time), is measured on a Macbook Air M2 13' (2022).

A rough comparison:

|name                    |speedup|hallucination|
|------------------------|-------|-------------|
|`whisper-large-v3-turbo`|~12.2x |frequent     |
|`whisper-large-v2-mlx`  |~4.7x  |normal       |

There's no need to pull the model in advance, `hf` will do the job when model is not present.

## Run transcription

We have diverse scripts for different models. Take `whisper-large-v2` for example: 

```bash
bash transcribe-v2.sh <media> [timestamp] [language]
```

These arguments are the exact ones from the bundled program `mlx_whisper`. Fill them as you would directly to `mlx_whisper`.

```bash
bash transcribe-v2.sh audio.mp3 55,340 zh
```

Timestamps and languages are optional, but setting main language could save you 30 seconds each job, from its automatic language detection. 

If you want to omit timestamp and set language, please put empty `""` placeholder for timestamp like this:

```bash
bash transcribe-v2.sh audio.mp3 "" zh
```

Currently the script is set to give out verbose output during transcription, which the script would `tee` and convert into `<media>.tmp.vtt` for alternative reference. The final output is `<media>.vtt`.

## Calibrate

Pratically, by retrying with timestamps. When the output involves repeating or other mistakes, it's a good choice to run again for the specific interval, sometimes with other models.

But timestamps are measured in seconds. Converting human-friendly `hh:mm:ss` to second is not friendly, use spreadsheet to do it. A template is given [here](https://docs.google.com/spreadsheets/d/1N6zvucsbKoTZsx6R7shLC8piiCQ2Dn4udmLlVOpcrLQ).