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

ENTRYPOINT ["/nakama/nakama"]
# We put the actual Render DB URL here to force the connection
CMD ["--config", "./data/local.yml", "--data_dir", "./data", "--database.address", "root:cby1yuK1SooZbmNZpgZ4I8IufZGZ71pN@dpg-d72osnu3jp1c7386n5ag-a:5432/nakama_a6dq"]