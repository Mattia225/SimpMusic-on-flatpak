# SimpMusic Flatpak Manifest

This repository contains an automated Flatpak manifest for SimpMusic (version 1.3.0), specifically optimized for Wayland environments (such as Sway WM) and configured with extended data persistence parameters.

---

## Prerequisites and Dependencies

Before deploying the manifest, ensure that `git`, `flatpak`, and `flatpak-builder` are properly configured on your host operating system.

### Arch Linux / Manjaro
```bash
sudo pacman -S git flatpak flatpak-builder
```

### Ubuntu / Debian / Linux Mint
```bash
sudo apt update && sudo apt install -y git flatpak flatpak-builder
```

### Fedora / RHEL
```bash
sudo dnf install -y git flatpak flatpak-builder
```

### openSUSE
```bash
sudo zypper install -y git flatpak flatpak-builder
```

---

## Automated All-In-One Installation (Recommended)

You can download, clone, compile, and install this Flatpak locally with a single terminal instruction. Run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/Mattia225/SimpMusic-on-flatpak/main/install.sh | bash
```

---

## Manual Build Instructions

Alternatively, if you prefer to compile the application deployment sequence manually from within a local clone of the repository, execute:

```bash
flatpak-builder --user --install build-dir io.github.simpmusic.SimpMusic.yml --force-clean
```

Upon a successful build process, the runtime can be initialized via any desktop application runner or directly via the command-line interface:
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

---

## Credits and Acknowledgements

This repository provides exclusively the Flatpak packaging, configuration, and distribution manifest. The SimpMusic application, its source code, and assets are created, developed, and maintained by **maxrave-dev**.

The upstream project repository can be found at: [https://github.com/maxrave-dev/SimpMusic](https://github.com/maxrave-dev/SimpMusic)
