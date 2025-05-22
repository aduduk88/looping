#!/data/data/com.termux/files/usr/bin/bash

# === KONFIGURASI ===
VIDEO="$HOME/looping/remix.mp4"                  # File video lokal Termux
LOGFILE="$HOME/ytstream.log"                    # File log

# stream live YouTube
STREAM_KEY="vta0-jtc0-k6zt-rt11-634q"           # KEYYOUTUBE
live="qdpv-m6dc-8k6c-r2zr-8c2j"                 # live

# Gabungan RTMP dengan tag [f=flv]
YOUTUBE_URL="tee:[f=flv]rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY|[f=flv]rtmp://a.rtmp.youtube.com/live2/$live"

# === CEK FILE VIDEO ===
if [ ! -f "$VIDEO" ]; then
  echo "[ERROR] File tidak ditemukan: $VIDEO"
  exit 1
fi

# === INFO ===
echo "[INFO] Streaming dimulai ke dua akun YouTube. Log: $LOGFILE"
echo "[INFO] Tekan Ctrl+C untuk berhenti."

# === LOOP STREAMING ===
while true; do
  ffmpeg -re -stream_loop -1 -i "$VIDEO" \
    -c:v libx264 -preset veryfast -tune film \
    -maxrate 3000k -bufsize 6000k \
    -c:a aac -b:a 128k -ar 44100 \
    -f "$YOUTUBE_URL" >> "$LOGFILE" 2>&1

  echo "[INFO] Streaming terputus. Mencoba lagi dalam 5 detik..." | tee -a "$LOGFILE"
  sleep 5
done
