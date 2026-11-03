# Schuly documentation

Use these pages to run, build, and change the Schuly mobile app. Schuly is a Flutter app for Android
and iOS that shows grades, exams, agenda, and absences from school systems. The UI uses
[Forui](https://forui.dev).

The app runs in two modes:

- **Account mode:** uses a Schuly account on [SchulyServer](https://github.com/schulydev/SchulyServer).
- **Private mode** (also called secure mode): keeps credentials on the device and calls anonymous,
  stateless proxy endpoints.

## Quick start

```sh
bun run clean   # flutter clean && flutter pub get
bun run dev     # run the dev flavor on a connected device or emulator
```

[Development setup](setup/development.md) lists the prerequisites.

## Pages

| Page | What it covers |
| --- | --- |
| [App modes](architecture-modes.md) | Account and private mode, where data lives, the connect flow |
| [Development setup](setup/development.md) | Prerequisites, bun tasks, flavors, local backend, quality checks |
| [Build and release](setup/build-and-release.md) | Local builds, adb install, app icons, the release workflow |
| [API client](api-client.md) | How `lib/api/` is generated and how to regenerate it |
| [Contributing](contributing.md) | This repo's rules and checks |
