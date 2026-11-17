# XOS

XOS is a Windows optimization suite for gaming and privacy. It removes bloat, turns off telemetry and background noise, and tunes Windows for low latency, while keeping every change reversible from its companion app.

## Download

**[Get the latest XOS release](https://github.com/imribiy/xos-playbook/releases/latest)**: download `XOS V<version>.apbx` and open it with [AME Wizard](https://ameliorated.io). All builds, including developer betas, are on the [releases page](https://github.com/imribiy/xos-playbook/releases). The XOS Toolkit installer is also available on its own from [Toolkit releases](https://github.com/imribiy/xos-toolkit/releases).

Questions and bug reports go to GitHub issues: [playbook issues](https://github.com/imribiy/xos-playbook/issues) for installing XOS, [Toolkit issues](https://github.com/imribiy/xos-toolkit/issues) for the app. Please search the existing issues first; your question may already be answered.

## The project

| Repository | What it is |
|---|---|
| [xos-playbook](https://github.com/imribiy/xos-playbook) | The AME Wizard playbook that installs XOS, and the releases |
| [xos-toolkit](https://github.com/imribiy/xos-toolkit) | XOS Toolkit, the desktop app for applying and undoing XOS tweaks one at a time, with the XOS-CpuService CPU affinity companion |
| XOS (this repository) | Branding, wallpapers and general information |

Supported Windows versions: Windows 10 22H2 and Windows 11 23H2, 25H2 and 26H2.

## FAQ

### Installation and setup

**Is there a guide for installing XOS and what to do afterwards?**
XOS is not meant for beginners. If you want to try anyway, these community guides help:

- [Fernbacher's guide](https://forged-blog.vercel.app/#/post/how-to-install-a-custom-windows-iso)
- [Cyanide's video guide](https://www.youtube.com/watch?v=FbkBdWbCXx8). It shows ReviOS, but the first 20 minutes, a clean Windows installation from a stock image, are the same for XOS.

**Which tool should I use to write the Windows ISO to a USB drive?**
[Ventoy](https://www.ventoy.net/en/download.html) rather than Rufus. It is faster, and one USB drive can hold several ISO files plus your own data.

**Can I install Windows without a USB drive?**
If you dual-boot, [InstallWindowsWithoutUSB](https://github.com/imribiy/InstallWindowsWithoutUSB) is the fastest and easiest way.

**Can I update XOS without reinstalling Windows?**
Yes. That is why XOS moved to the AME Wizard playbook format: run the newer playbook over your current installation.

**Where is the source?**
The playbook source is in [xos-playbook](https://github.com/imribiy/xos-playbook) and the Toolkit source in [xos-toolkit](https://github.com/imribiy/xos-toolkit), under the [license](#license) below.

### Drivers and broken features

**My internet, Bluetooth or second monitor doesn't work.**
XOS pauses Windows Update, so Windows doesn't install drivers for you. Either download the drivers yourself from your motherboard maker's site (or your laptop or prebuilt PC's model page), or open XOS Toolkit's **Updates** page and turn on Windows Update with **Driver & Store Updates**.

**A Windows feature is missing or broken.**
This is usually a disabled service. If the feature isn't on the unsupported list, open XOS Toolkit's **Troubleshooting** page, choose **Windows Defaults** under Restore Service Defaults, and restart your PC.

### Performance and tweaking (what not to do)

**Can I add other tweak packs or .reg files?**
No. Tweak packs and random `.reg` files conflict with XOS's own changes, and systems running them get no support. Use the options in XOS Toolkit.

**Which Windows version is best?**
Choose Windows 11 if any of these apply:

- A Ryzen processor with more than one CCX (Ryzen 9, or the 1000, 2000 and 3000 series)
- An Intel processor with E-cores enabled
- You play modern AAA games
- Your mouse or keyboard polls faster than 1000 Hz

For anything else, test yourself or ask people with similar hardware.

**Should I run `sfc /scannow` or use System Restore?**
Never. Both are unreliable and are likely to break XOS's changes. If your system breaks, back up your files and reinstall Windows.

### Games and anti-cheat

**Can I play on FACEIT or ESEA?**
Yes, but both require the latest Windows security updates. Use a current Windows release (Windows 11 25H2 or newer) with every update installed.

**Valorant or Fortnite asks for VBS, HVCI or Core Isolation.**
Turn on **Virtualization-Based Security (VBS)** and then **Memory Integrity (HVCI)** on XOS Toolkit's **System** page, and restart your PC.

## Branding

Wallpapers (`xos-modern-wallpaper.jpg`, `xos-legacy-wallpaper.jpg`, `xos-babyblue.jpg`, `xos_2026wallpaper.jpg`, `phone_wallpaper.jpg`) and the source artwork (`XOS.psd`) are in this repository. The XOS NVIDIA profile (`XOS.nip`) is part of [xos-toolkit](https://github.com/imribiy/xos-toolkit), which applies it from the Gaming page.

The XOS name and logo belong to the project. Please don't use them for other projects or modified builds.

## License

Copyright (c) 2026 XOS (imribiy). XOS is licensed under [CC BY-NC-ND 4.0](LICENSE): you may share it unchanged, with credit, for non-commercial purposes. You may not sell it, use it commercially, or distribute modified or rebranded versions.
