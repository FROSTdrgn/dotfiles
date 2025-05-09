# -Syu = install latest package(s) and upgrade dependencies to latest
pacman := sudo pacman -S --needed
paru := paru -Syu --needed
pnpm := pnpm i -g
code-ext := code --install-extension

## Special Env Variables
PNPM_HOME := $(HOME)/Library/pnpm

defaultJob:
	echo "No default job."

install: status/core status/apps status/vscode-extensions

status/core: packages/core.yaml
	$(pacman) extra/yq
	$(pacman) $(shell yq -r .main[] packages/core.yaml)
	touch status/core

status/apps: status/core packages/apps.yaml
	$(pacman) $(shell yq -r .main[] packages/apps.yaml)
	$(paru)   $(shell yq -r .aur[]  packages/apps.yaml)
	touch status/apps

# status/nodejs-global: status/core packages/nodejs-global.yaml
# 	mkdir -p $(PNPM_HOME)
# 	pnpm config set -g global-dir "$(PNPM_HOME)"
# 	mkdir -p $(PNPM_HOME)/bin
# 	pnpm config set -g global-bin-dir "$(PNPM_HOME)/bin"
# 	export PATH="$(PNPM_HOME)/bin:$(PATH)"
# 	$(pnpm)   $(shell yq -r .main[] packages/nodejs-global.yaml)
# 	touch status/nodejs-global

status/vscode-extensions: status/core packages/vscode-extensions.yaml
	for EXT in $(shell yq -r .main[] packages/vscode-extensions.yaml); do $(code-ext) $$EXT; done
	touch status/vscode-extensions

link-config-paths:
	rm -rf $(HOME)/.config/fish
	ln -s $(HOME)/.dotfiles/config/fish $(HOME)/.config/fish
	mkdir -p $(HOME)/.dotfiles/config/fish/completions
	mkdir -p $(HOME)/.dotfiles/config/fish/conf.d
	mkdir -p $(HOME)/.dotfiles/config/fish/functions
	rm -rf $(HOME)/.config/ghostty
	ln -s $(HOME)/.dotfiles/config/ghostty $(HOME)/.config/ghostty
	rm -rf $(HOME)/.config/Code/User/settings.json
	ln -s $(HOME)/.dotfiles/config/vscode/User/settings.json $(HOME)/.config/Code/User/settings.json
	rm -rf $(HOME)/.config/hypr
	ln -s $(HOME)/.dotfiles/config/hypr $(HOME)/.config/hypr
