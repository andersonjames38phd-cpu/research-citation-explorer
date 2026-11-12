#!/usr/bin/env bash
# Research Citation Explorer - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~research-citation-explorer"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. One paper, both directions
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "dois": [
        "10.48550/arXiv.2005.11401"
      ],
      "direction": "both",
      "maxPerSeed": 25
    }'

# 2. Several seeds, only recent citing papers
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "dois": [
        "10.1038/s41586-021-03819-2",
        "10.48550/arXiv.2005.11401"
      ],
      "direction": "citing",
      "maxPerSeed": 100,
      "minYear": 2023
    }'

# 3. Synchronous run - get items in the same response (small jobs only)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}&format=json" \
  -H "Content-Type: application/json" \
  -d '{
      "dois": [
        "10.48550/arXiv.2005.11401"
      ],
      "direction": "cited",
      "maxPerSeed": 5
    }'
