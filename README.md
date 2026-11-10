<p align="center"><img src="docs/icon.png" width="96" alt="Color Tuner icon"></p>

<h1 align="center">Color Tuner</h1>

<p align="center"><b>English</b> · <a href="README.ru.md">Русский</a></p>

A small GTK4 app with sliders for your monitor's **black level, white level, gamma and RGB balance**: a "desktop color settings" panel for Linux on **GNOME + Wayland**, where `xgamma`, `redshift` and `nvidia-settings` color controls no longer work.

It also lets you **emulate limited RGB range (16–235)**, so the picture can match a Windows PC whose GPU outputs limited range over HDMI, even when your Linux driver can't switch the range (for example NVIDIA on Wayland: *"Ignoring unsupported RGB Range"*).

## How it works

Wayland gives apps no way to change display gamma directly. But GNOME loads the **calibration curve (`vcgt`)** of the monitor's default ICC profile into the graphics card. Color Tuner:

1. takes the ICC profile GNOME generated from your monitor's EDID (`~/.local/share/icc/edid-*.icc`);
2. builds a copy with a calibration curve made from the slider values;
3. registers it in **colord** and makes it the monitor's default profile.

Changes apply about 0.3 s after you move a slider. Nothing runs in the background: the profile stays on the monitor after you close the app and after a reboot.

## Features

- Black level and white level (including **Limited 16–235** and **Full 0–255** presets)
- Gamma
- Red / green / blue gain (white balance)
- A gray-scale strip for checking shadow and highlight detail
- Monitor selection for multi-monitor setups
- One button turns the correction off (removes the profile)
- English and Russian interface (picked automatically from the system language)

Saturation ("digital vibrance") is **not** possible: a calibration curve can only change each channel's brightness.

## Requirements

- GNOME on Wayland or X11 (colord-based color management)
- Python 3.10+, PyGObject, GTK 4
- `colord`

```bash
# Ubuntu / Debian
sudo apt install python3-gi gir1.2-gtk-4.0 colord
# Fedora
sudo dnf install python3-gobject gtk4 colord
# Arch
sudo pacman -S python-gobject gtk4 colord
```

## Install

```bash
git clone https://github.com/MrGipso/color-tuner.git
cd color-tuner
./install.sh
```

It installs into `~/.local` for the current user, no `sudo` needed. Then open **Color Tuner** from the app menu.

To uninstall, first press **"Turn correction off"** in the app, then run:

```bash
./uninstall.sh
```

## Usage tips

- If the gray strip's darkest steps (0–24) merge into one, lower **Black level** or raise **Gamma**. If the brightest steps (235–255) merge, raise **White level**.
- To match a Windows PC set to *Limited* dynamic range in the NVIDIA Control Panel, press **Limited (16–235)**. A better fix is usually setting Windows to *Full*, then using **Full (0–255)** here.
- The app needs the EDID profile that GNOME creates. If it reports that it's missing, open **Settings → Color** once.

## Files

| What | Where |
| --- | --- |
| Program | `~/.local/bin/color-tuner` |
| Generated profiles | `~/.local/share/icc/color-tuner-*.icc` (old ones are deleted automatically) |
| Settings | `~/.config/color-tuner.json` |

## Troubleshooting

- **Nothing changes on screen.** Check that the profile is active: `colormgr get-devices-by-kind display`. The `color-tuner-…` profile must come first. Some drivers or compositors ignore `vcgt` curves. Night Light uses the same gamma ramp, so if Night Light works, Color Tuner should too.
- **HDR is on.** GNOME ignores ICC profiles in HDR mode. Turn HDR off.

## License

[MIT](LICENSE)
