# -Syu = install latest package(s) and upgrade dependencies to latest 
pacman := sudo pacman -Syu
npm := pnpm i -g
code-ext := code --install-extension

defaultJob:
	echo "No default job."

packages: core pacman-packages nodejs-packages

core:
	$(pacman) $(shell cat install/pacman-core)

pacman-packages: core
	$(pacman) $(shell cat install/pacman)

nodejs-packages: pacman-packages
	$(npm) $(shell cat packages/nodejs-global)

vscode-extensions: pacman-packages
	for EXT in $$(cat packages/vscode-extensions); do $(code-ext) $$EXT; done


