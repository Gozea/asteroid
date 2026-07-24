# Asteroid

An asteroid clone with the löve framework in Lua

Physics and collisions are managed by löve, cpml is used for vector computations.

# How to play

This repository comes with an executable. You can clone this repo or even just download the game.exe file to run

### inputs

`left arrow/right arrow` : rotate the ship

`up arrow` : launch the ship

`space` : shoot 

You only have one bullet. Use it wisely. Once shot, your gun goes on cooldown for a few seconds before being able to shoot again.

# Development

### Installation

After cloning this repo, you will need cpml which you can clone in the same repo

```
git clone https://github.com/excessive/cpml
```

Of course, you will need the löve framework to run the game. Depending on your distribution, there are different ways to download löve, but don't worry, they are all user-friendly.

#### Windows, Mac, Ubuntu

Just go on the (https://love2d.org/#download)[official website]

#### Archlinux

Löve is available on the official Arch repo

```
sudo pacman -S love
```

Alternatively, you can also find it on the AUR

```
yay -S love
```

### Config file

You can modify all current global variables used in the game in the config.lua file. Feel free to play with the numbers.

### Run the game

Once you installed the löve framework, go in the root of the repo, then simply

```
love .
```

# Building your game

Building your game is basically zipping your project, rename its extension in .love instead of .zip, appending the .love to the official love.exe distribution to create a .exe, then packaging your .exe with the official DLL files distributed by löve

All the instructions are on the (https://love2d.org/wiki/Game_Distribution)[official website]

There are also instructions to build your game for other platforms like Android, or even for the web.

### Creating the .love file

For the following, I advise you to do everything in a build/ directory, but you are free to do as you want.

First you will need to create a .love by zipping your current project and giving it a .love extension

```
zip -9 -r build/game.love . -x build/
```

## Building for Windows

You will need to download the love zip executable to create your game executable.

There is already one in the build/ directory, but you can download the latest version on the (https://www.love2d.org/)[official website]. What you need is NOT the installer but the zipped love framework (32 or 64 bits depending of your own preferences).

Put it in the build/ directory, then unzip it.

Copy the love.exe file next to your game.love, then

```
(in the build/ directory if your files are there)
cat love.exe game.love > game.exe
```

You have the executable, now you just need to package it with the .dll files of love. Create a directory where you will put your game.exe, and all the .dll files in the unzipped love archive.

Congrats ! You can now share your game with most users !
