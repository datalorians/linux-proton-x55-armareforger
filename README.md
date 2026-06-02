# X-55 HOTAS Fix for Arma Reforger on Proton

Helper scripts for using a Saitek/Mad Catz X-55 Rhino HOTAS with Arma Reforger
on Linux through Steam/Proton.

Arma Reforger can mis-detect an X-55 stick plus throttle as the built-in X56
Rhino stick/throttle preset. The X-55 and X56 layouts are not identical, and
Reforger's in-game binding UI may not let you repair the resulting helicopter
bindings cleanly.

This package avoids that broken preset path by grabbing the real X-55 stick and
throttle, then exposing one temporary virtual Xbox 360-style gamepad to the
game.

This repo is intentionally separate from the TrackIR package. It only handles
the X-55 Reforger joystick workaround.

## Requirements

- X-55 Rhino stick and throttle
- Python 3
- `python3-evdev`
- Read access to both X-55 event devices
- Write access to `/dev/uinput`

Default device paths:

```text
/dev/input/by-id/usb-Madcatz_Saitek_Pro_Flight_X-55_Rhino_Stick_G0013831-event-joystick
/dev/input/by-id/usb-Madcatz_Saitek_Pro_Flight_X-55_Rhino_Throttle_G0019162-event-joystick
```

## Install

```bash
git clone https://github.com/datalorians/linux-proton-x55-armareforger.git
cd linux-proton-x55-armareforger
./scripts/install-x55-arma-reforger.sh
```

## Steam Launch Option

Use this for Arma Reforger:

```bash
bash -lc '$HOME/.local/bin/x55-arma-reforger-virtual-gamepad & cleanup(){ $HOME/.local/bin/x55-arma-reforger-stop-virtual-gamepad; }; trap cleanup EXIT; "$@"; rc=$?; cleanup; exit $rc' -- %command%
```

The virtual gamepad is stopped when the game exits.

## Mapping

- X-55 stick X/Y: gamepad right stick X/Y for cyclic
- X-55 twist: gamepad left stick X for anti-torque/yaw
- X-55 split throttle average: gamepad left stick Y for collective

Pitch is inverted by default based on the tested X-55/Reforger behavior.

If an axis is backwards, prefix the launch option with one of these variables:

```bash
X55_REFORGER_INVERT_PITCH=1
X55_REFORGER_INVERT_COLLECTIVE=0
X55_REFORGER_INVERT_YAW=1
```

## Stop Manually

```bash
~/.local/bin/x55-arma-reforger-stop-virtual-gamepad
```

## License

MIT.
