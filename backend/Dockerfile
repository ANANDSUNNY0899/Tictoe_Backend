FROM node:20-bookworm-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama

COPY --from=builder /app/node_modules ./data/modules/node_modules/
COPY ./modules/index.js ./data/modules/
COPY ./local.yml ./data/

EXPOSE 7349 7350 7351

# We change the Entrypoint to a shell script so we can chain two commands together
ENTRYPOINT ["/bin/sh", "-c"]

# 1. Run migrations to create tables
# 2. Start the server
CMD ["/nakama/nakama migrate up --config ./data/local.yml && /nakama/nakama --config ./data/local.yml --data_dir ./data"]