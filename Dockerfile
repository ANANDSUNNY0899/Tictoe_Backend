# Step 1: Build stage
FROM node:20-bookworm-slim AS builder
WORKDIR /app

# Change this: Look inside the backend folder for package files
COPY ./backend/package*.json ./
RUN npm install

# Step 2: Final Nakama stage
FROM heroiclabs/nakama:3.25.0
WORKDIR /nakama/data

# Copy the dependencies from the builder stage
COPY --from=builder /app/node_modules /nakama/data/modules/node_modules/

# Change this: Look inside the backend folder for your game logic
COPY ./backend/local.js /nakama/data/modules/
# Also copy your config file from the backend folder
COPY ./backend/local.yml /nakama/data/

# Expose ports
EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/nakama"]
# Update the config path to where we just copied it
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]