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

## Installation guide

Based on Naene's guide. Apply XOS to a stock Windows installation, ideally a fresh one. Don't run it over another optimization playbook or a modified ISO. You can apply a newer XOS release over an existing XOS installation.

### 1. Before you start

1. **Get the files.** Download [AME Wizard](https://ameliorated.io) and the latest `XOS V<version>.apbx` from the [releases page](https://github.com/imribiy/xos-playbook/releases/latest).
2. **Pick a supported Windows version.** XOS installs only on these builds:
   - Windows 10 22H2 (build 19045)
   - Windows 11 23H2 (22631), 25H2 (26200) and 26H2 (26300)

   Any other version, including older Windows 10 releases, Windows 11 24H2 and the device-only Windows 11 26H1, is refused by AME Wizard. Use the **Pro** edition if you can: on Home, Windows ignores the policy XOS uses to turn off automatic updates.
3. **Get a stock ISO.** Download Windows from Microsoft: [Windows 11](https://www.microsoft.com/software-download/windows11) or [Windows 10](https://www.microsoft.com/software-download/windows10). Microsoft only offers the current release. For an older build, or if the Microsoft download fails, these sites offer stock images:
   - [MASSgrave](https://massgrave.dev/genuine-installation-media)
   - [OSclick](https://os.click/en) (downloads can be slow)
   - [RGadguard](https://files.rg-adguard.net/version/83fb91c9-107c-bdda-1ffc-2952d753a472)
   - [UUP dump](https://uupdump.net/)
   - [BobPony](https://bobpony.com/downloads/)
   - [Internet Archive](https://archive.org/details/english_windows_collection) (scroll down and use the side panel to browse the contents)

   Whichever source you use, pick one of the supported builds above.
4. **Choose how to install Windows.**
   - From a USB drive made with [Ventoy](https://www.ventoy.net/en/download.html) (recommended) or [Rufus](https://rufus.ie/en/).
   - Without a USB drive, using [InstallWindowsWithoutUSB](https://github.com/imribiy/InstallWindowsWithoutUSB).

### 2. Install Windows

1. **Stay offline.** Disconnect the network cable and don't join Wi-Fi before the first boot. This avoids updates during setup and lets you make a local account. If you want updates during setup, stay connected, but you will need the next step to avoid a Microsoft account.
2. **Create a local account.** On Windows 11, when setup asks for a network or a Microsoft account, press `Shift + F10` and run `start ms-cxh:localonly`, then create a local account. On older Windows 11 builds where that does nothing, run `oobe\bypassnro` instead; the PC restarts and offers "I don't have internet". On Windows 10, choose "Offline account" (or "Domain join instead" on Pro).
3. **Turn off Smart App Control** (Windows 11): Windows Security > App & browser control > Smart App Control settings > Off. When it is on, AME Wizard can fail while loading the playbook.

### 3. Apply XOS

1. Uninstall any third-party antivirus; AME Wizard refuses to run while one is installed.
2. Open AME Wizard, drag `XOS V<version>.apbx` into it and follow its steps. It walks you through turning off Defender's protections, which it needs before it can apply anything.
3. Pick your options (Defender, UAC, Edge, wallpaper, printing and the optional removals), apply, and restart when it finishes. XOS Toolkit is installed with the playbook.

Video guide, applying the XOS playbook:

https://github.com/user-attachments/assets/db590f07-9ce6-4f55-963a-44e9f7b77b4f

### 4. After installation

1. **Connect and set the clock.** Connect to the internet, set your time zone, and use **Sync now** under Settings > Time & language > Date & time.
2. **Install runtimes and apps.** In XOS Toolkit, open **App Installer** and install everything under **Essential Runtimes**. If you removed Edge, install a browser from the same page.
3. **Choose an update policy.** XOS Toolkit's **Updates** page has four modes:
   - **Normal** turns Windows Update fully back on. Choose it if you use the Microsoft Store or play on FACEIT or ESEA.
   - **Security Focused** delays feature upgrades and previews.
   - **Disabled**, the XOS default, stops automatic updates; you update yourself from Settings.
   - **Hard Disabled** also blocks the update services and can break the Microsoft Store. It is unavailable while a Microsoft account is signed in.

   Driver updates through Windows Update are a separate switch under **Driver & Store Updates**.
4. **Install your graphics driver.**
   - **NVIDIA:** install the latest driver from NVIDIA and choose a custom installation, or strip it down with [NVCleanstall](https://www.techpowerup.com/nvcleanstall/) (run it as administrator). If you need ShadowPlay, tick ShadowPlay in NVCleanstall and accept its component dependencies. Then open XOS Toolkit's **Gaming** page and click **Apply XOS.nip** under NVIDIA Profile Inspector.
   - **AMD:** for RDNA2 (RX 6000) and older cards, [Radeon-ID drivers](https://rdn-id.com/) are a good choice. For newer cards, use AMD's latest driver, optionally trimmed with [Radeon Software Slimmer](https://github.com/GSDragoon/RadeonSoftwareSlimmer). Optionally, apply **Safe** under AMD Radeon GPU Tweaks on the **Gaming** page and restart. **Experimental** goes further and may not suit every system.

### Problems

Read the [FAQ](#faq) below, then search the [playbook issues](https://github.com/imribiy/xos-playbook/issues) and [Toolkit issues](https://github.com/imribiy/xos-toolkit/issues). The XOS Discord has more pinned answers in its [FAQ and playbook support channels](https://discord.com/channels/942355007271997450/1450907216575070402/1451790132498665613). If you report a problem, attach the diagnostic bundle from XOS Toolkit's **Troubleshooting** page (**Export Diagnostic Bundle**).

## FAQ

### Installation and setup

**Is there a guide for installing XOS and what to do afterwards?**
XOS is not meant for beginners. If you want to try anyway, follow the [installation guide](#installation-guide) above. These community guides help too:

- [Fernbacher's guide](https://forged-blog.vercel.app/#/post/how-to-install-a-custom-windows-iso)
- [Cyanide's video guide](https://www.youtube.com/watch?v=FbkBdWbCXx8). It shows ReviOS, but the first 20 minutes, a clean Windows installation from a stock image, are the same for XOS.

**Which tool should I use to write the Windows ISO to a USB drive?**
[Ventoy](https://www.ventoy.net/en/download.html) rather than Rufus. It is faster, and one USB drive can hold several ISO files plus your own data. Video guide, preparing a USB drive with Ventoy:

https://github.com/user-attachments/assets/ab9c1a1c-6c76-4b11-a40c-1acec17bbea5

**Can I install Windows without a USB drive?**
If you dual-boot, [InstallWindowsWithoutUSB](https://github.com/imribiy/InstallWindowsWithoutUSB) is the fastest and easiest way. Video guide:

https://github.com/user-attachments/assets/29b0c219-ed0b-4ef0-baef-7e72aed6499c

**Can I update XOS without reinstalling Windows?**
Yes. That is why XOS moved to the AME Wizard playbook format: run the newer playbook over your current installation.

**Where is the source?**
The playbook source is in [xos-playbook](https://github.com/imribiy/xos-playbook) and the Toolkit source in [xos-toolkit](https://github.com/imribiy/xos-toolkit), under the [license](#license) below.

### Drivers and broken features

**My internet, Bluetooth or second monitor doesn't work.**
XOS pauses Windows Update, so Windows doesn't install drivers for you. Either download the drivers yourself from your motherboard maker's site (or your laptop or prebuilt PC's model page), or open XOS Toolkit's **Updates** page and turn on Windows Update with **Driver & Store Updates**.

**A Windows feature is missing or broken.**
This is usually a disabled service. If the feature isn't on the unsupported list, open XOS Toolkit's **Troubleshooting** page, choose **Windows Defaults** under Restore Service Defaults, and restart your PC.

**An app's pop-ups, overlay or new-message alerts don't show.**
Most apps with overlays or pop-ups need **Notifications** or **Background Apps**, both on XOS Toolkit's **System** page; browsers in particular. Restart after changing either.

- **Notifications:** NVIDIA App, WhatsApp, Clipboard History, Xbox Game Bar, the Xbox app, and Windows' own reminder and timer apps.
- **Background Apps:** WhatsApp, Telegram, Signal Desktop, Microsoft Teams and Discord (for message pop-ups while it is closed).
- **Xbox Game Bar** also needs **Enable Game Bar Only** under **Game Bar & Full Screen Mode** on the **Gaming** page.

**An app won't start or shows an empty window.**
Many apps need the Microsoft Edge WebView2 Runtime, among them the Microsoft Store, Microsoft Teams, Outlook, WhatsApp, Discord and Spotify. Install **Edge WebView2 Runtime** from **Essential Runtimes** on XOS Toolkit's **App Installer** page, or get it from [Microsoft](https://developer.microsoft.com/en-us/microsoft-edge/webview2).

**A script or app complains that it is running as administrator.**
With User Account Control off, every program you start runs with administrator rights. Some PowerShell commands refuse that; Spicetify is a known case. Turn on **User Account Control (UAC)** on XOS Toolkit's **System** page and restart.

**My laptop's touchpad or another built-in device doesn't work.**
Click **Enable Serial Ports** on XOS Toolkit's **Peripherals** page and enable **Power Savings** on the **System** page, then restart your PC.

**The Microsoft Store doesn't work.**
Use AME Wizard 0.8.4 or newer to apply XOS, then choose **Normal** on XOS Toolkit's **Updates** page and restart your PC. On Windows 11 23H2 this can take several tries; the Store is more reliable on 25H2.

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

**Valorant, FACEIT, Fortnite or FiveM asks for VBS, HVCI or Core Isolation.**
Turn on **Virtualization-Based Security (VBS)** and then **Memory Integrity (HVCI)** on XOS Toolkit's **System** page, and restart your PC.

**FiveM doesn't start or doesn't work properly.**
FiveM needs some services that XOS turns off. Click **Enable FiveM Services** on XOS Toolkit's **Gaming** page and restart. If it still fails, also enable **GPU & Network Monitoring** and **System Usage & Diagnostics Reporting** on the **System** page.

## Branding

Wallpapers (`xos-modern-wallpaper.jpg`, `xos-legacy-wallpaper.jpg`, `xos-babyblue.jpg`, `xos_2026wallpaper.jpg`, `phone_wallpaper.jpg`) and the source artwork (`XOS.psd`) are in this repository. The XOS NVIDIA profile (`XOS.nip`) is part of [xos-toolkit](https://github.com/imribiy/xos-toolkit), which applies it from the Gaming page.

The XOS name and logo belong to the project. Please don't use them for other projects or modified builds.

## License

Copyright (c) 2026 XOS (imribiy). XOS is licensed under [CC BY-NC-ND 4.0](LICENSE): you may share it unchanged, with credit, for non-commercial purposes. You may not sell it, use it commercially, or distribute modified or rebranded versions.
