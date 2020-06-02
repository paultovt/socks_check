# Bash script for testing socks servers on specific site.

If you want to parse much data from site, it's better to use socks servers. And it's much faster to check all socks before parsing and use only working ones.

I've done this script to satisfy my personal needs. So you can modify it if you want more functionality.

#### If you don't like this script, then make your own, goddammit!

## Requirements

#### Debian/Ubuntu:

    sudo apt install curl

#### Centos:

    sudo yum install curl

## Using

- get free socks and put 'em in socks.chk.
- `./socks_check.sh`.
- enter site.

#### Or add site as an argument: `./socks_check.sh <site>`.

#### good socks are written to _socks.lst_.

## Demo

![demo](https://raw.githubusercontent.com/paultovt/socks_check/master/demo.gif)
