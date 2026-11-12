// Research Citation Explorer - Node.js example.
//
// Install:
//   npm install apify-client
//
// Run:
//   APIFY_TOKEN=your_token node node.mjs

import { ApifyClient } from 'apify-client';

const TOKEN = process.env.APIFY_TOKEN ?? 'YOUR_TOKEN';
const ACTOR = 'Turboextract/research-citation-explorer';

const client = new ApifyClient({ token: TOKEN });

// 1. Start the actor and wait for it to finish
const runInput = {
    dois: ['10.48550/arXiv.2005.11401'],
    direction: 'citing',
    maxPerSeed: 200,
    minYear: 2022,
};

const run = await client.actor(ACTOR).call(runInput);

// 2. Pull dataset items
const { items } = await client.dataset(run.defaultDatasetId).listItems();

for (const item of items) {
    console.log(`${item.publicationYear}  ${String(item.citedByCount).padStart(6)} cites  ${item.title}`);
}

console.log(`\n${items.length} papers returned.`);

// 3. Or stream item-by-item (useful for large jobs)
// for await (const item of client.dataset(run.defaultDatasetId).iterate()) {
//     console.log(item);
// }
