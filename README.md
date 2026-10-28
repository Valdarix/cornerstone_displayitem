# Cornerstone - Display Item

Shows the picture of an item on your screen for a few seconds, like holding up a note or a menu to read.

## What it is

Some items on the server are clues or handouts: gathering and processing hints for drugs, or a VIP menu. When a server script asks for it, the picture of that item appears on the right side of your screen for about 5 seconds, so you can read it without opening your inventory.

## How it plays

- You only see the picture if you carry that item. Without it, nothing happens.
- The picture appears for 5 seconds by default, then disappears by itself.
- Nine items are set up: the gathering and processing hints for meth, weed, coke and crack (`meth_gathering_hint`, `weed_gathering_hint`, `coke_gathering_hint`, `crack_gathering_hint`, `weed_processing_hint`, `meth_processing_hint`, `coke_processing_hint`, `crack_processing_hint`) and the White Widow VIP menu (`white_widow_vip_menu`).
- While the picture is up, your controls are locked for those few seconds.

## Commands and keybinds

There are no commands or keybinds. Other scripts trigger the picture, for example when you use a note or visit a place.
