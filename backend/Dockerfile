# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Point to where package.json is (Root)
COPY package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# --- UPDATED PATHS TO MATCH YOUR SIDEBAR ---
# Your sidebar shows index.js is inside backend/modules/
COPY ./backend/modules/index.js /nakama/data/modules/

# Your sidebar shows local.yml is inside backend/
COPY ./backend/local.yml /nakama/data/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]