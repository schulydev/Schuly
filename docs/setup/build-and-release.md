# Build and release

Use this page to build installable apps on your machine and to publish a release. Local commands are
`package.json` scripts. See [Development setup](development.md) for prerequisites and flavors.

## Build release APKs

```sh
bun run build:apk:dev    # flutter build apk --flavor dev --release
bun run build:apk:prod   # flutter build apk --flavor prod --release
```

The `prod` scripts set `BACKEND_BASE_URL=https://api.schuly.dev`. All build scripts pass the Firebase
values listed in [Development setup](development.md#enable-push-notifications).

Release builds use the signing key from `android/key.properties`. Without that file, they use the
debug key.

### Point a dev build at a custom backend

```sh
BACKEND_BASE_URL=https://example.test bun run build:apk:dev:url
```

`build:apk:dev:url` passes `$BACKEND_BASE_URL` through `--dart-define=BACKEND_BASE_URL`.

## Build for iOS

```sh
bun run build:ios   # flutter build ios --flavor prod --no-codesign
```

This builds the `prod` flavor without code signing. Sign it separately, in Xcode or your signing
pipeline.

## Install over adb

These scripts build a release APK and install it on the connected adb target:

```sh
bun run install:dev    # build the dev APK, then flutter install --flavor dev
bun run install:prod   # build the prod APK, then flutter install --flavor prod
```

To use a backend on your machine over USB, reverse the port so the device can reach `localhost:5033`:

```sh
bun run adb:reverse       # adb reverse tcp:5033 tcp:5033
bun run install:dev:usb   # adb:reverse, then install:dev
```

To install a dev build with a custom backend URL:

```sh
BACKEND_BASE_URL=https://example.test bun run install:dev:url
```

## Regenerate app icons

`flutter_launcher_icons` generates the Android and iOS launcher icons from `assets/app_icon.png`. The
settings are in `pubspec.yaml`. After you change the image, run:

```sh
bun run icons   # dart run flutter_launcher_icons
```

The release workflow regenerates the icons on every build.

## Publish a release

Release Drafter keeps a draft release up to date from merged pull requests. To release, publish the
draft. Publishing starts two workflows:

- **`build-and-release.yml`** builds the apps and attaches them to the release.
- **`sync-version-on-release.yml`** compares the tag, without its `v`, to `application.properties`. If
  they differ, it updates `application.properties` and the version in `pubspec.yaml`, keeping the build
  number, then squash-merges a `release-sync/<version>` pull request into `main`.

`version-bump.yml` is a manual alternative. You choose patch, minor, major, or a custom version. It
commits the new version to `pubspec.yaml`, pushes a `v<version>` tag, and creates the release.

### What the build workflow produces

| Asset | Built from |
| --- | --- |
| `schuly-<tag>.apk` | `flutter build apk --release --flavor prod` |
| `schuly-<tag>.aab` | `flutter build appbundle --release --flavor prod` |
| `schuly-<tag>.apk.sha256` | `sha256sum` of the APK. The in-app updater checks the download against it. |
| `schuly-<tag>.ipa` | `flutter build ios --release --no-codesign`, then an unsigned `xcodebuild` archive |

The workflow sets the build name to the tag and the build number to the run number. You can also start
it by hand with `workflow_dispatch`, but it then only keeps the files as workflow artifacts. It attaches
them to a release only when a published release starts it.

### Workflow configuration

| Name | Kind | Purpose |
| --- | --- | --- |
| `KEYSTORE_BASE64` | Secret | The Android release keystore. Without it, the workflow generates a new keystore for that run. |
| `KEYSTORE_PASSWORD`, `KEY_PASSWORD` | Secret | Passwords for the keystore and key. |
| `BACKEND_BASE_URL` | Variable | Backend URL compiled into the app. Defaults to `https://api.schuly.dev`. |
| `FIREBASE_API_KEY`, `FIREBASE_APP_ID`, `FIREBASE_SENDER_ID`, `FIREBASE_PROJECT_ID` | Variable | Firebase project for push notifications. |
