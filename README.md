# My personal dotfiles

This directory contains the dotfiles for my system

## Requirements 

Ensure you have the following installed on your system

### Git

```
apt install git
```
### Stow

```
apt install stow
```

## Installation 

First, checkout the .dotfiles repo in your $HOME directory using git

```
$ git@github.com:kh14762/.dotfiles.git
$ cd .dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
