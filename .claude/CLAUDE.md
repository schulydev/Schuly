# Notes for Claude (and humans)

Minimal Flutter app. UI built with [Forui](https://forui.dev) (`FTheme` + `F*` widgets).

## Workflow rules (enforced)

- Never work on `main`. Create an issue (labeled) → branch `feature/<issue#>_PascalCase`
  or `fix/<issue#>_PascalCase` → PR (labeled) with `Closes #<issue>` → squash-merge +
  delete branch.
- Use CLI generators whenever one exists — `npx create-expo-app`, `npx expo install`,
  `gh issue create`, `gh pr create`, etc.
- No AI / Claude attribution in commits or PRs. Ever.
- No test plans in PRs. PR body is **Summary** + `Closes #<issue>` only.
- Commit subject: short imperative.
- PR labels: `bug`, `enhancement`, `feature`, `refactor`, `CI/CD`, `dependencies`, `documentation`.

## Tasks (preferred)

All common workflows are wrapped as `package.json` scripts so they're invoked the
same way from any shell. Uses bun as the task runner — it doesn't pull in a Node
toolchain, just dispatches.

```sh
bun run dev               # flutter run --flavor dev
bun run prod              # flutter run --flavor prod
bun run analyze
bun run test
bun run format
bun run build:apk:dev     # release APK, dev flavor
bun run build:apk:prod
bun run build:ios
bun run install:dev       # build + install over current adb target
bun run install:prod
bun run apigen            # see "Regenerate API client" below
bun run apigen:local      # same, but against http://localhost:5033
bun run icons             # dart run flutter_launcher_icons
bun run clean             # flutter clean && pub get
```

Flavors: `dev` (`com.schuly.app.dev`, "Schuly DEV") and `prod` (`com.schuly.app`, "Schuly").

## Regenerate API client

The client at `lib/api/` is generated from [SchulyBackend](https://github.com/schulydev/SchulyBackend)'s
OpenAPI spec. `apigen` chains three steps in `package.json`:

1. `bunx openapi-generator-cli` against the live OpenAPI 3.0 spec (`/openapi/v1.json`)
2. `apigen:patch` rewrites `lib/api/pubspec.yaml`'s SDK constraint (the generator resets
   it to `>=2.18.0 <4.0.0`, which breaks the build because of a part-file language-version
   mismatch). Implemented as a `bun -e` one-liner so it runs identically on any shell.
3. `apigen:build` — `dart pub get` + `dart run build_runner build` inside `lib/api/`

`openapi.json` is gitignored — always regenerate from the running backend.

`lib/api/**` is excluded from `flutter analyze` (see `analysis_options.yaml`).

## App icons

Source: `assets/app_icon.png`. Regenerate with `bun run icons`.
