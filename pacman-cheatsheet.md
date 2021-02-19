---
title: Pacman Cheatsheet
link: /pacman-cheatsheet
description: 
status: draft
tags: [Linux, Arch, Arch Linux, pacman, cheat, sheet cheatsheet]
created: 2020-11-17
date: 2020-11-17 17:15:19 +0900
banner: https://source.unsplash.com/L8fVzpAMHkU
aliases:
    - /gollum/pacman-cheatsheet
    - /gollum/pacman-cheatsheet.md
---

# Pacman Cheatsheet

| Command | Params | Description |
|---|---|---|
|`pacman -Syu` | `<pkg>` | Sync package list and install `<pkg>`. |
|`pacman -S` | `<pkg>` | Install `<pkg>` only.  |
|`pacman -Rsc` | `<pkg>` | Uninstall `<pkg`>. |
|`pacman -Ss` | `<keyowrd>` | Search `<keyword>`. |
|`pacman -Syu` | N/A | Sync package list and update available packages. |


# Query(`Q`) Commands

| Command | Params | Description |
|---|---|---|
|`pacman -Q` | N/A | List all installed packages with version |
|`pacman -Qq` | N/A | List all installed packages without version |
|`pacman -Qe` | N/A | List explictly installed packages with version |
|`pacman -Qqe` | N/A | List explictly installed packages without version |
|`pacman -Ql` | `<pkg>` | List all files owned by a given `<pkg>` |
|`pacman -Qi` | `<pkg>` | Display information on a given `<pkg>` |
|`pacman -Qii` | `<pkg>` | Display information on a given `<pkg>` (more than single `i`)|
|`pacman -Qs` | `<keyword>` | Search each locally-installed package for names or descriptions that match regexp|
