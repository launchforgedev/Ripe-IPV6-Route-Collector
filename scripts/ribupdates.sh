#!/bin/bash

LAST_FILE_LOG=".last_processed_rib.txt"
IPV6_LOG="data/ipv6log.txt"
mkdir -p data logs
> "$IPV6_LOG"

TODAY=$(date -u +"%Y.%m")
DATE_FLAT=$(date -u +"%Y%m%d")
DISPLAY_DATE=$(date -u +"%Y-%m-%d")
HOUR="0000"

for RRC_ID in $(seq -w 0 25); do
    RRC="rrc$RRC_ID"
    FILE="bview.${DATE_FLAT}.${HOUR}.gz"
    BASE_URL="https://data.ris.ripe.net/$RRC/$TODAY"
    URL="$BASE_URL/$FILE"

    if [ -f "$LAST_FILE_LOG" ] && grep -q "$URL" "$LAST_FILE_LOG"; then
        echo "[$(date)] ⏩ Already processed: $URL"
        continue
    fi

    echo "[$(date)] 🔍 Trying $URL..."
    wget --progress=dot:mega "$URL" -O "$FILE"

    if [ $? -eq 0 ]; then
        echo "[$(date)] ✅ Downloaded: $FILE"
        echo "$URL" >> "$LAST_FILE_LOG"
        sort -u "$LAST_FILE_LOG" -o "$LAST_FILE_LOG"

        echo "[$(date)] 📦 Extracting IPv6 routes from $FILE..."
        bgpdump "$FILE" \
            | grep -Eo '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/[0-9]+' \
            | sort -u >> "$IPV6_LOG"

        echo "[$(date)] ✅ IPv6 prefixes saved in $IPV6_LOG"
        echo "[$(date)] ✅ Finished processing $FILE for $DISPLAY_DATE"
    else
        echo "[$(date)] ❌ Failed to download: $URL"
        rm -f "$FILE"
    fi
