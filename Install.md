# Installing Cornerstone - Display Item

Written for server owners.

## Dependencies

- [ox_lib](https://github.com/overextended/ox_lib), started before this resource. The manifest loads it but does not list it in `dependencies` (see `Issues.md`).
- [ox_inventory](https://github.com/overextended/ox_inventory). Required, and listed in `dependencies`. The script checks the item with ox_inventory and loads the picture from its image folder.

No framework is used or needed.

## server.cfg

```cfg
ensure ox_lib
ensure ox_inventory
ensure cornerstone_displayitem
```

## Frameworks

None. The script does not call any framework.

## Inventories

ox_inventory only. Add the items you want to show to `ox_inventory/data/items.lua`. These are the nine the script knows about:

```lua
['meth_gathering_hint'] = { label = 'Meth Gathering Hint', weight = 10, stack = false },
['weed_gathering_hint'] = { label = 'Weed Gathering Hint', weight = 10, stack = false },
['coke_gathering_hint'] = { label = 'Coke Gathering Hint', weight = 10, stack = false },
['crack_gathering_hint'] = { label = 'Crack Gathering Hint', weight = 10, stack = false },
['weed_processing_hint'] = { label = 'Weed Processing Hint', weight = 10, stack = false },
['meth_processing_hint'] = { label = 'Meth Processing Hint', weight = 10, stack = false },
['coke_processing_hint'] = { label = 'Coke Processing Hint', weight = 10, stack = false },
['crack_processing_hint'] = { label = 'Crack Processing Hint', weight = 10, stack = false },
['white_widow_vip_menu'] = { label = 'White Widow VIP Menu', weight = 10, stack = false },
```

Put a PNG named after each item in `ox_inventory/web/images/`, for example `weed_gathering_hint.png`. That image is the one shown on screen. Only `.png` files are loaded by default (see `Config.InventoryImagePath`).

## Triggering the picture

Another resource shows a picture by firing one of these client events for the player: `TriggerClientEvent('vg_displayItem:weedGathering', source)` from a server script, or `TriggerEvent(...)` from a client script.

| event | item shown |
|---|---|
| `vg_displayItem:methGathering` | `meth_gathering_hint` |
| `vg_displayItem:weedGathering` | `weed_gathering_hint` |
| `vg_displayItem:cokeGathering` | `coke_gathering_hint` |
| `vg_displayItem:crackGathering` | `crack_gathering_hint` |
| `vg_displayItem:weedProcessing` | `weed_processing_hint` |
| `vg_displayItem:methProcessing` | `meth_processing_hint` |
| `vg_displayItem:cokeProcessing` | `coke_processing_hint` |
| `vg_displayItem:crackProcessing` | `crack_processing_hint` |
| `vg_displayItem:wwVipMenu` | `white_widow_vip_menu` |

The picture only shows when the server finds at least one of that item in the player's inventory. To show a different item, add a new event with its item name in `client/client.lua`.

## Configuration

All options are in `config/config.lua`, which stays editable in escrowed builds.

| option | default | what it does |
|---|---|---|
| `Config.displayTime` | `5` | seconds the picture stays on screen |
| `Config.InventoryImagePath` | `'nui://ox_inventory/web/images/%s.png'` | where the picture is loaded from; `%s` becomes the item name |
| `Config.UseOxLibLogging` | `true` | write a log entry through `lib.logger` when the server gets a request with no item name |

## Database

The script uses no database and creates no tables.

## Troubleshooting

- **Nothing appears:** check that the player carries the item, that the item name matches the table above, and that the PNG exists in `ox_inventory/web/images/`.
- **A broken picture appears:** the image file is missing or is not a `.png`. Change `Config.InventoryImagePath` if your images use another format.
- **The picture shows in the wrong place:** its position is set in `html/index.html` (`#item-image`, 200px from the top and right).
