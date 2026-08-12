# <p align="center">Schuly</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/schulydev/Schuly/main/assets/app_icon.png" width="160" alt="Schuly Logo">
</p>
<p align="center">
  <strong>The better Schulnetz app - Flutter mobile client</strong>
</p>
<p align="center">
  <a href="https://github.com/schulydev/Schuly/stargazers"><img src="https://img.shields.io/github/stars/schulydev/Schuly?style=flat&color=3da8ff" alt="GitHub stars"/></a>
  <a href="https://github.com/schulydev/Schuly/releases"><img src="https://img.shields.io/github/v/release/schulydev/Schuly?include_prereleases&color=3da8ff&label=Release" alt="Latest Release"/></a>
  <a href="https://docs.schuly.dev/Schuly/"><img src="https://img.shields.io/badge/docs-docs.schuly.dev-3da8ff" alt="Documentation"/></a>
  <a href="https://schuly.dev"><img src="https://img.shields.io/badge/site-schuly.dev-3da8ff" alt="Website"/></a>
</p>

A modern Flutter mobile app providing a superior alternative to the official Schulnetz client. Intuitive interface, multi-user support, and seamless access to grades, timetable, absences, documents & report cards (Zeugnisse), and holidays.

> [!IMPORTANT]
> This project is **NOT** affiliated with, endorsed by, or connected to Schulnetz or Centerboard AG in any way.

## Quick start

Common workflows are wrapped as [bun](https://bun.sh) scripts (bun is only the task runner - it doesn't pull in a Node toolchain):

```sh
bun run dev               # flutter run, dev flavor
bun run prod              # flutter run, prod flavor
bun run analyze           # flutter analyze
bun run test              # flutter test
```

Flavors: `dev` (`com.schuly.app.dev`, "Schuly DEV") and `prod` (`com.schuly.app`, "Schuly"). Targets Android and iOS only.

The backend URL is compiled in via `--dart-define=BACKEND_BASE_URL` and defaults to `http://localhost:5033`, so no machine IP is ever committed. [Development setup](https://docs.schuly.dev/Schuly/setup/development) covers the full script list, the build variants, and pointing the app at a local backend over USB or LAN.

## Documentation

Full documentation lives at **[docs.schuly.dev/Schuly](https://docs.schuly.dev/Schuly/)**.

| Guide | What it covers |
|---|---|
| [Development setup](https://docs.schuly.dev/Schuly/setup/development) | Prerequisites, bun tasks, flavors, and connecting to a local backend. |
| [Build and release](https://docs.schuly.dev/Schuly/setup/build-and-release) | Release builds for Android and iOS, and how a release is cut. |
| [Architecture modes](https://docs.schuly.dev/Schuly/architecture-modes) | Account mode vs private mode, and how each reaches school data. |
| [API client](https://docs.schuly.dev/Schuly/api-client) | Regenerating the Dart client from the backend's OpenAPI document. |
| [Contributing](https://docs.schuly.dev/Schuly/contributing) | Workflow, branch and PR conventions. |

New to Schuly as a user? Start with the [getting-started walkthrough](https://docs.schuly.dev/getting-started/).

## The Schuly ecosystem

| Repo | Purpose |
|---|---|
| [**Schuly**](https://github.com/schulydev/Schuly) | Flutter mobile app *(this repo)* |
| [**SchulyBackend**](https://github.com/schulydev/SchulyBackend) | ASP.NET Core API backend |
| [**SchulyKeycloak**](https://github.com/schulydev/SchulyKeycloak) | Keycloak image + the `schuly` realm |
| [**SchulyPluginAbstractions**](https://github.com/schulydev/SchulyPluginAbstractions) | Plugin contract (NuGet) |
| [**SchulyPlugins**](https://github.com/schulydev/SchulyPlugins) | Official plugins monorepo |
| [**SchulyWebsite**](https://github.com/schulydev/SchulyWebsite) | Landing site ([schuly.dev](https://schuly.dev)) |
| [**SchulyDocs**](https://github.com/schulydev/SchulyDocs) | Documentation site ([docs.schuly.dev](https://docs.schuly.dev)) |
