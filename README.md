# Dotfiles 🚀

This repository contains my personal, automated, and modular configuration. It is designed for extreme portability and declarative configuration, with first-class support for **macOS** and a clear path for **WSL/Linux**.

## 🏗️ Structure

| Path | Purpose |
| :--- | :--- |
| `home/` | Files that are symlinked directly to `$HOME` (e.g., `.zshrc`, `.gitconfig`). |
| `config/shell/` | Modular shell logic: `path.zsh`, `env.zsh`, `aliases.zsh`, `functions.zsh`, `macos_aliases.zsh`. |
| `lib/utils.sh` | Shared helpers sourced by installers and scripts (`detect_os`, `info`, `warn`, `success`, etc.). |
| `Brewfile` | Declarative package list for macOS. |
| `os/` | OS-specific system adjustments (`setup-macos.sh`, `setup-wsl.sh`, `setup-linux.sh` placeholder). |
| `bin/` | Personal binaries and scripts added to `$PATH`. |
| `modules/` | Per-tool installers: `git`, `node`, `python`, `rclone`, `vscode`. |
| `scripts/` | Internal orchestration: `link-dotfiles`, `install-packages`. |
| `Dockerfile` | Local Ubuntu container for testing the installer without touching the host. |

## 🚀 Quick Install

To set up a new machine from scratch:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/anthuanvasquez/dotfiles/master/setup)"
```

## 🛠️ Local Execution

If you have already cloned the repository:

```bash
./install
```

## 🧩 Installation Flow

The `install` orchestrator always runs in this order:

1. **Detect OS** — macOS, WSL, or Linux. Fails on unknown OS.
2. **Create symlinks** — `home/` → `$HOME` (cross-platform).
3. **Install packages** — OS-aware package manager (macOS uses Homebrew/Brewfile).
4. **Apply OS-specific settings** — `os/setup-<os>.sh` for supported platforms.
5. **Run module installers** — every `modules/<tool>/install.sh` is discovered and executed.

## 🧪 Local Testing with Docker

Test the installer safely inside a container:

```bash
docker build -t dotfiles-test .
docker run --rm -it dotfiles-test
```

## 🖥️ OS Support

| OS | Status | Notes |
| :--- | :--- | :--- |
| macOS | ✅ Fully supported | Homebrew, macOS defaults, Xcode CLI tools. |
| WSL | 🚧 Planned | Symlinks, shell config, and modules work; package/OS setup pending. |
| Linux | 🚧 Planned | Symlinks, shell config, and modules work; package/OS setup pending. |

Cross-platform parts (symlinks, `config/shell/`, `bin/`, and most `modules/`) run everywhere. OS-specific package installation and system tweaks are applied only when supported.

## 🧩 Design Principles

1. **Portability**: Cross-platform shell config and binaries; OS-specific logic isolated.
2. **Modularity**: Clear separation between environment, aliases, functions, tools, and OS tweaks.
3. **Automation**: A single command recreates the entire environment.
4. **Declarative**: The repository is the source of truth for the machine's state.
5. **Safety**: Installers check for missing tools and skip gracefully; symlinks back up existing files.

## 📜 Personal Binaries (`bin/`)

The following scripts are automatically added to your `$PATH`:

| Binary | Description | Commands / Arguments |
| :--- | :--- | :--- |
| `dev` | Project orchestrator (Stripe/Shopify flow). | `up`, `down`, `db-reset`, `clean`, `test` |
| `docker-reset` | Deep clean of Docker containers, images, and volumes. | interactive `y/N` confirmation |
| `doctor` | Environment diagnostics for installed tools and runtimes. | *N/A* |
| `dot` | Quick access and management of dotfiles. | `cd`, `edit`, `reload`, `install` |
| `git-cleanup` | Maintain Git hygiene by removing merged branches. | `branches`, `nuke` |
| `git-sync` | Sync local branches with origin and prune stale data. | *N/A* |
| `setup-project` | AI-Ready project scaffolding. | `<project-name>` |
| `update` | Global machine update (Dotfiles, Homebrew, Node packages). | *N/A* |

---
Maintained by [Anthuan Vasquez](https://github.com/anthuanvasquez)
