# RIPE IPv6 Route Collector

This project automates the retrieval and processing of IPv6 BGP routing data from RIPE RIS.
It downloads the latest `bview` BGP dumps from all 26 RRCs (rrc00 to rrc25), extracts unique IPv6 prefixes, and logs them into a file.

---

## 📁 Directory Structure

```
ripe-ipv6-collector/
├── scripts/                 # Bash scripts for automation
│   └── ribupdates.sh       # Main script for processing BGP dumps
├── data/                   # Contains ipv6log.txt output
├── logs/                   # Stores log output or placeholder for Git
│   └── .gitkeep
├── .gitignore              # Ignore unnecessary files
├── crontab.example         # Crontab entry to schedule automation
├── README.md               # This file
├── .last_processed_rib.txt# Keeps track of processed dumps
```

---

## 🚀 How It Works

* Downloads BGP dump files (`bview`) from the RIPE RIS archive
* Extracts all valid IPv6 prefixes using `bgpdump`
* Stores results in `ipv6log.txt`
* Avoids reprocessing already-handled files (tracks via `.last_processed_rib.txt`)

---

## ⏰ Automation via Cron

To run the job every day at 8 AM:

```bash
0 8 * * * /path/to/ripe-ipv6-collector/scripts/ribupdates.sh >> /path/to/ripe-ipv6-collector/logs/cron.log 2>&1
```

> Replace `/path/to/` with your actual path

Save this in your crontab using:

```bash
crontab -e
```

---

## 📦 Requirements

* `bash`
* `wget`
* `bgpdump` (BGP data parser)
* `cron` (for scheduled runs)

Install `bgpdump` via:

```bash
sudo apt install bgpdump
```

---

## 📄 License

MIT License (or insert your license here)

---

## 🙋‍♂️ Author

Prateek — 2025
