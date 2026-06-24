# Development setup

Local environment setup for working on the Schuly Flutter app.

## Prerequisites

| Tool | Version | Notes |
| --- | --- | --- |
| Flutter SDK | `3.44.x` | Pinned in CI (`subosito/flutter-action`). Bundles the matching Dart SDK. |
| Dart SDK | `^3.10.0` | Comes with Flutter `3.44.x`; also the `environment.sdk` constraint in `pubspec.yaml`. |
| bun | `latest` | Used purely as a task runner for the `package.json` scripts. It does **not** pull in a Node toolchain - it only dispatches commands. |
| Android SDK / Xcode | - | Standard Flutter mobile toolchain for building/running on Android or iOS. |

Verify the Flutter toolchain with:

```sh
flutter doctor
```

## Tasks (preferred)

All common workflows are wrapped as `package.json` scripts so they're invoked the
same way from any shell. Always prefer `bun run <script>` over the raw command.

```sh
bun run dev        # flutter run --flavor dev
bun run prod       # flutter run --flavor prod
bun run analyze    # flutter analyze
bun run test       # flutter test
bun run format     # dart format lib
bun run clean      # flutter clean && flutter pub get
```

## Getting dependencies

```sh
bun run clean
```

This runs `flutter clean && flutter pub get`. The app depends on the local generated
API package at `lib/api/` (referenced via `path:` in `pubspec.yaml`) - see
[API client](../api-client.md) if you need to regenerate it.

## Running the app

Start an emulator or connect a device, then run one of the flavors:

```sh
bun run dev     # development flavor
bun run prod    # production flavor
```

### Flavors

The app defines an `environment` flavor dimension (Android: `productFlavors` in
`android/app/build.gradle.kts`):

| Flavor | Application ID | Display name |
| --- | --- | --- |
| `dev` | `com.schuly.app.dev` (`.dev` suffix, version name suffix `-DEV`) | **Schuly DEV** |
| `prod` | `com.schuly.app` | **Schuly** |

Because the IDs differ, the dev and prod builds install side by side on the same
device. Use `dev` for day-to-day work and `prod` to validate release behavior.

## Quality checks before pushing

```sh
bun run analyze   # static analysis
bun run test      # unit/widget tests
bun run format    # auto-format lib/
```

The generated client at `lib/api/**` is excluded from `flutter analyze` (see
`analysis_options.yaml`).

## Related

- [Build & release](build-and-release.md) - release APKs, iOS, adb install, icons.
- [Contributing](../contributing.md) - branch/PR workflow.
