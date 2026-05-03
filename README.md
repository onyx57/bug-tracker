# Bug Tracker — CI/CD Fork

Forked from [james-willett/bug-tracker](https://github.com/james-willett/bug-tracker)
(a full-stack bug tracker: Go backend, Next.js frontend, Playwright tests).

## What I added on top of upstream

This fork is my playground for the CI/CD side of testing — the part most
QA portfolios skip. On top of the upstream app, I built:

- **Jenkins pipeline with a Dockerized Go-aware build agent** — full local
  Jenkins via `docker compose up` in `jenkins/`. Custom agent image with
  pinned Go tooling (go-junit-report, golangci-lint, goimports), JUnit
  report generation, and proper permission handling. See
  [`jenkins/FIX_SUMMARY.md`](jenkins/FIX_SUMMARY.md) for the gnarly
  permission/version issues I worked through.
- **Additional unit tests** in the frontend components and Go backend.
- **Docker fixes** to get the multi-service stack building cleanly.
- **GitHub Actions starter** (`.github/workflows/ci.yml`) — currently a
  scaffold I'll extend; Jenkins is doing the real work.

If you're looking at this for context on my QA work, the interesting
folders are `jenkins/`, `bugtracker-frontend/src/components/*.test.tsx`,
and `bugtracker-backend/internal/`.

## Running it locally

The fastest path:

```bash
docker compose up --build
```

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080

For granular setup (running each service or test type on its own), see the
[upstream README](https://github.com/james-willett/bug-tracker#readme) — it's
still accurate.

## Running the test suites

```bash
# Backend unit tests
cd bugtracker-backend && go test ./... -v

# Frontend unit tests
cd bugtracker-frontend && npm test

# API tests
cd tests-api && npm install && npm run test:local

# E2E tests (Playwright)
cd tests-e2e && npm install && npx playwright test

# Performance tests (K6)
cd tests-perf && k6 run script.js
```

## Local Jenkins

```bash
cd jenkins
docker compose up --build
```

Jenkins UI at http://localhost:9000.

## Credits

All of the application code (Go backend, Next.js frontend, base test suites)
is by [James Willett](https://github.com/james-willett). I forked it to layer
a CI/CD setup on top as a portfolio piece.
