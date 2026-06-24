# Schuly documentation

Schuly is a Flutter mobile app for accessing school data (grades, exams, agenda,
absences) from Schulnetz-based systems. It runs in two modes - an **account mode**
backed by [SchulyBackend](https://github.com/schulydev/SchulyBackend) over OIDC, and
a **private / secure mode** that keeps credentials on-device and talks only to
anonymous stateless proxy endpoints. The UI is built with [Forui](https://forui.dev).

## Contents

| Doc | What it covers |
| --- | --- |
| [Architecture: app modes](architecture-modes.md) | Account vs private mode, where data lives, the connect flow |
| [Development setup](setup/development.md) | Flutter SDK, bun task runner, running the dev/prod flavors, analyze/test/format |
| [Build & release](setup/build-and-release.md) | Release APKs, iOS build, adb install, app-icon regeneration |
| [API client](api-client.md) | How `lib/api/` is generated and how to regenerate it |
| [Contributing](contributing.md) | The enforced issue → branch → PR workflow and label taxonomy |

## Quick start

```sh
bun run clean   # flutter clean && flutter pub get
bun run dev     # run the dev flavor on a connected device/emulator
```

See [Development setup](setup/development.md) for prerequisites.
