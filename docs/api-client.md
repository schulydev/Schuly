# API client

Regenerate the Dart API client in `lib/api/` when the backend API changes. Don't edit it by hand.
[openapi-generator](https://openapi-generator.tech) generates it with the `dart-dio` generator from
the OpenAPI 3.0 document of [SchulyServer](https://github.com/schulydev/SchulyServer). The app uses
it as the local package `schuly_api`, through a `path:` reference in `pubspec.yaml`.

## Regenerate the client

Start the backend on `http://localhost:5033`, then run:

```sh
bun run apigen        # regenerate from http://localhost:5033/openapi/v1.json
bun run apigen:local  # same target, explicit local alias
```

`apigen` runs three steps:

1. **Generate:** runs `openapi-generator-cli generate -g dart-dio` against the live document and
   writes to `lib/api`, with `pubName=schuly_api` and `pubLibrary=schuly_api`.
2. **Patch (`apigen:patch`):** changes the SDK constraint in `lib/api/pubspec.yaml`. The generator
   resets it to `'>=2.18.0 <4.0.0'`, which breaks the build with a part-file language-version
   mismatch. The patch sets `^3.10.0`. It's a `bun -e` one-liner, so it works in any shell.
3. **Build (`apigen:build`):** runs `dart pub get` and
   `dart run build_runner build --delete-conflicting-outputs` in `lib/api` to produce the `.g.dart`
   serialization code.

## Good to know

- `openapi.json` is gitignored. Regenerate from the running backend instead of committing a copy.
- `analysis_options.yaml` excludes `lib/api/**` from `flutter analyze`, so generated code never
  triggers lint errors.
- If the `.g.dart` files go stale, run `bun run apigen` or only `bun run apigen:build`.
