# -Syu = install latest package(s) and upgrade dependencies to latest 
pacman := sudo pacman -S --needed
paru := paru -Syu --needed
pnpm := pnpm i -g
code-ext := code --install-extension

## Special Env Variables
PNPM_HOME := $(HOME)/Library/pnpm

defaultJob:
	echo "No default job."

install: status/core status/nodejs-packages status/apps

status/yq:
	$(pacman) extra/yq
	touch status/yq

status/core: yq packages/core.yaml
	$(pacman) $(shell yq -r .main[] packages/core.yaml)
	$(paru)   $(shell yq -r .aur[]  packages/core.yaml)
	touch status/core

status/apps: status/core
	$(pacman) $(shell yq -r .main[] packages/apps.yaml)
	$(paru)   $(shell yq -r .aur[]  packages/apps.yaml)
	touch status/apps

status/nodejs-packages: status/core
	mkdir -p $(PNPM_HOME)
	pnpm config set -g global-dir "$(PNPM_HOME)"
	mkdir -p $(PNPM_HOME)/bin
	pnpm config set -g global-bin-dir "$(PNPM_HOME)/bin"
	export PATH="$(PNPM_HOME)/bin:$(PATH)"
	echo $(PATH)
	$(pnpm)   $(shell yq -r .main[] packages/nodejs-global.yaml)
	touch status/nodejs-packages

status/vscode-extensions: status/pacman-packages
	for EXT in $$(cat packages/vscode-extensions); do $(code-ext) $$EXT; done
	touch status/vscode-extensions

link-config-paths:
	rm -rf $(HOME)/.config/Code/User/settings.json
	ln -s $(HOME)/.dotfiles/config/vscode/User/settings.json $(HOME)/.config/Code/User/settings.json
