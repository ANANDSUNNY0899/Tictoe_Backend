# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Now we look in the CURRENT folder (backend)
COPY ./package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy dependencies from builder stage
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# Copy your logic and config from the backend folder
COPY ./modules/index.js /nakama/data/modules/
COPY ./local.yml /nakama/data/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]