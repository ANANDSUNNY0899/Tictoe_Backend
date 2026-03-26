FROM node:20-bookworm-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# 1. Copy the modules folder (containing index.js) into the container
COPY ./modules/ ./modules/

# 2. Copy the node_modules from the builder stage
COPY --from=builder /app/node_modules ./modules/node_modules/

# 3. Copy the config file
COPY ./local.yml .

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "local.yml", "--database.address", "root@localhost:26257"]