# dotfiles :open_file_folder:
My dotfiles, installable using [stow](http://www.gnu.org/software/stow/ "GNU Stow").

__Install all configs:__

`make install`

__Update all configs:__ 

`make update`

 __Uninstall all configs:__
 
`make uninstall`

__Install individual config:__

`stow <configname>`

__Uninstall individual config:__

`stow -D <configname>`

__Install packages:__

Install the configs packages with pacman: 
`pacman -S --needed - < packagestoinstall`
Make sure you have permission to run the /scripts/
