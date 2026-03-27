# Robocopy GUI - User Guide

A lightweight Windows GUI wrapper for robocopy. No installation required — runs natively via PowerShell and WPF.

---

## Getting Started

### Requirements

- Windows 10 or 11
- PowerShell 5.1+ (pre-installed on all modern Windows)

### Launching

Double-click **`RobocopyGUI.bat`** or run from a terminal:

```
C:\tools\RobocopyTools\RobocopyGUI.bat
```

---

## Interface Overview

The GUI is split into sections from top to bottom:

### 1. Source & Destination

| Control | Description |
|---------|-------------|
| **Source** | The folder you want to copy *from*. |
| **Destination** | The folder you want to copy *to*. |
| **Browse** | Opens a folder picker dialog. |
| **Swap button** (arrows) | Swaps source and destination paths. |

You can also **drag and drop** folders from Explorer directly into either field.

### 2. Preset & Threads

**Presets** auto-configure the option checkboxes for common scenarios:

| Preset | What it does |
|--------|-------------|
| **Copy** (default) | Copies all files and subdirectories to the destination. Existing destination files are kept. |
| **Mirror** | Makes the destination an exact copy of the source. Files in the destination that don't exist in the source are **deleted**. |
| **Move** | Copies files and subdirectories, then **deletes them from the source**. |
| **Sync (no delete)** | Copies newer/changed files without removing anything from the destination. |
| **Custom** | Leaves all checkboxes as-is for manual configuration. |

**Threads** controls how many parallel copy threads robocopy uses (default: 16). Higher values speed up transfers of many small files. Lower values are gentler on disk/network.

### 3. Options

Toggle individual robocopy flags:

| Option | Flag | Description |
|--------|------|-------------|
| Copy subdirectories | `/E` | Includes all subdirectories, even empty ones. |
| Delete dest extras | `/PURGE` | Removes files/folders in the destination that no longer exist in the source. |
| Move files | `/MOV` | Deletes files from the source after copying. |
| Move files+dirs | `/MOVE` | Deletes files *and* empty directories from the source after copying. |
| Restartable mode | `/Z` | Enables resumable transfers — useful for large files over unreliable networks. |
| Network compression | `/COMPRESS` | Compresses data during transfer (Windows 10 1903+ over SMB). |
| Show ETA | `/ETA` | Displays estimated time of arrival for each file. |
| No progress | `/NP` | Hides per-file percentage progress (cleaner log output). |
| Copy all attributes | `/COPYALL` | Copies data, attributes, timestamps, security, owner, and auditing info. |
| Copy with security | `/SEC` | Copies files with NTFS security (ACLs). |
| Copy dir timestamps | `/DCOPY:DAT` | Preserves directory timestamps. |
| Create dir tree only | `/CREATE` | Creates the folder structure without copying any file data (0-byte files). |

**Additional fields:**

| Field | Description |
|-------|-------------|
| **Retries** | Number of retry attempts on failed copies (default: 3). |
| **Wait** | Seconds to wait between retries (default: 5). |
| **Include** | File patterns to include, e.g. `*.jpg *.png`. Only matching files are copied. |
| **Exclude** | Patterns to exclude. File patterns like `*.tmp *.log` are excluded with `/XF`. Bare names like `node_modules` are excluded as directories with `/XD`. |
| **Extra args** | Any additional robocopy arguments not covered by the GUI. |

### 4. Command Preview

Shows the exact robocopy command that will be executed. Updates live as you change any option. Useful for learning robocopy syntax or verifying your configuration before running.

### 5. Output

Displays robocopy's real-time output as it runs. The status indicator in the top-right shows:

- **Running...** (yellow) — operation in progress
- **DRY RUN...** (yellow) — simulated run in progress
- **Completed (exit code: N)** (green) — finished successfully
- **Error (exit code: N)** (red) — finished with errors
- **Stopped** (red) — manually cancelled

### 6. Action Buttons

| Button | Description |
|--------|-------------|
| **Run Robocopy** | Starts the copy operation. |
| **Dry Run (/L)** | Simulates the operation without copying anything. Shows what *would* happen. **Use this first to verify.** |
| **Stop** | Kills a running robocopy process. |
| **Clear Log** | Clears the output panel. |

---

## Robocopy Exit Codes

Robocopy uses a bitmask for exit codes. Codes 0-7 are **not errors**:

| Code | Meaning |
|------|---------|
| 0 | No files were copied. Source and destination are already in sync. |
| 1 | Files were copied successfully. |
| 2 | Extra files or directories were detected in the destination. |
| 3 | Files were copied and extra files were detected. |
| 4 | Mismatched files or directories were found. |
| 5 | Files were copied and mismatches were found. |
| 7 | Files were copied, extras detected, and mismatches found. |
| 8+ | **Errors occurred.** Check the output log for details. |

---

## Common Workflows

### Back up a folder

1. Set **Source** to the folder you want to back up.
2. Set **Destination** to your backup location.
3. Leave the preset on **Copy**.
4. Click **Run Robocopy**.

### Create an exact mirror

1. Set source and destination.
2. Select the **Mirror** preset.
3. Click **Dry Run** first to review what will be deleted from the destination.
4. If the dry run looks correct, click **Run Robocopy**.

### Copy only certain file types

1. Set source and destination.
2. In the **Include** field, type the patterns: `*.jpg *.png *.mp4`
3. Click **Run Robocopy**.

### Exclude specific folders

1. Set source and destination.
2. In the **Exclude** field, type folder names: `node_modules .git __pycache__`
3. Click **Run Robocopy**.

### Transfer large files over a flaky network

1. Set source and destination.
2. Check **Restartable mode** (`/Z`).
3. Set **Retries** to `10` and **Wait** to `30`.
4. Click **Run Robocopy**.

---

## Tips

- **Always dry run first** when using Mirror or Move presets. These delete files.
- The GUI auto-loads the source path if you previously marked a folder using the Robocopy context menu tool.
- You can resize the window to see more output.
- The **Command Preview** is a great way to learn robocopy flags — adjust options and watch the command update.
