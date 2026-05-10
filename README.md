# Broomarchy Dotfiles System

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles.

## Directory Structure

Configurations are organized in subdirectories within the `dotfiles` folder:
- dotfiles/user for configurations in `~` folder
- dotfiles/system for system configurations outside of `~` folder

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

## Windows VM

*Note*: Do not use the built-in Omarchy Windows installer (Super + Alt + Space -> Install -> Windows) unless you just need to quickly spin up a temporary Windows VM. It defaults to Windows 11 Pro without an easy way to use a custom ISO (like IOT Enterprise LTSC), and has no 3D GPU acceleration out of the box.

### Setup
we use a Windows 11 KVM/QEMU virtual machine managed via `virt-manager`. 

A good tutorial for setting up a Windows virtual machine including some settings that can improve performance can be found [here](https://github.com/winapps-org/winapps/blob/main/docs/libvirt.md)

The link above should include all necessry steps, but if you wish to set it up yourself, make sure you do the following for network access and seamless display scaling, the VM requires VirtIO drivers:
* In Virt-Manager, ensure the **NIC** (Network Interface) device model is explicitly set to `virtio`.
* Attach the `virtio-win.iso` as a secondary CD-ROM.
* Boot Windows and run `virtio-win-guest-tools.exe` from the CD drive to install all necessary host agents and network drivers.

### Adding more WinApps applications
Simply uninstall then reinstall WinApps with the installer:
`bash <(curl https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh)`

### Possible issues

#### Fixing Internet Access (Docker Conflict)

**Note**: the `dotfiles/system/install.sh` script will automatically symlink the file needed for this fix. and so will `dotfiles/install.sh`, so you may want to skip some of the steps described below.

If you are running Docker on your host machine, you may encounter a networking conflict. Docker's legacy firewall rules will actively block the virtual machine's bridge (`virbr0`), resulting in local network access but no internet.

To fix this on an Arch-based system, you need to ensure the modern firewall translation layer is installed, and then create a libvirt hook to bypass Docker's drop policy.

1. Install the modern translation layer (if prompted to replace `iptables`, confirm with `y`):
   ```bash
   sudo pacman -S iptables-nft
   ```
2. Create the hook directory: 
   ```bash
   sudo mkdir -p /etc/libvirt/hooks
   ```
3. Create the script file: 
   ```bash
   sudo nvim /etc/libvirt/hooks/network
   ```
4. Add the following script to explicitly whitelist the bridge traffic using the legacy backend:
   ```bash
   #!/bin/bash
   if [ "$2" == "started" ] || [ "$2" == "restarted" ]; then
       iptables-legacy -I FORWARD -i virbr0 -j ACCEPT
       iptables-legacy -I FORWARD -o virbr0 -j ACCEPT
   fi
   ```
5. Save the file and make it executable: 
   ```bash
   sudo chmod +x /etc/libvirt/hooks/network
   ```
