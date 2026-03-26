# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# The package files are likely one level UP in the main folder
COPY ../package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy dependencies from builder
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# --- PATHS RELATIVE TO THE BACKEND FOLDER ---
# 1. Copy your logic from the modules subfolder
COPY ./modules/index.js /nakama/data/modules/

# 2. Copy the config file from right next to the Dockerfile
COPY ./local.yml /nakama/data/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]