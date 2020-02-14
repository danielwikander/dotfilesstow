# dotfiles :open_file_folder:
My dotfiles, installable using [stow](http://www.gnu.org/software/stow/ "GNU Stow").

## Install all configs
`make install`

## Update all configs 
`make update`

## Uninstall all configs
`make uninstall`

### Install individual config
`stow <configname>`

### Uninstall individual config
`stow -D <configname>`

## Install packages
Install the configs packages with pacman: 
`pacman -S --needed - < packagestoinstall`
Make sure you have permission to run the /scripts/
