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
- Install VS [build tools](https://visualstudio.microsoft.com/fr/visual-cpp-build-tools/)
- Install [RipGrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

Then copy go to ~/AppData/local/ and run the following commands:

```ps1
mkdir nvim && cd nvim
git clone git@github.com:Captainfl4me/nvim-config.git .
```

Install python support for nvim with

```ps1
pip3 install --user --upgrade neovim
```

Open NeoVim with ```nvim```, lazy will then install all require plugins.
Run ```:Copilot setup``` to connect to Github Copilot

# Known problems

