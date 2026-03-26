# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Look in the same folder as this Dockerfile
COPY package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy dependencies
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# --- CRITICAL CHANGE HERE ---
# If your file is named index.js, use index.js. If it is local.js, use local.js
COPY ./index.js /nakama/data/modules/
COPY ./local.yml /nakama/data/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]