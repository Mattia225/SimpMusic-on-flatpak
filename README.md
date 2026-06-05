# SimpMusic Flatpak Manifest

This repository contains an automated Flatpak manifest for SimpMusic (version 1.3.0), specifically optimized for Wayland environments (such as Sway WM) and configured with extended data persistence parameters.

The build process is fully automated. The manifest pulls the official release directly from the upstream repository (maxrave-dev), verifies the source integrity using an explicit SHA256 checksum, and compiles the deployment sandbox without requiring manual file extraction.

---

## Prerequisites

Ensure that both `flatpak` and `flatpak-builder` are installed on the host system. 

For Arch Linux deployment:
```bash
sudo pacman -S flatpak flatpak-builder
```

---

## Build and Installation Instructions

To initiate the compilation and perform a local user space installation, execute the following command from the root of this repository:

```bash
flatpak-builder --user --install build-dir io.github.simpmusic.SimpMusic.yml --force-clean
```

Upon successful compilation, the application can be initialized via standard desktop application launchers (e.g., Rofi, Wofi) or explicitly via the command line interface:
```bash
flatpak run io.github.simpmusic.SimpMusic
```

---

## Technical Specifications and Fixes

* **Extended Data Persistence:** Explicitly handles the pre-creation and isolation of required application directories within the host user space (`~/.config/SimpMusic`, `~/.local/share`, and `~/SimpMusicData`). This mitigates state and playlist loss across runtime instances.
* **Wayland and Sway Compatibility:** Injects necessary environment variables (`_JAVA_AWT_WM_NONREPARENTING=1` and `SKIKO_RENDER_API=SOFTWARE`) to prevent blank frames, structural rendering failures, and graphical instability common in Compose Multiplatform frameworks under Wayland.
* **Desktop Environment Integration:** Generates a compliant `.desktop` entry and registers the official application asset within the system icon theme path.

---

## Recommended Window Manager Configuration (Sway WM)

To enforce proper floating behavior and set deterministic window geometry for the application interface within a tiling layout, append the following rule to the Sway configuration file (`~/.config/sway/config`):

```sway
# Enforce floating mode and centered geometry for SimpMusic
for_window [title="^SimpMusic1$"] floating enable, border normal, resize set width 1000, resize set height 700, move position center
```
