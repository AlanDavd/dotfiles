#!/usr/bin/env bash

if [[ `uname` == "Linux"   ]]; then
  echo "Linux detected. Using Linux config..."
  echo "Installing zsh..."
  sudo apt install zsh
  echo "Changing shell to zsh"
  sudo chsh -s $(which zsh)
  # Adding homebrew to zprofile
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/alanrojaslopez/.zprofile
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  echo "Installing PyEnv"
  curl https://pyenv.run | bash
fi

echo "Installing Oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zInit"
sh -c "$(curl -fsSL https://git.io/zinit-install)"

echo "Installing Kitty Snazzy Theme"
curl -o ~/.config/kitty/snazzy.conf https://raw.githubusercontent.com/connorholyday/kitty-snazzy/master/snazzy.conf

echo "Removing existing dotfiles"
# remove files if they already exist
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.tmux ~/.tmux.conf ~/.config/nvim 2> /dev/null

echo "Creating symlinks"
# Neovim expects some folders already exist
mkdir -p ~/.config ~/.config/nvim ~/.config/nvim/lua ~/.config/nvim/plugged

echo "Installing Python 3"
# install python 3
pyenv install 3.9.5 #latest
pyenv global 3.9.5

# Symlinking files
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim

# Italics and true color profile for tmux
tic -x tmux.terminfo

echo "Installing brew"
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install tmux
brew install neovim
brew install fzf
brew install bat
brew install thefuck
brew install go
brew install llvm
brew install gcc
brew install gdb
brew install bazel
brew install cmake
brew install zsh-autosuggestions

if [[ `uname` == "Linux"   ]]; then
  echo "Linux detected. Using Linux config..."
  echo "Installing JetBrains Mono"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
  echo "Installing pyenv"
fi

if [[ `uname` == "Darwin"   ]]; then
  echo "Mac detected. Using Mac config..."
  brew install pyenv

  # disable key repeat
  defaults write -g ApplePressAndHoldEnabled -bool false

  brew tap homebrew/cask-fonts

  # casks only work in mac
  brew install --cask font-fira-code
  brew install --cask font-cascadia
  brew install --cask font-jetbrains-mono
  brew install --cask font-iosevka
  brew install --cask rectangle
  brew install luarocks
  brew install --cask notion
  brew install --cask brave-browser
  brew install --cask slack
  brew install --cask discord
  brew install --cask spotify
  brew install --cask flux
  brew install --cask private-internet-access
  brew install --cask zoom
  brew install --cask google-chrome

  brew install reattach-to-user-namespace
fi

# FZF shortcuts
$(brew --prefix)/opt/fzf/install

# install Vim-Plug - Neovim Plugin Manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Go setup
mkdir -p $HOME/go/{bin,src,pkg}

# Writting vim will launch nvim
alias vim="nvim"
