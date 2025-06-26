# monster-hunter-wilds-mods
Mods for Monster Hunter Wilds

It's a work in progress

# Installation

This required [REFramework]() to be added to your MHWS instance and properly working.

Download the repository as zip and extract to `/reframework/autorun` such as you have a `/reframework/autorun/monster-hunter-wilds-mods` subfolder

After that, the problem right now is that paths are weird. I can't quite figure it out. Lua is weird, really.

For the time being, create a `nerdontheinternet.lua` file with the following content in `/reframework/autorun`

Disable the mods you do not want by simply not requiring it in the list.


```lua

require('monster-hunter-wilds-mods/mods/nerd-99-camps')
require('monster-hunter-wilds-mods/mods/nerd-carry-more')
require('monster-hunter-wilds-mods/mods/nerd-disable-spread-ammo')
require('monster-hunter-wilds-mods/mods/nerd-facility-mod')
require('monster-hunter-wilds-mods/mods/nerd-ghillie-unlimited')
require('monster-hunter-wilds-mods/mods/nerd-resource-multiplier')

```

Note that you can change the folder `monster-hunter-wilds-mods/mods` to anything you like by moving the lua files in the `mods` folder and adjust the `require` as needed.