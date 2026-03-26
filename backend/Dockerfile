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
# Notice: No database flags here. We will use the Environment Variable exclusively.
CMD ["--config", "./data/local.yml", "--data_dir", "./data"]