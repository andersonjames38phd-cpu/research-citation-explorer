"""Research Citation Explorer - Python example.

Install:
    pip install apify-client

Run:
    APIFY_TOKEN=your_token python python.py
"""

import os
from apify_client import ApifyClient

TOKEN = os.environ.get("APIFY_TOKEN", "YOUR_TOKEN")
ACTOR = "Turboextract/research-citation-explorer"

client = ApifyClient(TOKEN)

# 1. Start the actor and wait for it to finish
run_input = {
    "dois": ["10.48550/arXiv.2005.11401"],
    "direction": "citing",
    "maxPerSeed": 200,
    "minYear": 2022,
}

run = client.actor(ACTOR).call(run_input=run_input)

# 2. Stream results
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(f"{item['publicationYear']}  {item['citedByCount']:>6} cites  {item['title']}")

# 3. Or pull all at once into a list
items = list(client.dataset(run["defaultDatasetId"]).iterate_items())
print(f"\n{len(items)} papers returned.")
