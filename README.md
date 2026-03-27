<div align="center">

# ⚙️ LILA Games - Full Stack Assignment (Backend)

### **Server-Authoritative Nakama Engine & Matchmaking Server**

[![Nakama](https://img.shields.io/badge/Nakama-Server-00ADD8?style=for-the-badge&logo=go)](https://heroiclabs.com/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=for-the-badge&logo=postgresql)](#)

This repository contains the **Backend Infrastructure and Game Logic** for the LILA Games multiplayer Tic-Tac-Toe assignment. It utilizes a custom-configured Nakama server to provide secure, real-time, server-authoritative matchmaking and gameplay.

**🟢 Live Server Status:** Deployed & Online  
**🔗 Production API Endpoint:** `lila-tic-tac-toe-backend.onrender.com` (Port `443`, `WSS` enabled)

</div>

---

## 🏗️ Architecture & DevOps Decisions

To ensure a production-ready environment, this backend was built with modern cloud-native principles:

<table>
<tr>
<td width="50%">

### 🛡️ **Server-Authoritative Logic**
All core game mechanics (grid validation, turn enforcement, win/draw calculations) are executed in the server's JavaScript runtime. Clients cannot manipulate game state, preventing cheating.

</td>
<td width="50%">

### 🐳 **Containerized Deployment**
The server is fully Dockerized. The custom `Dockerfile` creates a predictable environment that runs identically on local machines and cloud providers (Render).

</td>
</tr>
<tr>
<td width="50%">

### 💾 **Automated DB Migrations**
Instead of manual database initialization, the `Dockerfile` Entrypoint intercepts the startup sequence to execute `nakama migrate up`, ensuring the PostgreSQL schema is always synchronized before the server binds to its ports.

</td>
<td width="50%">

### 🔐 **12-Factor Security**
All sensitive credentials (Database URLs, API keys) are injected via Environment Variables, keeping `local.yml` and the codebase completely free of exposed secrets.

</td>
</tr>
</table>

---

## 📁 Repository Structure

```text
Tictoe_Backend/
│
├── 📄 Dockerfile            # Custom multi-stage build & migration runner
├── 📄 docker-compose.yml    # Orchestration for local development
├── 📄 local.yml             # Nakama server configuration map
│
└── 📂 modules/
    └── 📄 index.js          # Authoritative Match Handler (The Game Logic)
```

---

## 🚀 Local Development Setup

To test the backend on your local machine, you will need Docker and Docker Compose installed.

### **1. Spin up the server and database**
```bash
docker-compose up -d
```

This command pulls the Nakama image, sets up a local CockroachDB node, and binds the necessary ports.

### **2. Access the Nakama Console**
Once the containers are running, you can monitor the server via the built-in developer console:

* **URL:** http://127.0.0.1:7351
* **Username:** `admin`
* **Password:** `password`

---

## 📡 Match Lifecycle & API Design

The server utilizes Nakama's authoritative match API to manage the game loop.

### **1. Matchmaking**
* Clients connect and call `socket.addMatchmaker("*", 2, 2)`.
* The server waits for exactly 2 players to enter the pool.
* `matchmakerMatched` hook fires, automatically spawning a new authoritative match instance.

### **2. The Game Loop (OpCodes)**
Communication over the WebSocket uses standard OpCodes:

| OpCode | Name | Direction | Server Action |
|--------|------|-----------|---------------|
| 1 | Move Request | Client → Server | Intercepts the requested index. Validates whose turn it is and ensures the grid space is empty. |
| 2 | State Broadcast | Server → Client | Evaluates the board against 8 winning patterns. Broadcasts the updated board, the next turn, and the win/draw status to both players. |

---

## 🔗 Related Repositories

This architecture is decoupled into two repositories for independent scaling and CI/CD pipelines:

* **Backend (This Repo):** Matchmaking and authoritative game loop.
* **Frontend Repo:** [https://github.com/ANANDSUNNY0899/Lila-Multiplayer-TicTacToe?tab=readme-ov-file] - Contains the React Native Web client deployed on Vercel.

---

<div align="center">

## 👨‍💻 Developer

**Developed by:** Sunny Anand  
**Role:** Full Stack Engineer Assignment - LILA Games

</div>
