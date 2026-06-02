# 🚁 Saitek X-55 Rhino HOTAS Fix for Arma Reforger on Linux / Proton

Use a **Saitek X-55 Rhino** / **Mad Catz X-55 Rhino** stick and throttle for
helicopter controls in **Arma Reforger** on Linux through Steam/Proton.

Arma Reforger can incorrectly treat the Saitek X-55 Rhino as the built-in X56
Rhino preset. That preset does not match the X-55's two-device layout, and the
in-game binding UI may not let you fix the result cleanly.

This package works around that by exposing the Saitek X-55 Rhino HOTAS as a
temporary virtual Xbox 360-style gamepad.

## 🔍 The Problem

The Saitek X-55 Rhino is two devices:

- Saitek X-55 Rhino stick
- Saitek X-55 Rhino throttle

Arma Reforger may identify that setup as an X56 Rhino stick/throttle preset.
The X55 and X56 layouts are close enough to confuse the game, but different
enough that axes and bindings can be wrong. In practice, helicopter controls
can become difficult or impossible to repair from Reforger's settings screen.

## ✨ What This Does

The helper script:

- opens the real Saitek X-55 Rhino stick and throttle,
- grabs them so Reforger does not consume the broken native layout,
- creates one virtual `Microsoft X-Box 360 pad`,
- maps HOTAS axes onto Arma Reforger's gamepad helicopter controls,
- removes the virtual controller when the game exits.

## 🎮 Default Mapping

| Saitek X-55 Rhino input | Virtual gamepad input | Reforger helicopter role |
| --- | --- | --- |
| Stick X | Right stick X | Cyclic roll |
| Stick Y | Right stick Y | Cyclic pitch |
| Stick twist | Left stick X | Anti-torque / yaw |
| Split throttle average | Left stick Y | Collective |

Pitch is inverted by default based on local X-55/Reforger testing.

## 🚫 What This Does Not Do

- It does not change Arma Reforger game files.
- It does not permanently modify your controllers.
- It does not create a custom Reforger joystick preset.

## ✅ Tested Device

| Item | Value |
| --- | --- |
| Stick | Saitek X-55 Rhino / Mad Catz X-55 Rhino stick |
| Throttle | Saitek X-55 Rhino / Mad Catz X-55 Rhino throttle |
| Virtual output | `Microsoft X-Box 360 pad` |
| Game | Arma Reforger on Steam/Proton |

Default device paths:

```text
/dev/input/by-id/usb-Madcatz_Saitek_Pro_Flight_X-55_Rhino_Stick_G0013831-event-joystick
/dev/input/by-id/usb-Madcatz_Saitek_Pro_Flight_X-55_Rhino_Throttle_G0019162-event-joystick
```

People often search for `saitek x55`, `saitek x-55`, `x55 rhino`,
`Saitek X-55 Rhino HOTAS`, or `Mad Catz X-55 Rhino`; this is that device
family.

## 📦 Requirements

- Saitek X-55 Rhino stick and throttle
- Python 3
- `python3-evdev`
- Read access to both X-55 event devices
- Write access to `/dev/uinput`

On Debian/Ubuntu-like systems:

```bash
sudo apt install python3-evdev
```

If the script cannot open the devices or create the virtual gamepad, your user
may need udev permissions for the controllers and `/dev/uinput`.

## 🚀 Install

```bash
git clone https://github.com/datalorians/linux-proton-x55-armareforger.git
cd linux-proton-x55-armareforger
./scripts/install-x55-arma-reforger.sh
```

This installs:

```text
~/.local/bin/x55-arma-reforger-virtual-gamepad
~/.local/bin/x55-arma-reforger-stop-virtual-gamepad
```

## 🎮 Steam Launch Option

Use this as the Arma Reforger launch option in Steam:

```bash
bash -lc '$HOME/.local/bin/x55-arma-reforger-virtual-gamepad & cleanup(){ $HOME/.local/bin/x55-arma-reforger-stop-virtual-gamepad; }; trap cleanup EXIT; "$@"; rc=$?; cleanup; exit $rc' -- %command%
```

That starts the virtual gamepad, launches the game, and removes the virtual
gamepad when the game exits.

## ⚙️ Axis Inversion

The tested default is:

```text
pitch inverted: yes
collective inverted: yes
yaw inverted: no
```

If an axis is backwards, prefix the Steam launch option with one or more
environment variables:

```bash
X55_REFORGER_INVERT_PITCH=1
X55_REFORGER_INVERT_COLLECTIVE=0
X55_REFORGER_INVERT_YAW=1
```

Example:

```bash
X55_REFORGER_INVERT_YAW=1 bash -lc '$HOME/.local/bin/x55-arma-reforger-virtual-gamepad & cleanup(){ $HOME/.local/bin/x55-arma-reforger-stop-virtual-gamepad; }; trap cleanup EXIT; "$@"; rc=$?; cleanup; exit $rc' -- %command%
```

## 🧯 Troubleshooting

Start manually:

```bash
~/.local/bin/x55-arma-reforger-virtual-gamepad
```

Stop manually:

```bash
~/.local/bin/x55-arma-reforger-stop-virtual-gamepad
```

Check that the virtual controller exists:

```bash
rg -n -C 2 "Microsoft X-Box 360 pad" /proc/bus/input/devices
```

If Reforger still uses the broken native layout, make sure the helper can grab
both real Saitek X-55 Rhino devices. If grabbing fails, Reforger may see both
the real HOTAS and the virtual gamepad at the same time.

## 🤖 AI Disclosure

This package was developed with assistance from OpenAI's Codex/ChatGPT. The
scripts and documentation were reviewed and tested locally before publication,
but they are community-maintained and provided as-is.

AI disclosure is separate from licensing: the disclosure explains how the work
was produced, while the license explains what rights you have to use and modify
the code.

## 📄 License

Repository scripts and documentation are released under the [MIT License](LICENSE).

`python-evdev` is a separate project with its own license.
