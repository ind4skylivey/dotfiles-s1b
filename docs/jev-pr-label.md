# Advisory Jev PR labels

Pull requests get **advisory** labels. This workflow never blocks merge.

| Label | Source |
|---|---|
| `jev:size-xs` `jev:size-s` `jev:size-m` `jev:size-l` | Deterministic file and line counts from the GitHub PR diff |
| `jev:risk-low` `jev:risk-medium` `jev:risk-high` | One TypeSafe System One Choice call (Jev) |

Jev only classifies a compact title + file list + truncated diff. It does not invent cyclomatic complexity.

## Add the secret

1. Repo **Settings → Secrets and variables → Actions**.
2. New repository secret named `TYPESAFE_API_KEY` (TypeSafe / Jev API key).
3. Do not commit the key. The workflow reads only `${{ secrets.TYPESAFE_API_KEY }}`.

If the secret is missing, the job warns, still applies a size label when it can, and **exits 0**.

## Smoke-test

1. Open a tiny PR (a few lines, one or two files) against `main`.
2. Wait for `jev-pr-label`.
3. Expect `jev:size-xs` or `jev:size-s`, plus a `jev:risk-*` label when the secret is set.
