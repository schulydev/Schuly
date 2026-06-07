# <p align="center">Schuly</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/schulydev/Schuly/main/assets/app_icon.png" width="160" alt="Schuly Logo">
</p>
<p align="center">
  <strong>The better Schulnetz app — Flutter mobile client</strong>
</p>
<p align="center">
  <a href="https://github.com/schulydev/Schuly/stargazers"><img src="https://img.shields.io/github/stars/schulydev/Schuly?style=flat&color=3da8ff" alt="GitHub stars"/></a>
  <a href="https://github.com/schulydev/Schuly/releases"><img src="https://img.shields.io/github/v/release/schulydev/Schuly?include_prereleases&color=3da8ff&label=Release" alt="Latest Release"/></a>
  <a href="https://schuly.dev"><img src="https://img.shields.io/badge/site-schuly.dev-3da8ff" alt="Website"/></a>
</p>

A modern Flutter mobile app providing a superior alternative to the official Schulnetz client. Intuitive interface, multi-user support, and seamless access to grades, timetable, absences, documents & report cards (Zeugnisse), and holidays.

> [!IMPORTANT]
> This project is **NOT** affiliated with, endorsed by, or connected to Schulnetz or Centerboard AG in any way.

## The Schuly ecosystem

| Repo | Purpose |
|---|---|
| [**Schuly**](https://github.com/schulydev/Schuly) | Flutter mobile app *(this repo)* |
| [**SchulyBackend**](https://github.com/schulydev/SchulyBackend) | ASP.NET Core API backend |
| [**SchulyPluginAbstractions**](https://github.com/schulydev/SchulyPluginAbstractions) | Plugin contract (NuGet) |
| [**SchulyPlugins**](https://github.com/schulydev/SchulyPlugins) | Official plugins monorepo |
| [**SchulyWebsite**](https://github.com/schulydev/SchulyWebsite) | Landing site ([schuly.dev](https://schuly.dev)) |

## Run / build

Common workflows are wrapped as [bun](https://bun.sh) scripts (bun is only the task runner — it doesn't pull in a Node toolchain), so they run the same way from any shell:

```sh
bun run dev               # flutter run, dev flavor
bun run prod              # flutter run, prod flavor
bun run analyze           # flutter analyze
bun run test              # flutter test
bun run format            # dart format lib
bun run build:apk:dev     # release APK, dev flavor
bun run build:apk:prod    # release APK, prod flavor
bun run build:ios         # iOS build (no codesign)
bun run icons             # regenerate launcher icons
bun run clean             # flutter clean && pub get
```

Flavors: `dev` (`com.schuly.app.dev`, "Schuly DEV") and `prod` (`com.schuly.app`, "Schuly"). Targets Android and iOS only.

## Connecting to a local backend (dev)

The backend URL is compiled in via `--dart-define=BACKEND_BASE_URL` and defaults to `http://localhost:5033` — no machine IP is ever committed.

```sh
# USB device → run the backend on the host, tunnel, build + install:
bun run install:dev:usb     # = adb reverse tcp:5033 tcp:5033 + install:dev

# Same network / wireless → point at the host's LAN IP explicitly:
BACKEND_BASE_URL=http://<dev-box-lan-ip>:5033 bun run install:dev:url
```

(`bun run install:dev` / `install:prod` build + install with the defaults; `bun run adb:reverse` just sets up the tunnel.)

## Regenerate the API client

The Dart client at `lib/api/` is generated from [SchulyBackend](https://github.com/schulydev/SchulyBackend)'s OpenAPI spec:

```sh
bun run apigen             # against http://localhost:5033 (live backend)
```

`openapi.json` is never committed — always regenerate from a running backend. See `CLAUDE.md` for details.

## App icons

Source: `assets/app_icon.png`. Regenerate with `bun run icons`.
