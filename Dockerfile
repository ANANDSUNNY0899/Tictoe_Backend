# Use the official Nakama image as the base
FROM heroiclabs/nakama:3.25.0

# Copy your local JS entry point and any modules into the Nakama data folder
# This ensures your Tic-Tac-Toe logic is loaded when the server starts
COPY ./local.js /nakama/data/modules/
COPY ./node_modules /nakama/data/modules/node_modules/

# Expose the Nakama ports
EXPOSE 7349 7350 7351

# Start Nakama with the default configuration
ENTRYPOINT ["/nakama/nakama"]
CMD ["--config", "/nakama/data/local.yml", "--database.address", "root@localhost:26257"]