# Development setup

Use this page to set up your machine and run the Schuly Flutter app.

## Prerequisites

| Tool | Version | Notes |
| --- | --- | --- |
| Flutter SDK | `3.44.x` | Pinned in CI with `subosito/flutter-action`. Includes the matching Dart SDK. |
| Dart SDK | `^3.10.0` | Comes with Flutter. Also the `environment.sdk` constraint in `pubspec.yaml`. |
| bun | `latest` | Runs the `package.json` scripts. It doesn't add a Node toolchain. |
| Android SDK or Xcode | - | The standard Flutter toolchain for Android or iOS. CI builds Android with Java 17. |

Check the Flutter toolchain:

```sh
flutter doctor
```

## Install dependencies

```sh
bun run clean   # flutter clean && flutter pub get
```

The app depends on the generated API package in `lib/api/`. To regenerate it, see
[API client](../api-client.md).

## Run the app

Start an emulator or connect a device, then run a flavor:

```sh
bun run dev    # flutter run --flavor dev
bun run prod   # flutter run --flavor prod, with BACKEND_BASE_URL=https://app.schuly.dev
```

Use `dev` for daily work and `prod` to check release behavior.

## Flavors

The `environment` flavor dimension is set in `productFlavors` in `android/app/build.gradle.kts`:

| Flavor | Application ID | Display name |
| --- | --- | --- |
| `dev` | `com.schuly.app.dev` (version name suffix `-DEV`) | **Schuly DEV** |
| `prod` | `com.schuly.app` | **Schuly** |

The IDs differ, so both builds install side by side on one device.

## Connect to a local backend

The `BACKEND_BASE_URL` define sets the backend URL at build time. Without it, the app uses
`http://localhost:5033`, so `bun run dev` expects a backend on that port. You can also point the app
at another server during onboarding.

To reach a backend on your machine from a device over USB, reverse the port:

```sh
bun run adb:reverse   # adb reverse tcp:5033 tcp:5033
```

To build for another address, such as a machine on your LAN, see
[Point a dev build at a custom backend](build-and-release.md#point-a-dev-build-at-a-custom-backend).

## Enable push notifications

The run and build scripts pass these environment variables as `--dart-define` values:
`FIREBASE_API_KEY`, `FIREBASE_APP_ID`, `FIREBASE_SENDER_ID`, and `FIREBASE_PROJECT_ID`. The repo holds
no `google-services.json` or `GoogleService-Info.plist`. If any value is missing, the app runs without
push notifications.

## Quality checks

```sh
bun run analyze   # flutter analyze
bun run test      # flutter test
bun run format    # dart format lib
```

`analysis_options.yaml` excludes the generated client in `lib/api/**` from `flutter analyze`.
