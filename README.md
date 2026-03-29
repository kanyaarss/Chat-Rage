# **Chat Rage**

**Chat Rage** is a cloud-based chat/live chat application built using the **Elixir** programming language and the **Phoenix** framework. This project is distributed as an **Elixir Release** (compiled binary), making it fully ready for deployment in a production environment.

---

## **Core Characteristics**

* **Application Name**: `ChatApi` (v0.1.0)
* **Release Name**: `dk168`
* **Domain Destination**: `livechat.kanyaars.cloud`
* **Project Type**: Real-time Communication Platform
* **Server Role**: Backend API Server with WebSocket support for live messaging
* **Environment**: Production-ready deployment

---

## **1. Folder Structure**

```
Chat Rage/
├── bin/
│   └── dk168                          # Main Elixir Release Executable
├── erts-13.2.2.5/                     # Erlang Runtime System
│   └── bin/                           # BEAM VM & tools
│       ├── beam.smp (Parallel VM)
│       ├── erl, erlc (Compiler)
│       ├── epmd (Node Discovery)
│       ├── run_erl, to_erl (Console)
│       └── [13 executable tools]
├── lib/                               # Compiled Libraries & Dependencies
│   ├── chat_api-0.1.0/                # Main Application (Compiled)
│   │   └── ebin/
│   │       ├── Elixir.ChatApi.* (Core Modules)
│   │       ├── Elixir.ChatApiWeb.* (Web Controllers & Views)
│   │       └── [13 sample compiled beams]
│   ├── [55+ Dependency Libraries]
│   │   ├── appsignal_phoenix-2.0.7    # APM Monitoring
│   │   ├── phoenix/                  # Web Framework
│   │   ├── postgrex-0.15.5           # PostgreSQL Driver
│   │   ├── redix-0.10.7              # Redis Client
│   │   ├── phoenix_pubsub_redis      # Pub/Sub Messaging
│   │   ├── joken-2.3.0               # JWT Tokens
│   │   ├── cowboy-2.8.0              # HTTP Server
│   │   ├── ex_aws_s3-2.0.2           # AWS S3 Storage
│   │   ├── ex_aws_ses-2.1.1          # AWS SES Email
│   │   ├── oban-2.1.0                # Job Queue
│   │   ├── sentry-8.0.0              # Error Tracking
│   │   └── [40+ additional libraries]
│   └── elixir-1.17.3/ & runtime libraries
├── tmp/                              # Runtime Temporary Directory
│   ├── log/
│   │   └── erlang.log.1              # Erlang System Logs
│   └── pipe/                         # Named Pipes / IPC
├── .env.prod.livechat                # Production Environment Config
├── createdb.sh                       # Database Initialization Script
├── migrate.sh                        # Database Migration Runner
├── seed.sh                           # Database Seeding Script
└── rollback.sh                       # Migration Rollback Script
```

---

## **2. System Architecture**

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                             │
│   (Web Browser / Mobile / Widget / Third-party Integration)     │
└────────────────────────────────────┬───────────────────────────┘
                                     │
                        ┌────────────┴────────────┐
                        │   HTTPS / WebSocket     │
                        └────────────┬────────────┘
                                     │
┌────────────────────────────────────▼──────────────────────────────┐
│                 ELIXIR / PHOENIX WEB SERVER                       │
│                      (dk168 Application)                          │
├───────────────────────────────────────────────────────────────────┤
│  • HTTP/WebSocket (Port 4012)  [Cowboy 2.8.0]                     │
│  • Request Routing & Controllers                                  │
│  • Session Management [Pow 1.0.20]                                │
│  • Authentication & Authorization                                 │
│  • Real-time Features (LiveView)                                  │
│  • Pub/Sub via Redis [phoenix_pubsub_redis 3.0.0]                 │
└────────┬─────────────────────┬──────────────────┬────────────────┘
         │                     │                  │
    ┌────▼────┐          ┌─────▼──────┐    ┌─────▼──────┐
    │         │          │            │    │            │
┌───▼──┐   ┌──▼───┐   ┌──▼──────┐  ┌─▼────▼──┐ ┌──────▼─┐
│      │   │      │   │         │  │         │ │        │
│  DB  │   │Redis │   │ AWS S3  │  │ AWS SES │ │ Sentry │
│  PG  │   │PubSub│   │ Storage │  │ / Email │ │ / APM  │
│      │   │      │   │ Service │  │ Service │ │        │
└──────┘   └──────┘   └─────────┘  └─────────┘ └────────┘
   │
   └─ PostgreSQL Connection
      (DATABASE_URL: livechat_kanyaars_prod)
```

### **Key Components**

* **Cowboy Server** → Handles HTTP & WebSocket connections
* **Phoenix Framework** → MVC structure & real-time engine
* **Ecto / PostgreSQL** → Data persistence & ORM
* **Redis** → Session storage, Pub/Sub, caching
* **AWS Services** → File storage & email delivery
* **Oban** → Background job processing
* **Joken / JWT** → Token-based authentication
* **AppSignal** → Performance monitoring

---

## **3. Tech Stack**

### **A. Core Runtime & VM**

| Component | Version  | Purpose                         |
| --------- | -------- | ------------------------------- |
| Erlang    | 13.2.2.5 | Virtual Machine (BEAM)          |
| Elixir    | 1.17.3   | Functional programming language |
| OTP       | 26.x     | Distributed system support      |

---

### **B. Web Framework & HTTP**

| Technology  | Version | Purpose                            |
| ----------- | ------- | ---------------------------------- |
| Phoenix     | Latest  | Web framework & real-time features |
| Cowboy      | 2.8.0   | HTTP & WebSocket server            |
| Plug        | 1.11.1  | Middleware pipeline                |
| Plug Cowboy | 2.4.1   | Phoenix adapter                    |

---

### **C. Database & Persistence**

| Technology            | Version  | Purpose                       |
| --------------------- | -------- | ----------------------------- |
| PostgreSQL (Postgrex) | 0.15.5   | Primary database              |
| Ecto                  | 4.1.0    | ORM & query builder           |
| DB Connection         | 2.2.2    | Connection pooling (Pool: 10) |
| Migration Manager     | Built-in | Schema versioning             |

---

### **D. Real-Time & Messaging**

| Technology           | Version  | Purpose               |
| -------------------- | -------- | --------------------- |
| Phoenix PubSub Redis | 3.0.0    | Distributed messaging |
| Redix                | 0.10.7   | Redis client          |
| Redis                | External | Session & broker      |

---

### **E. Authentication & Authorization**

| Technology     | Version | Purpose               |
| -------------- | ------- | --------------------- |
| Pow            | 1.0.20  | Authentication system |
| Joken          | 2.3.0   | JWT handling          |
| Jose           | 1.11.1  | Cryptography          |
| SSL Verify Fun | 1.1.6   | SSL validation        |

---

### **F. Cloud & External Services**

| Technology       | Version | Purpose                 |
| ---------------- | ------- | ----------------------- |
| AWS SDK (Ex AWS) | 2.1.6   | AWS integration         |
| AWS S3           | 2.0.2   | File storage            |
| AWS SES          | 2.1.1   | Email service           |
| Tesla            | 1.4.0   | HTTP client             |
| HTTPoison        | 1.8.0   | Alternative HTTP client |

---

### **G. Background Processing**

| Technology       | Version | Purpose    |
| ---------------- | ------- | ---------- |
| Oban             | 2.1.0   | Job queue  |
| Telemetry        | 0.5.0   | Metrics    |
| Telemetry Poller | 0.5.1   | Monitoring |

---

### **H. Monitoring & Error Tracking**

| Technology        | Version | Purpose          |
| ----------------- | ------- | ---------------- |
| Sentry            | 8.0.0   | Error tracking   |
| AppSignal Phoenix | 2.0.7   | APM              |
| AppSignal Plug    | 2.0.8   | Request tracking |

---

### **I. Data Formats & Parsing**

| Technology | Version | Purpose       |
| ---------- | ------- | ------------- |
| Jason      | 1.4.4   | JSON          |
| Floki      | 0.30.0  | HTML parsing  |
| Sweet XML  | 0.7.1   | XML parsing   |
| MIME       | 1.5.0   | Content types |

---

### **J. Utilities & Helpers**

| Technology | Version | Purpose              |
| ---------- | ------- | -------------------- |
| Gettext    | 0.18.0  | Internationalization |
| Decimal    | 1.9.0   | Precision math       |
| EEx        | 1.17.3  | Template engine      |
| Paginator  | 1.0.4   | Pagination           |
| Scrivener  | 2.7.0   | Pagination           |
| Mail       | 0.2.2   | Email builder        |
| Decorator  | 1.4.0   | Pattern support      |

---

### **K. Third-Party Integrations**

| Technology      | Version  | Purpose             |
| --------------- | -------- | ------------------- |
| Expo Server SDK | 0.2.0    | Push notifications  |
| Customer.io     | 0.2.2    | Customer engagement |
| GitHub API      | Built-in | Issue tracking      |
| Slack API       | Built-in | Notifications       |

---

### **L. Compilation & Tooling**

| Component       | Version | Purpose     |
| --------------- | ------- | ----------- |
| Elixir Compiler | 8.2.6.3 | Compilation |
| Syntax Tools    | 3.0.1   | AST         |
| EEx             | 1.17.3  | Templates   |

---

### **M. Runtime Support Libraries**

| Technology    | Version  | Purpose              |
| ------------- | -------- | -------------------- |
| SSL/TLS       | 10.9.1.3 | Secure communication |
| Public Key    | 1.13.3.2 | Crypto               |
| SASL          | 4.2      | Monitoring           |
| Runtime Tools | 1.19     | Debugging            |
| Timezone Data | 1.0.5    | Timezones            |

---

### **N. Infrastructure**

| Component         | Value          | Purpose                 |
| ----------------- | -------------- | ----------------------- |
| Release Node Name | dk168_livechat | Node ID                 |
| Distribution Type | sname          | Short-name distribution |
| Port              | 4012           | HTTP/WebSocket          |
| DB Pool Size      | 10             | Connections             |
| Environment       | Production     | livechat.kanyaars.cloud |

---

## **Tech Stack Summary**

* **Backend**: Elixir 1.17.3 + Phoenix
* **Database**: PostgreSQL 12+ (Ecto ORM)
* **Caching / Messaging**: Redis
* **Server**: Cowboy (WebSocket support)
* **Auth**: JWT + Pow
* **Storage**: AWS S3
* **Email**: AWS SES + Customer.io
* **Jobs**: Oban
* **Monitoring**: Sentry + AppSignal
* **Cloud**: AWS Ecosystem
* **Integrations**: GitHub, Slack, Expo

---
