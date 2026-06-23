# App modes: Account vs Private (secure)

Schuly runs in one of two modes, chosen at the gate. Both read the same
operator-provided school systems and the same backend-served catalog; the
difference is **who authenticates** and **where the data rests**. The app is
provider-agnostic — concrete systems are catalog data, never hardcoded.

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
    Connect["Generic connect screen<br/>renders loginFields, branches on privateAuthStrategy"]
    TP["TokenProxyClient<br/>clean Dio"]
    SP["ScrapeProxyClient<br/>clean Dio"]
    Stateless[("Backend stateless proxy<br/>/api/plugins/*/stateless/*<br/>[AllowAnonymous] — stores nothing")]
    Keystore[("On-device keystore only")]
    Auth["Authenticator screen<br/>on-device TOTP from vaulted seed"]
    Catalog --> AnonCat
    Catalog --> Connect
    Connect -->|"token"| TP
    Connect -->|"scrape"| SP
    TP --> Stateless
    SP --> Stateless
    TP -.->|"token + context + email/password/TOTP seed saved"| Keystore
    SP -.->|"creds saved"| Keystore
    Keystore -.->|"seed"| Auth
    Keystore -.->|"silent re-login on expiry"| TP
  end

  subgraph SOURCES["School systems (operator-provided)"]
    direction TB
    TokenProvider["Token-strategy provider"]
    ScrapeProvider["Scrape-strategy provider"]
  end

  Sync -->|"proxy"| TokenProvider
  Sync -->|"scrape"| ScrapeProvider
  Stateless -->|"live, nothing stored"| TokenProvider
  Stateless -->|"live, nothing stored"| ScrapeProvider
```

|                     | 🔐 Account mode                | 🕶️ Private / secure mode                          |
| ------------------- | ------------------------------ | ------------------------------------------------- |
| Auth to Schuly      | OIDC (Pocket ID) bearer        | **none**                                          |
| HTTP client         | `ApiClient` (auth interceptor) | clean `Dio`, anonymous endpoints only             |
| Where data lives    | server-side in Postgres        | **on-device only**                                |
| Backend role        | stores + background-syncs      | live stateless proxy, stores nothing              |
| Provider selection  | per connected account          | catalog `privateAuthStrategy` (`token` / `scrape`) |
