# Contributing

The contribution workflow is **enforced** — follow it exactly.

## Hard rules

- **Never work on `main`.** All changes go through an issue → branch → PR cycle.
- **No AI / Claude attribution, ever.** Commit messages, PR titles/bodies, and issue
  text must not mention AI, Claude, or any assistant, and must not include
  `Co-Authored-By` / "Generated with" trailers.
- **No test plans in PRs.** The PR body is **Summary + `Closes #<issue>` only**.
- **Prefer CLI generators** whenever one exists (`gh issue create`, `gh pr create`,
  etc.) over manual steps.

## Workflow

1. **Create a labeled issue** describing the change.

   ```sh
   gh issue create --title "..." --body "..." --label <label>
   ```

2. **Branch off `main`** using the issue number and a `PascalCase` slug:

   ```sh
   git switch -c feature/<issue#>_PascalCase   # new functionality
   git switch -c fix/<issue#>_PascalCase       # bug fix
   ```

3. **Commit** with a short imperative subject (e.g. `Add agenda filter`).

4. **Open a PR** (labeled) whose body is only a short summary and the closing
   reference:

   ```sh
   gh pr create --title "..." --label <label> --body "Summary of the change.

   Closes #<issue>"
   ```

5. **Squash-merge and delete the branch** once approved.

## Branch naming

| Kind | Pattern | Example |
| --- | --- | --- |
| Feature | `feature/<issue#>_PascalCase` | `feature/123_AgendaFilter` |
| Fix | `fix/<issue#>_PascalCase` | `fix/124_LoginCrash` |

## Labels

Apply the appropriate label to both the issue and the PR:

| Label | Use for |
| --- | --- |
| `bug` | Defect reports |
| `enhancement` | Improvements to existing behavior |
| `feature` | New functionality |
| `refactor` | Internal restructuring, no behavior change |
| `CI/CD` | Pipeline / workflow changes |
| `dependencies` | Dependency bumps |
| `documentation` | Docs-only changes |

## Before opening a PR

Run the quality checks (see [Development setup](setup/development.md)):

```sh
bun run analyze
bun run test
bun run format
```
