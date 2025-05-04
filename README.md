## Install

### Required Setup

Install CatchyOS via USB in a configuration with hyprland.

When inside hyprland in the CachyOS Hello go to Apps and Tweaks then Install Gaming packages. If you closed the cachyos hello app just call it back by typing cachyos-hello in the terminal.

### Configuration

```
git clone https://github.com/FROSTdrgn/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
make link-config-paths
```

If you have things like VSCode open note that you'll need to at least force them to reload their windows for changes to take effect, since they'll have incorrect file handles in memory.
