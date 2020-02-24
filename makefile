.DEFAULT_GOAL:=install

CONFIGS=$(sort $(dir $(wildcard */)))
RED='\033[0;31m'
GREEN='\033[1;32m'
NOCOLOR='\033[0m'

.PHONY: install
install: installcfgs installpkgs

.PHONY: installcfgs
installcfgs:
	@sudo pacman -Sq --needed stow 
	@stow -t ~ $(CONFIGS)
	@sudo chmod 777 ~/.config/scripts/*
	@echo -e ${GREEN}' -> Installed all configs.'${NOCOLOR}

.PHONY: uninstall
uninstall:
	@stow -Dt ~ $(CONFIGS)
	@echo -e ${GREEN'}' -> Uninstalled all configs.'${NOCOLOR}

.PHONY: update
update: pull install

.PHONY: pull
pull:
	git pull

.PHONY: installpkgs
installpkgs:
	@sudo pacman -Sq --needed - < packages
	@echo -e ${GREEN}' -> Installed all packages.'${NOCOLOR}
