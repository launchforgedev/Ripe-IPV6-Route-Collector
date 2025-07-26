#!/bin/bash

# Output files
LAST_FILE_LOG=".last_processed_rib.txt"
IPV6_LOG="ipv6log.txt"

# Date config: yesterday (safer, more likely to be available)
FOLDER_DATE=$(date -u -d "1 day ago" +"%Y.%m")
DATE_FLAT=$(date -u -d "1 day ago" +"%Y%m%d")
DISPLAY_DATE=$(date -u -d "1 day ago" +"%Y-%m-%d")

# Target a single RRC and hour for testing
RRC="rrc00"
HOUR="0000"

# Construct file and URL
FILE="bview.${DATE_FLAT}.${HOUR}.gz"
BASE_URL="https://data.ris.ripe.net/$RRC/$FOLDER_DATE"
URL="$BASE_URL/$FILE"

# Skip if already processed
if [ -f "$LAST_FILE_LOG" ] && grep -q "$URL" "$LAST_FILE_LOG"; then
    echo "[$(date)] ⏩ Already processed: $URL"
    exit 0
fi

# Download with progress
echo "[$(date)] 🔍 Trying $URL..."
echo "[$(date)] ⬇ Downloading $FILE..."
wget --progress=dot:mega "$URL" -O "$FILE"

# Check download success
if [ $? -eq 0 ]; then
    echo "[$(date)] ✅ Downloaded: $FILE"
    echo "$URL" >> "$LAST_FILE_LOG"
    sort -u "$LAST_FILE_LOG" -o "$LAST_FILE_LOG"

    echo "[$(date)] 📦 Extracting IPv6 routes..."
    > "$IPV6_LOG"
    bgpdump "$FILE" \
        | grep -Eo '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/[0-9]+' \
        | sort -u >> "$IPV6_LOG"

    echo "[$(date)] ✅ IPv6 prefixes saved in $IPV6_LOG"
    echo "[$(date)] ✅ Finished processing $FILE for $DISPLAY_DATE"
else
    echo "[$(date)] ❌ Failed to download: $URL"
    rm -f "$FILE"
fi

