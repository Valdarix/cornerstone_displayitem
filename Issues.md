# Issues: Cornerstone - Display Item

Known bugs and deviations from the Cornerstone standard and the FiveM Dev Tool house rules. First-pass review, 2026-10-28. Line numbers are for the current tree.

## Bugs

- **The log line is wrong and fires in the wrong case.** `server/server.lua:8-9` logs "Player triggered event without the item in their inventory" when `item` is nil, which is a malformed request, not a missing item. A player who lacks the item (`server/server.lua:4`) is not logged at all. Fix: log in the missing-item case, and word the nil case as a bad request.
- **The server callback returns `nil` when the player lacks the item.** `server/server.lua:4-6` falls out of the `if` without a return. The client treats it as false, so nothing breaks, but the result should be explicit. Fix: add `return false` after line 6.
- **Debug `print` left in.** `client/client.lua:19` prints the callback result to the console on every use. Fix: remove it.
- **The player's controls are locked for the whole display.** `client/client.lua:10` calls `SetNuiFocus(true, false)` for a picture that needs no input, and the thread waits for `displayTime` at line 11. Fix: do not take focus at all.
- **Overlapping triggers cut each other short.** A second trigger during the wait starts its own `Wait`, so the first call releases focus and hides the picture (`client/client.lua:12-13`) while the second is still meant to be showing. Fix: keep a single timer that each trigger resets.
- **Focus is not released if the resource stops mid-display.** There is no `onResourceStop` handler, so `SetNuiFocus` stays on until the player reconnects. Fix: release focus in an `onResourceStop` handler.
- **Only `.png` images work.** `Config.InventoryImagePath` (`config/config.lua:4`) hardcodes the extension. Fix: allow the extension per item or fall back to other formats.

## Deviations from the standard

From the FiveM Dev Tool validator run.

- **`Citizen.Wait` (1 warning, `deprecated-pattern`).** `client/client.lua:11`. Call `Wait`.
- **`config-not-escrow-ignored` (2 warnings, one fixed).** The manifest now lists `config/config.lua` in `escrow_ignore`. The remaining warning is for the untracked root `config.lua`, an identical stray copy that the manifest does not load. Fix: delete the stray `config.lua`.
- **Items are hardcoded in code.** The nine event names and item names are fixed in `client/client.lua:25-68` instead of read from config, so adding an item means editing code. Fix: move the event-to-item list into `config/config.lua`.
- **Old `vg_` prefix on every event and the callback.** `client/client.lua:18` and `client/client.lua:25-65`, and `server/server.lua:2`, use `vg_displayItem:...`, from the former name of this resource. The house rules name events after the resource. Other resources fire these events, so renaming needs a matching change in them.
- **`ox_lib` is not in `dependencies`.** `fxmanifest.lua:15` loads `@ox_lib/init.lua` and the code uses `lib.callback` and `lib.logger`, but only `ox_inventory` is listed (`fxmanifest.lua:27-29`). Fix: add `'ox_lib'`.
- **Config is not split.** The house rules want `config/shared.lua`, `config/client.lua` and `config/server.lua`.
- **Inline `<style>` and `<script>` in `html/index.html`.** It works, but the house rules prefer separate files. Not checked in game on Chromium 144.
- **README was a stub** ("TODO: Write Documentation"). Replaced in this pass.
- **No `.sql` and no tables.** Nothing to create on start, so the database rule is met.

## Security

Checked against the FiveM Dev Tool security checklist.

- **The callback does not check the type of `item`.** `server/server.lua:3-4` passes whatever the client sends to `exports.ox_inventory:GetItemCount`. A table or number can raise an error in the export. The result only says whether the player holds the item, so nothing can be gained from it. Fix: `if type(item) ~= 'string' then return false end`.
- **No rate limit.** A client can call `vg_displayItem:server:displayItemImage` as fast as it likes; each call runs one inventory lookup. Low cost. Fix: a small per-player cooldown.
- **The trigger events are open to any client script.** `client/client.lua:25-68` are `RegisterNetEvent`s that the server or any client script can fire. The server still checks that the player has the item, so the worst case is showing a picture the player already holds.
