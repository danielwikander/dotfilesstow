.DEFAULT_GOAL:=install

PACKAGES=$(sort $(dir $(wildcard */)))

.PHONY: install
install: installcfgs installpkgs

.PHONY: installcfgs
installcfgs:
	sudo pacman -S --needed stow 
	stow -t ~ $(PACKAGES)
	sudo chmod 777 ~/.config/scripts/*
	@echo " -> Installed all configs."

.PHONY: uninstall
uninstall:
	stow -Dt ~ $(PACKAGES)
	@echo " -> Uninstalled all configs."

.PHONY: update
update: pull install
	@echo " -> Updated configs."

.PHONY: pull
pull:
	git pull

.PHONY: installpkgs
installpkgs:
	sudo pacman -S --needed - < packages
	@echo " -> Installed all packages."
