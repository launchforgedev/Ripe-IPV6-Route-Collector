# RIPE IPv6 Route Collector

A production-style IPv6 route collection and analytics system built around RIPE RIS routing data.

This project downloads BGP routing snapshots from RIPE RIS collectors, extracts IPv6 prefixes, validates and normalizes routes, stores them in a database, and provides analytics APIs for route visibility and anomaly detection.

The repository is designed to simulate realistic networking infrastructure workflows involving:
- BGP route collection
- IPv6 prefix processing
- async worker pipelines
- route normalization
- database-backed storage
- analytics processing
- API exposure

---

# Features

## Route Collection
- Downloads RIPE RIS RIB snapshots
- Supports multiple RRC collectors
- Handles retry and download validation
- Tracks processed snapshots

## IPv6 Prefix Parsing
- Extracts IPv6 prefixes from BGP dumps
- Validates IPv6 network formats
- Normalizes compressed prefixes

## Storage Layer
- SQLAlchemy database integration
- Route persistence
- Duplicate prevention
- Collector metadata tracking

## Async Worker Processing
- Concurrent route processing
- Queue-based ingestion pipeline
- Background processing support

## Analytics
- Route visibility calculations
- Route anomaly detection
- Route flapping analysis

## API
- FastAPI-based service
- Route retrieval endpoints
- Health/status endpoints

---

# Project Structure

```text
Ripe-IPV6-Route-Collector/
│
├── collector/
├── parser/
├── storage/
├── analytics/
├── workers/
├── api/
├── tests/
├── data/
├── logs/
└── scripts/
