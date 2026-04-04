# Broomarchy Dotfiles System

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles.

## Directory Structure

Configurations are organized in subdirectories within the `dotfiles` folder

## Prerequisites

- **GNU Stow**: Must be installed on your system.
- Please use the **built-in Omarchy installer** to install `stow`:
```bash
omarchy-pkg-add stow
```

## How to Install

To symlink the configuration files to your home directory:

```bash
cd dotfiles
./install.sh
```

The script will:
1.  Check for GNU Stow.
2.  Iterate through each directory inside dotfiles folder and run stow

**Note:** If GNU Stow reports a conflict (e.g., an existing file), you must manually move that file to a `.bak` extension and rerun the script.

## How to Add New Configs

To add a new configuration (e.g., `git`):

1.  **Create a new directory** inside `dotfiles/`
2.  **Move or create your configuration files** inside the new directory, mirroring the structure of your home directory:
    ```bash
    # If the file is ~/.gitconfig
    cp ~/.gitconfig dotfiles/git/.gitconfig
    ```
3.  **Run the install script** again. The script automatically detects all subdirectories in the `dotfiles` folder.

## Hyperland config files 
You can find a list of user-configurable hyperland files in ```.config/hypr/hyperland.conf```, it might be a good idea to start tracking those as they change.

## Virtual machines

*Note*: Do not use the built-in Omarchy Windows installer (Super + Alt + Space -> Install -> Windows). It defaults to Windows 11 Pro without an easy way to use a custom ISO (like IOT Enterprise LTSC), and has no 3D GPU acceleration out of the box.

Instead, use QEMU/KVM + Virt-Manager + libvirt (paired with WinApps). This provides a proper GUI to easily load custom ISOs, configure advanced hardware, and achieve seamless desktop integration.
