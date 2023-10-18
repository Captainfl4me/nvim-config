# nvim-config

NeoVIM configuration

## Install neovim

For windows you can use winget to download to latest packaged version.

```ps
winget install -e --id Neovim.Neovim
```

## Configure vim

Now that NeoVim is installed now you will need to download the dependencies:

- Download [ctags](https://ctags.sourceforge.net/) and add it to Path.
- Download and install the [Monoki nerd font](https://www.nerdfonts.com/font-downloads) and change your terminal font with it.
- Install [Python](https://www.python.org/) and add it to Path. (Not from Microsoft Store !)

Then copy go to ~/AppData/local/ and run the following commands:

```ps1
git clone git@github.com:Captainfl4me/nvim-config.git
mv nvim-config nvim
```

Before running NeoVim we need to install the [Plugin Manager](https://github.com/junegunn/vim-plug)

```ps1
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

Install python support for nvim with

```ps1
pip3 install --user --upgrade neovim
```

Open NeoVim with the nvim command and run :PlugInstall and :CHADdeps
Run ```:Copilot setup``` to connect to Github Copilot

# Known problems

If MarkdownPreview is not working! Go to a Markdown file and manually run ```:call mkdp#util#install()```

