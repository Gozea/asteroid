# Asteroid

An asteroid clone with the löve framework in Lua

Physics and collisions are managed by löve, cpml is used for vector computations.

# How to play

This repository comes with an executable. You can clone this repo or even just download the game.exe file to run

### inputs

```left arrow/right arrow``` : rotate the ship
```up arrow``` : launch the ship
```space``` : shoot 

You only have one bullet. Use it wisely. Once shot, your gun goes on cooldown for a few seconds before being able to shoot again.

# Development

### Installation

After cloning this repo, you will need cpml which you can clone in the same repo

```git clone https://github.com/excessive/cpml```

Of course, you will need the löve framework to run the game. Depending on your distribution, there are different ways to download löve, but don't worry, they are all user-friendly.

#### Windows, Mac, Ubuntu

Just go on the (official website)[https://love2d.org/#download]

#### Archlinux

Löve is available on the official Arch repo

```sudo pacman -S love```

Alternatively, you can also find it on the AUR

```yay -S love```

### Config file

You can modify all current global variables used in the game in the config.lua file. Feel free to play with the numbers.

### Run the game
