<img width="829" height="32" alt="second" src="https://github.com/user-attachments/assets/e84362fc-0b61-4bf1-a0fc-44bbd2be51c7" />
<img width="923" height="606" alt="First" src="https://github.com/user-attachments/assets/66dc1535-8d93-44f2-af5c-3e86824f60ff" />
# eugene-ids

Shows names and server IDs above nearby players.

Looks like: `Username [148]`

Uses native gamer tags. No NUI, no ESX/QBCore stuff.

Resmon sits at 0.00–0.01 ms (flashes between the two) — highly optimized.

## Needs

- ox_lib
- pma-voice

## server.cfg

```
ensure eugene-ids
```

## How to use

`/ids` toggles it on and off.

Default key is HOME. You can rebind it in FiveM settings under Key Bindings, look for `eugene_ids`.

You won't see your own tag. Grab a second player to test.

## config.lua

**distance** - how far you can see IDs in meters. Default 25.

**keybind** - default key. HOME.

**command** - chat command. `/ids`.

**displayMode** - `toggle` turns it on/off with one press. `hold` only shows it while you hold the key.

**showThroughWalls** - false hides tags behind walls. true shows them anyway.

**refreshInterval** - how often it updates in ms. 250 is fine.

**talkingHudColour** - color when someone is talking. 18 is green.

Color list if you wanna change it: [https://docs.fivem.net/docs/game-references/hud-colors/](https://docs.fivem.net/docs/game-references/hud-colors/)

## Heads up

Talk icon hooks into PMA voice through NetworkIsPlayerTalking.

If you change keybind in config it won't update for people who already bound it. They gotta rebind in FiveM settings.
