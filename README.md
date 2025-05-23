# nixos-config Documentation

This repository contains the NixOS system and user configuration for your setup, leveraging flakes, Home Manager, and modular Nix expressions.

## Getting Started & Customization

To use this NixOS configuration for your own system:

1. **Username and Hostname:**
   - Change all instances of `me` (user) and `nixos` (hostname) to your preferred username and hostname.
     - System username appears in `hosts/main/configuration.nix` and `home-manager/home.nix`.
     - Hostname is set in `hosts/main/configuration.nix`.

2. **Hardware Configuration:**
   - Copy your machine's generated `hardware-configuration.nix` (from `/etc/nixos/hardware-configuration.nix` after installation) into `NixosModules/hardware-configuration.nix`, replacing the existing file.

3. **Enabling Minecraft Module & Server:**
   - This setup includes a Minecraft server module.
   - To enable it, simply uncomment the relevant lines in:
     - `hosts/main/configuration.nix` for the server and
     - Any referenced module for Minecraft in `NixosModules/`.
   - Follow the comments in the config files—uncommenting the correct lines will activate the module/server.

4. **Other Customizations:**
   - Review other modules you want to enable (e.g., Hyprland) and uncomment their imports as needed.
   - Update any other paths or settings to suit your hardware and preferences.

**After making these changes, you can build and switch to your new configuration.**

---


## Repository Structure

- `.gitignore` – Standard file to ignore untracked files in Git.
- `README.md` – Placeholder readme; expand with project details as needed.
- `flake.nix` – Flake definition for your NixOS and Home Manager setup.
- `flake.lock` – Auto-generated lock file for pinning flake dependencies.
- `hosts/` – NixOS host configurations; main entry: `hosts/main/configuration.nix`.
- `home-manager/` – Home Manager user configuration; main entry: `home-manager/home.nix`.
- `NixosModules/` – Custom Nix modules (hardware, applications, etc.).
- `nonHomeManagerStuff/` – (Purpose not yet analyzed; document contents as needed.)

---

## File and Directory Details

### `flake.nix`

- **Purpose:** The main entrypoint for Nix flakes, defining system and user environments.
- **Key sections:**
  - `inputs`: Specifies flake dependencies (nixpkgs, Hyprland, Home Manager, ags).
  - `outputs`: Defines NixOS and Home Manager configurations.
    - `nixosConfigurations.nixos`: System configuration, points to `hosts/main/configuration.nix`.
    - `homeConfigurations."me"`: Home Manager user config, points to `home-manager/home.nix`.
  - **Customization:** Add or change modules/inputs here to extend system or user configuration.

### `hosts/main/configuration.nix`

- **Purpose:** Main NixOS system configuration for your host.
- **Key imports:**
  - `../../NixosModules/hardware-configuration.nix`: Hardware-specific config (auto-generated).
  - `../../NixosModules/apps.nix`: Centralized applications configuration.
  - Other modules (Hyprland, Minecraft) are referenced but commented out.
- **Configuration highlights:**
  - Bootloader: Configures GRUB for UEFI.
  - Hostname: Set to `"nixos"`.
  - Enables Nix flakes and experimental features.
  - Networking: Uses NetworkManager.
  - Locale/timezone: Set to `Asia/Kolkata`, with full locale customization.
  - X11 and GNOME Desktop: Enabled.
  - Keymaps: Dvorak layout for X11 and console.
  - Printing: CUPS enabled.
  - Audio: Pipewire enabled, disables PulseAudio.
  - User: Defines user `me` with zsh and important groups.
  - Additional service and firewall options are present but commented out.
  - `system.stateVersion`: Set for reproducible builds and upgrades.

### `home-manager/home.nix`

- **Purpose:** Home Manager configuration for user environment.
- **Key sections:**
  - User: `me` with home `/home/me`.
  - Imports several user-level configuration modules:
    - `Hyprland/hyprland.nix`, `git.nix`, `zsh.nix`, `kitty.nix`, `tmux.nix`, `ags.nix`, `starship.nix`, `symlinks.nix`
  - Fonts: Fontconfig enabled.
  - Packages: Installs a curated list of CLI and desktop tools (fzf, nerd-fonts, neovim, tmux, starship, etc.).
  - Session variables and paths: Customizes environment.
  - Enables Home Manager.
  - `home.stateVersion`: For consistent user environment state.

### `NixosModules/`

- **Purpose:** Contains modular Nix expressions for hardware, apps, and possibly other system customizations.
- **Main files referenced:**
  - `hardware-configuration.nix`: Hardware setup, typically auto-generated.
  - `apps.nix`: Central configuration for system-wide apps.
  - Other modules (Hyprland, Minecraft) referenced in configuration but may be included as needed.

### `nonHomeManagerStuff/`

- **Purpose:** (Not analyzed in detail; likely contains system modules/configs not managed by Home Manager.)
- **Action:** Document files and structure within as you expand usage.

---

## Customization Strategy

- **Add system-level packages/services:** Extend or add modules in `NixosModules/`, then import them in `hosts/main/configuration.nix`.
- **Add user-level configs/programs:** Add modules to `home-manager/`, then import in `home-manager/home.nix`.
- **Change system/user state version:** Update `system.stateVersion` and `home.stateVersion` as needed for upgrades.

---

## Extending Documentation

- For each module (e.g., `NixosModules/apps.nix`, `home-manager/git.nix`), create a section describing:
  - **Purpose**
  - **Main options and customizations**
  - **How to extend or override**

---

## TODO

- Document contents of every module in `NixosModules/` and `home-manager/`.
- Summarize any custom scripts or advanced configurations.
- Add examples for adding new hosts, users, or modules.

---

Also I recommend you to keep the dotfiles in your user's home directory because there are some absolute paths in this.

# Thanks

- @aylur's dotfiles for tmux/starship
- @end-4's dotfiles for fuzzel
