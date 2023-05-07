# TEA 
<p align="center"><img width="100" src="https://raw.githubusercontent.com/alis-is/tea/main/__tea/assets/logo.svg" alt="TEA logo"></p>

<p align="center">
  <a href="https://raw.githubusercontent.com/alis-is/tea/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg?sanitize=true" alt="License"></a>
  <a href="https://discord.gg/WzqWTdD"><img src="https://img.shields.io/badge/chat-on%20discord-7289da.svg?sanitize=true" alt="Chat"></a>
  <a href="https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/alis-is/tea"><img src="https://img.shields.io/static/v1?label=Remote%20-%20Containers&message=Open&color=blue&logo=visualstudiocode" alt="Open in Remote - Containers"></a>
</p>

TEA is small, adaptable and **self contained** development environment for Tezos smart contracts.
- small - dependencies of this project alone are only ~1.2MB
- adaptable - all behavior is determined based on [app.hjson](https://github.com/alis-is/tea/blob/main/app.hjson), can be tracked down and adjusted through [ami.lua](https://github.com/alis-is/tea/blob/main/ami.lua)
- self contained - all features as included within - adjust them anyway you like or need

Start your new Tezos project faster than you prepare cup of tea. :)

## What does TEA provide?
- **ligo** compilation and tests (*SmartPy is not supported right now but with TEA adaptability you can make it to.*)
- **taquito** based module for dapp development
- e2e tests with taquito and sandbox

## Dependencies
- eli and ami - for `ami` commands - only ~1.2MB
- (optional) [podman](https://podman.io/getting-started/installation) or [docker](https://docs.docker.com/engine/install/)
- (optional) [nodejs](https://nodejs.org/en/download/) for dapp development
- (optional) [esy](https://esy.sh/) for access to ligo package management
- For development on windows use [wsl2](https://docs.microsoft.com/en-us/windows/wsl/install)

## Get Started

### With Dev Container

1. Make sure you have [docker](https://docs.docker.com/engine/install/)
To store repository within the container:
2. Open dev container directly by clicking the container badge or [here](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/alis-is/tea).
Or to store repository on local file system:
1. Clone repository
   - `git clone https://github.com/alis-is/tea.git`
2. Choose `Reopen in Container` when prompted by VS Code.

### Lightweight local setup
1. Clone repository 
   - `git clone https://github.com/alis-is/tea.git`
2. Get `eli` and `ami` (lua engines powering tea)
   - `wget -q https://raw.githubusercontent.com/alis-is/ami/master/install.sh -O /tmp/install.sh && sh /tmp/install.sh`
3. Install optional dependencies if needed
4. (optional) Edit `app.hjson` to adjust template behavior
   - **You should set id to name of your project.** (Build and deploy commands use this id to name files)
5. `ami setup` (Downloads ligo and runs `ligo install` if needed)
6. (optional) to develop js module run `npm install` from within the `web` directory
7. You are ready to code

**NOTE**: *TEA is fully self contained template. No behavior is specified in outside packages or set in stone. You can adjust it however you like. Just edit behavior within `__tea` directory.* ;)

## Guide

TEA is operated with commands through `ami`. All commands respects your configuration within `app.hjson` and are defined within `ami.lua`

TEA provides bellow commands (see `--help` of each for details):
- `ami sandbox start` start sandbox
- `ami sandbox stop` stop sandbox
- `ami compile` compiles contract, initial storage and views
- `ami deploy <deploy id>` deploys deploy or multiple based on id
- `ami test` runs ligo tests (stored in `tests`)
- `ami test-js` runs web module tests (stored in `web/tests`)
  - *requires started sandbox*
  - `ami test-js tests/admin.specs.js` runs `tests/admin.specs.js` tests

## Sample workflow

1. Code your contract
2. Run `ami compile` to compile contract and storage (See `--help` for options or selective compilation)
3. Run `ami test` to execute ligo tests
4. Run `ami deploy <deploy id>` to deploy contract to your deploys
   - `ami deploy sandbox` to deploy to sandbox with default `app.hjson`
5. Run `ami test-js` to test js-module

### Debug
You can examine all commands tea executes with log level debug:
   - `ami -ll=debug <command>` e.g. `ami -ll=debug test`

## Development with VS Code

1. Install [Lua extension from sumneko](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
2. Run `ami download-dev-metas` to download meta definitions for autocomplete
3. Adjust template as needed. Entire template codebase is scoped within `__tea` directory.

## Projects using this template

- [Starlords](https://starlords.xyz/)
- [BakeBuddy](https://www.bakebuddy.xyz/)
