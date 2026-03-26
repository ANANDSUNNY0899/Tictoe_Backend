FROM node:20-bookworm-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM heroiclabs/nakama:3.25.0
# We move back one level to the root of the app
WORKDIR /nakama

# 1. Copy dependencies into the standard location
COPY --from=builder /app/node_modules ./data/modules/node_modules/

# 2. Copy your index.js into the standard location
COPY ./modules/index.js ./data/modules/

# 3. Copy the config
COPY ./local.yml ./data/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
# We use the --data_dir flag to FORCE Nakama to use the correct path
CMD ["--config", "./data/local.yml", "--data_dir", "./data", "--database.address", "root@localhost:26257"]