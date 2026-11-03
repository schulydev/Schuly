# Contributing

Use this page for the rules and checks specific to the mobile app. For issues, branches, pull
requests, and labels, follow the [shared workflow](/contribute/).

## Rules

- Run tasks with `bun run <script>` instead of the raw command, and don't use npm, npx, or node.
- Use a CLI generator when one exists, such as `gh issue create` or `gh pr create`.

## Checks before you open a pull request

```sh
bun run analyze
bun run test
bun run format
```

CI runs `flutter analyze` and `flutter test` on every pull request. If you change `android/**` or
`pubspec.yaml`, CI also builds a debug APK of the dev flavor.

See [Development setup](setup/development.md) for details.
