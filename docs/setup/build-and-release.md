# Build & release

Producing installable artifacts for the Schuly app. All commands are `package.json`
scripts run via bun — see [Development setup](development.md) for prerequisites and a
flavor overview.

## Release APKs

```sh
bun run build:apk:dev    # flutter build apk --flavor dev  --release
bun run build:apk:prod   # flutter build apk --flavor prod --release
```

| Flavor | Application ID | Display name |
| --- | --- | --- |
| `dev` | `com.schuly.app.dev` (version name suffix `-DEV`) | **Schuly DEV** |
| `prod` | `com.schuly.app` | **Schuly** |

The two flavors install side by side, so a dev build never overwrites a prod build
on the same device.

### Pointing a dev build at a custom backend

```sh
BACKEND_BASE_URL=https://example.test bun run build:apk:dev:url
```

`build:apk:dev:url` forwards `$BACKEND_BASE_URL` through `--dart-define=BACKEND_BASE_URL`.

## iOS build

```sh
bun run build:ios   # flutter build ios --flavor prod --no-codesign
```

Builds the `prod` flavor without code signing (sign separately in Xcode / your
signing pipeline).

## Install over adb

Build and install the release APK onto the currently connected adb target:

```sh
bun run install:dev    # build dev  APK, then flutter install --flavor dev
bun run install:prod   # build prod APK, then flutter install --flavor prod
```

When running against a locally hosted backend over USB, reverse the backend port
first so the device can reach `localhost:5033`:

```sh
bun run adb:reverse        # adb reverse tcp:5033 tcp:5033
bun run install:dev:usb    # adb:reverse + install:dev
```

To install a dev build pointed at a custom backend URL:

```sh
BACKEND_BASE_URL=https://example.test bun run install:dev:url
```

## App icons

The launcher icon is generated from `assets/app_icon.png` via `flutter_launcher_icons`
(Android + iOS, configured in `pubspec.yaml`). After changing the source image:

```sh
bun run icons   # dart run flutter_launcher_icons
```

## Related

- [Development setup](development.md) — SDK versions, running the app.
- [API client](../api-client.md) — regenerating the generated client before a build.
