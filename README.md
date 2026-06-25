# codex-web

> **迁移说明**: 此项目已从临时目录迁移至此位置。原目录已删除，仅保留压缩备份。
> 详情请查看 [MIGRATION.md](MIGRATION.md)

A web interface for Codex Desktop, built with Vite, React, and Fastify.

## Features

-   Full-featured web UI for Codex Desktop
-   Real‑time collaboration via WebSockets
-   File‑system access (with user consent)
-   Plugin support
-   Self‑hostable – run it on your own infrastructure

## Quick Start

See [QUICK_START.md](QUICK_START.md) for detailed instructions.

```bash
# Clone the repository
git clone https://github.com/0xcaff/codex-web.git
cd codex-web

# Install dependencies
npm install

# Build the project
npm run build

# Start the server
npm run launch:unpacked:server
```

## Architecture

The project is split into two main parts:

-   **`src/browser/`** – the React‑based frontend, built with Vite
-   **`src/server/`** – a Fastify server that proxies requests to the Codex Desktop
    app‑server and serves the frontend

For a deeper dive, read [ARCHITECTURE.md](ARCHITECTURE.md).

## Local Fork Maintenance

This deployment is maintained as a local fork for a self-hosted Codex setup.
The deployed `main` branch is kept stable, while changes are developed and
verified on feature branches before being merged.

Repository roles:

- `origin` points to the private/local fork when one is configured.
- `upstream` points to `https://github.com/0xcaff/codex-web`.
- `main` is the version deployed to the server.
- feature branches contain local adaptations and are merged only after build
  and browser regression testing.

Local changes should be implemented as reproducible files in `patches/` or as
source changes in `src/`. Generated files under `scratch/` are build artifacts
and must not be treated as the source of truth.

The model selector follows Codex rather than maintaining a separate frontend
catalog:

- models come from the Codex app-server `model/list` response;
- provider selection comes from Codex configuration and thread settings;
- reasoning levels come from each model's `supportedReasoningEfforts` and
  `defaultReasoningEffort`;
- the frontend must not hard-code Sub2API or Qianfan model names.

Upstream updates are reviewed on a temporary integration branch. Rebuild the
downloaded Codex Desktop frontend, reapply local patches, and run browser tests
covering model selection, thread creation, message sending, approvals, skills,
and automations before merging into `main`.

## Why?

i built this because i wanted to use codex on my phone and tablet. i also
wanted to be able to use codex on a computer that wasn't my main computer.
codex desktop is great but it's tied to a single device.

there are a few other ways to use codex on multiple devices:

* the official openai chatgpt web interface. this works but it's not codex.
  codex has a different feature set and a different interaction model. i
  prefer codex.
* the native codex remote feature (behind a feature flag) is great for
  connecting to remote codex hosts over ssh to manage long running tasks but
  this only works if you have codex desktop on your client device. this means it
  doesn't work on mobile.
* upcoming first party mobile app from openai. `codex-web` exists and works
  today. i can't wait for the mobile app but judging by the other openai mobile
  apps, i'm a little bit skeptical about the quality of the mobile experience.
  time will tell.
