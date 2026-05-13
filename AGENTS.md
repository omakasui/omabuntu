# Style

- Two spaces for indentation, no tabs
- Use bash 5 conditionals: use `[[ ]]` for string/file tests and `(( ))` for numeric tests
- In `[[ ]]`, don't quote variables, but do quote string literals when comparing values (e.g., `[[ $branch == "dev" ]]`)
- Prefer `(( ))` over numeric operators inside `[[ ]]` (e.g., `(( count < 50 ))`, not `[[ $count -lt 50 ]]`)
- For strings/paths with spaces, quote them instead of escaping spaces with `\ ` (e.g., `"$APP_DIR/Disk Usage.desktop"`, not `$APP_DIR/Disk\ Usage.desktop`)
- Shebangs must use `#!/bin/bash` consistently (never `#!/usr/bin/env bash`)
- Scripts under `install/` and `migrations/` may be sourced and intentionally omit shebangs

# Command Naming

All commands start with `omakub-`. Prefixes indicate purpose.

The authoritative command group list lives in `bin/omakub` in `GROUP_DESCRIPTIONS`. Keep `GROUP_DESCRIPTIONS` updated when adding a new command prefix.

Common prefixes include:

- `cmd-` - check if commands exist, misc utility commands
- `pkg-` - package management helpers
- `env-` - envs variable management
- `font-` - fonts management
- `refresh-` - copy default config to user's `~/.config/`
- `restart-` - restart a component
- `launch-` - open applications
- `install-` - install optional software
- `setup-` - interactive setup wizards
- `toggle-` - toggle features on/off
- `theme-` - theme management
- `update-` - update components

Other current prefixes include:

- `branch-`, `brightness-`, `channel-`, `config-`, `debug-`, `dev-`, `first-`, `font-`, `hook-`, `gnome-`, `menu-`, `migrate-`, `notification-`, `npm-`, `reinstall-`, `remove-`, `show-`, `state-`, `sudo-`, `system-`, `transcode-`, `tui-`, `version-`, `webapp-`

# Command Metadata

Commands in `bin/` can declare CLI metadata in comments near the top of the file. `bin/omakub` scans the first 80 lines, and tests expect command metadata to remain valid.

Supported metadata keys:

- `# omakub:summary=...` - short help text
- `# omakub:group=...` - command group when it differs from the filename-derived prefix
- `# omakub:name=...` - command name within the group
- `# omakub:args=...` - usage arguments
- `# omakub:examples=...` - examples separated with `|`
- `# omakub:alias=...` / `# omakub:aliases=...` - alternate routes
- `# omakub:hidden=true` - hide from default command listings
- `# omakub:requires-sudo=true` - mark commands that require sudo

Prefer explicit metadata for user-facing commands. Keep routes consistent with the filename unless there is a deliberate alias or compatibility route.

Example:

```bash
# omakub:summary=Take a screenshot
# omakub:group=capture
# omakub:args=[smart|region|windows|fullscreen] [slurp|copy]
# omakub:examples=omakub screenshot | omakub capture screenshot region
# omakub:aliases=omakub screenshot
```

# Install Scripts

Install entry points (`install.sh`, `boot.sh`) use `#!/bin/bash`. Many scripts under `install/` are sourced via `run_logged` and intentionally do not have shebangs.

Install stage files follow this pattern:

- `install/*/all.sh` lists scripts in execution order
- leaf scripts are sourced by `run_logged $OMAKUB_INSTALL/path/to/script.sh`
- avoid `exit` in sourced install scripts unless intentionally aborting the install
- use `$OMAKUB_INSTALL` and `$OMAKUB_PATH` instead of hard-coded Omakub paths
- keep hardware-specific logic under `install/config/hardware/`
- prefer helper commands for package and command checks where available

Raw `command -v`, `pacman`, and `pacman-key` are acceptable in bootstrap/preflight/package-helper contexts where the helper commands may not be available yet or where direct package-manager behavior is the point of the script.

# Helper Commands

Use these instead of raw shell commands:

- `omakub-cmd-missing` / `omakub-cmd-present` - check for commands
- `omakub-pkg-missing` / `omakub-pkg-present` - check for packages
- `omakub-pkg-add` - install packages with apt
- `omakub-notification-send` - send desktop notifications; do not call `notify-send` directly

Exceptions are allowed for bootstrap, preflight, migration, and package-helper scripts where the helper may not be available yet, where the helper itself is being implemented, or where direct package-manager behavior is required.

# Config Structure

- `config/` - default configs copied to `~/.config/`
- `default/themed/*.tpl` - templates with `{{ variable }}` placeholders for theme colors
- `themes/*/colors.toml` - theme color definitions (accent, background, foreground, color0-15)

# Refresh Pattern

To copy a default config to user config with automatic backup:

```bash
omakub-refresh-config fastfetch/config.jsonc
```

This copies `~/.local/share/omakub/config/fastfetch/config.jsonc` to `~/.config/fastfetch/config.jsonc`.

# Migrations

To create a new migration, run `omakub-dev-add-migration --no-edit`. This creates a migration file named after the unix timestamp of the last commit.

New migration format:

- No shebang line
- Start with an `echo` describing what the migration does
- Use `$OMAKUB_PATH` to reference the omakub directory
- Prefer helper commands such as `omakub-cmd-present`, `omakub-cmd-missing`, `omakub-pkg-present`, and `omakub-pkg-missing`

Some older migrations predate these rules. Do not copy older migrations that start with shebangs, omit the leading `echo`, or hard-code `~/.local/share/omakub`.

Migrations may use raw `pacman`, `command -v`, or direct config edits when needed for historical compatibility or one-off repair work.

Example:

```bash
echo "Migrating to add new themed config for MyApp"

if omakub-cmd-missing myapp; then
  echo "MyApp not found, skipping themed config migration"
  exit 0
fi
```
