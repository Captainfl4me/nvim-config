# nvim-config
NeoVIM configuration

## Install neovim
For windows you can use winget to download to latest packaged version.
```ps
winget install -e --id Neovim.Neovim
```

## Configure vim
Download and install the [Monoki nerd font](https://www.nerdfonts.com/font-downloads)
Install Python and add it to Path. (Not from Microsoft Store !)
In windows Terminal change font in settings.
Then copy the init.vim file in ~/AppData/local/nvim/

!! Before updating Plugin dependencies we need to install the [Plugin Manager](https://github.com/junegunn/vim-plug)
```ps1
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

Open vim with the nvim command and run :PlugInstall and :CHADdeps
Doawnload [ctags](https://ctags.sourceforge.net/) and add it to Path.
