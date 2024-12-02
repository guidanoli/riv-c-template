## Template for RIV game written in C

This template is aimed for developing games in C for the [RIV](https://rives.io/docs/category/riv) fantasy console.

## Install dependencies

This template was designed with RIVEMU and RIV SDK, both version 0.3.0.
See installation steps for [RIVEMU](https://rives.io/docs/riv/getting-started#installing) and [RIV SDK](https://rives.io/docs/riv/developing-cartridges#installing-the-riv-sdk).

## Edit name

Edit the value of the `NAME` variable in the `Makefile` to be the name of your game.

## Setup editor environment

You might prefer to develop your game using your preferred editor, in your host environment.
For a better developer experience, you might need the `riv.h` header file to be accessible by your LSP.
In order to copy this file from RIV OS to the `libriv` folder, please run `make setup`.
This template supports Neovim + `clangd` LSP out-of-the-box through the `.clangd` configuration file.

## Running

You can run the game with `make run`.

## Building

You can build the cartridge by running `make build`.
This will produce a `.sqfs` file in the `out` directory.

## Clean

You can clean the generated files with `make clean`

## Debug

You can debug the game with `gdb` by running `make debug`.
