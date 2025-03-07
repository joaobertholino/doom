## Config files of Doom Emacs
![Initial buffer](https://i.imgur.com/ksddHF8.png)

## Prerequistes
- Emacs 27.1–30.1
- ![Doom Emacs](https://github.com/doomemacs/doomemacs/tree/master) latest version.

## Installing
Make a backup of your files and exclude original files.
```shell
cp -r ~/.config/doom/ ~/.config/doom-bk/
rm -rf ~/.config/doom
```
Make a clone this repository. 
```shell
git clone git@github.com:joaobertholino/doom.git ~/.config/
```
Run syncronize command and run Doom Emacs.
```shell
doom sync && doom run
```
