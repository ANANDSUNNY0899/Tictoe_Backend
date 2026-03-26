# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Copy package files from the backend folder
COPY package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
# Nakama's default workdir is /nakama/data
WORKDIR /nakama/data

# 1. Copy dependencies into the modules subfolder
COPY --from=builder /app/node_modules ./modules/node_modules/

# 2. Copy your logic from the modules subfolder on your PC
# This puts index.js into /nakama/data/modules/index.js
COPY ./modules/index.js ./modules/

# 3. Copy the config file to the current directory (/nakama/data/)
COPY ./local.yml .

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
# Notice we removed the extra /data/ from the path here
CMD ["--config", "local.yml", "--database.address", "root@localhost:26257"]