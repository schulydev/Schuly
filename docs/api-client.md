# API client (`lib/api/`)

The Dart API client at `lib/api/` is **generated**, not hand-written. It is produced
by [openapi-generator](https://openapi-generator.tech) (`dart-dio` generator) from
[SchulyBackend](https://github.com/schulydev/SchulyBackend)'s OpenAPI 3.0 spec, served
at `/openapi/v1.json`. The app depends on it as a local package via a `path:` reference
in `pubspec.yaml` (`schuly_api`).

## Regenerating

The backend must be running and reachable at `http://localhost:5033`. Then:

```sh
bun run apigen        # regenerate from http://localhost:5033/openapi/v1.json
bun run apigen:local  # same target, explicit local alias
```

`apigen` chains three steps:

1. **Generate** - `openapi-generator-cli generate -g dart-dio` against the live spec
   (`http://localhost:5033/openapi/v1.json`), output into `lib/api`
   (`pubName=schuly_api`, `pubLibrary=schuly_api`).
2. **Patch** (`apigen:patch`) - rewrites `lib/api/pubspec.yaml`'s SDK constraint. The
   generator resets it to `'>=2.18.0 <4.0.0'`, which breaks the build due to a
   part-file language-version mismatch. The patch replaces it with `^3.10.0`.
   Implemented as a `bun -e` one-liner so it runs identically on any shell.
3. **Build** (`apigen:build`) - `cd lib/api && dart pub get && dart run build_runner
   build --delete-conflicting-outputs` to produce the `.g.dart` serialization code.

## Notes

- **`openapi.json` is gitignored** - always regenerate from the running backend rather
  than committing a local copy of the spec.
- `lib/api/**` is **excluded from `flutter analyze`** (see `analysis_options.yaml`), so
  generator output never trips lint checks.
- The generated `.g.dart` files are produced by `build_runner`; if they go stale,
  re-run `bun run apigen` (or just the `apigen:build` step) to refresh them.

## Related

- [Development setup](setup/development.md) - installing deps, running the app.
