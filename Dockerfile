# Step 1: Build stage (to install JS dependencies)
FROM node:node-bookworm-slim AS builder
WORKDIR /app
# Only copy package files first to use Docker cache
COPY package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy the dependencies from the builder stage
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/
# Copy your game logic
COPY ./local.js /nakama/data/modules/

# Expose ports
EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]