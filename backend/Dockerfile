FROM node:20-bookworm-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# 1. Copy index.js directly into the WORKDIR (/nakama/data/)
# We are NOT putting it in a modules folder anymore to stop the path doubling
COPY ./modules/index.js .

# 2. Copy dependencies
COPY --from=builder /app/node_modules ./node_modules/

# 3. Copy the config
COPY ./local.yml .

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "local.yml", "--database.address", "root@localhost:26257"]