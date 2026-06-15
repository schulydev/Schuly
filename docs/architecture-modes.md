# App modes: Account vs Private (secure)

Schuly runs in one of two modes, chosen at the gate. Both read the same two
school systems (Schulnetz, OdAOrg) and the same backend-served catalog; the
difference is **who authenticates** and **where the data rests**.

```mermaid
flowchart TB
  User(["User"])
  User --> Gate{"App mode?"}

  Gate -->|"Account"| Login
  Gate -->|"Private (no login)"| Catalog

  subgraph ACCOUNT["🔐 Account mode — Schuly login"]
    direction TB
    Login["OIDC login<br/>(Pocket ID)"]
    ApiClient["ApiClient<br/>Bearer token + auto-refresh"]
    Backend[("SchulyBackend<br/>authenticated /api/*")]
    DB[("PostgreSQL<br/>data stored per user")]
    Sync["Plugin sync tasks<br/>(background, recurring)"]
    Login --> ApiClient --> Backend
    Backend <--> DB
    Sync -->|"stores"| DB
  end

  subgraph PRIVATE["🕶️ Private / secure mode — NO login, NO OIDC"]
    direction TB
    Catalog["SchoolSystemsService<br/>clean Dio (no auth interceptor)"]
    AnonCat[("GET /api/app/school-systems<br/>[AllowAnonymous]")]
    Connect["Generic connect screen<br/>renders loginFields by loginMethod"]
    SP["SchulwareProxyClient<br/>clean Dio"]
    OP["OdaorgProxyClient<br/>clean Dio"]
    Stateless[("Backend stateless proxy<br/>/api/plugins/*/stateless/*<br/>[AllowAnonymous] — stores nothing")]
    Keystore[("On-device keystore only")]
    Catalog --> AnonCat
    Catalog --> Connect
    Connect -->|"oauth-webview"| SP
    Connect -->|"credentials"| OP
    SP --> Stateless
    OP --> Stateless
    SP -.->|"creds saved"| Keystore
    OP -.->|"creds saved"| Keystore
  end

  subgraph SOURCES["School systems"]
    direction TB
    Schulnetz["Schulnetz<br/>(SchulwareAPI)"]
    OdaOrg["OdaOrg portal"]
  end

  Sync -->|"scrape / proxy"| Schulnetz
  Sync -->|"scrape"| OdaOrg
  Stateless -->|"live, nothing stored"| Schulnetz
  Stateless -->|"live, nothing stored"| OdaOrg
```

|                     | 🔐 Account mode                | 🕶️ Private / secure mode                          |
| ------------------- | ------------------------------ | ------------------------------------------------- |
| Auth to Schuly      | OIDC (Pocket ID) bearer        | **none**                                          |
| HTTP client         | `ApiClient` (auth interceptor) | clean `Dio`, anonymous endpoints only             |
| Where data lives    | server-side in Postgres        | **on-device only**                                |
| Backend role        | stores + background-syncs      | live stateless proxy, stores nothing              |
| Provider selection  | per connected account          | catalog `loginMethod` (`oauth-webview` / `credentials`) |
