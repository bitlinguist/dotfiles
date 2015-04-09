# dotfiles
My dotfiles.

```bash
mkdir ~/.dot-install
cd ~/.dot-install
curl -LOk https://github.com/dewald-laubscher/dotfiles/archive/master.zip
unzip master.zip -d ./ 
cd dotfiles-master/
cp -vR ./.bashrc ~/
cp -vr ./.bash-settings ~/
```
