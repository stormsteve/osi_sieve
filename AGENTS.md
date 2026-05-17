# AGENTS.md

Global guidance for coding agents and contributors.

## Change Philosophy

* Keep changes narrow, focused, and consistent
* Match existing code style and architectural patterns
* Prefer extending existing code over introducing new abstractions
* Prefer existing project dependencies and utilities before adding new ones
* Avoid unrelated refactors or formatting churn
* Keep code clean and elegant, but prioritize performance in bottlenecks

## Testing & Verification

* Write tests as manual instructions
* Add or update manual test instructions for behavioral changes
* Run the smallest relevant test scope first

## Workflow

* Keep commits logically scoped and easy to review
* Ask for clarification before changing ambiguous behavior or public APIs

## Codebase Navigation

* Search with `rg` for fast codebase discovery
* Check for existing tests before adding helpers or abstractions

## BASIC Conventions

* Use line numbers in increments of 10
* Conserve memory by putting comments on unnumbered lines
* In performance-critical code, place the hottest paths at the lowest line numbers
* In performance-critical code, combine statements onto a line with `:`
* In performance-critical code, remove unnecessary spaces; indenting before line numbers is fine
* For disk-based systems, use integer variable arrays
* For disk-based systems, avoid integer scalars because they are slow
