# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Look in the SAME folder as the Dockerfile for package files
COPY package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy dependencies from builder
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# Copy your game logic and config from the SAME folder as the Dockerfile
COPY ./local.js /nakama/data/modules/
COPY ./local.yml /nakama/data/

# Expose ports
EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
# Point to the config we just copied
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]