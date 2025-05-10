## Install

### Required Setup

Install CatchyOS via USB in a configuration with GNOME desktop, systemd-boot with 5GiB boot partition in FAT32 and any other partitions (/, /home, etc) as btrfs.

> **IMPORTANT** it's highly recommended to you press META key (WinKey) > Software and install an application called "Resources". The reason why this is so important is that with out having it open you won't be able to tell if the system is slow or something is simply abusing the living hell out of your hardware.
>
> For example if you have your system installed on a regular HDD instead of a SSD expect the experience to be horendous if something abuses it for a few seconds. Unfortunately tools like `btop` and similar don't actually show this properly so you're left to wonder why everything is slow with CPU, Mem, GPU doing nothing.
>
> If your experience in the USB installer OS is significantly better, same reason, the OS there installs to RAM so it doesn't have this hidden HDD penalty.

> **Note on Package Types**: `extra` vs `aur` vs `catchyos-v3` is basically default packages, user maintained packages (aur = arch user repos) and cachy optimized packages. You always want the cachy optimized packages which are always the default option.

When inside GNOME in the CachyOS Hello
 - go to Apps and Tweaks
   - then Rank Mirrors = this optimizes downloads
   - then Install Gaming packages = this installs anything related to gaming

If you closed the cachyos hello app just call it back by typing cachyos-hello in the terminal.

### Configuration

```
git clone https://github.com/FROSTdrgn/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
make link-config-paths
```

If you have things like VSCode open note that you'll need to at least force them to reload their windows for changes to take effect, since they'll have incorrect file handles in memory.
