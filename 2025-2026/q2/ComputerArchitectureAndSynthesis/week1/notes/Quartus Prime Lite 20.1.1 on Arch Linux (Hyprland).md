Complete Installation Guide with MAX10 Device Support 

This document explains how to install Intel Quartus Prime Lite 20.1.1 on Arch Linux, including MAX10 FPGA device support
The instructions are written for Wayland systems such as Hyprland and include all required compatibility libraries.

---

## 1. System Preparation

Update the system:

```bash
sudo pacman -Syu
```

Install required components:

```bash
sudo pacman -S xorg-xwayland xorg-xhost desktop-file-utils
```

Install tools needed for building AUR packages:

```bash
sudo pacman -S --needed base-devel git
```

---

## 2. Download Quartus Lite 20.1.1 (Linux)

Create a directory:

```bash
mkdir ~/quartus-installer
cd ~/quartus-installer
```

From Intel’s website download:

1. `Quartus-lite-20.1.1.720-linux.tar`
    
2. `MAX10-20.1.1.720.qdz`  
    This contains the MAX10 FPGA family used by the DE10-Lite.
    

Place both files inside `~/quartus-installer`.

Extract Quartus:

```bash
tar -xf Quartus-lite-20.1.1.720-linux.tar
```

---

## 3. Install Quartus (Text Mode)

Text mode is required because the graphical installer cannot run reliably on Wayland.

Run the installer:

```bash
cd ~/quartus-installer
./setup.sh --mode text --installdir ~/intelFPGA_lite/20.1
```

During the text-mode installation you will be asked several questions.

### Important: MAX10 Device Support

When the installer asks whether to include device support files:

```
Install device support for MAX10? (Y/N)
```

**Answer: Y**

If you skip this, Quartus will not recognize MAX-10 devices

After finishing, you will have:

```
~/intelFPGA_lite/20.1/quartus/
~/intelFPGA_lite/20.1/quartus/linux64/
~/intelFPGA_lite/20.1/quartus/adm/
```

Installing into your home directory avoids root permission trouble and Wayland display issues.

---

## 4. Install Required Compatibility Libraries

Quartus depends on older libraries not included in Arch.

### libcrypt.so.1

```bash
sudo pacman -S libxcrypt-compat
```

### libpng12.so.0

```bash
git clone https://aur.archlinux.org/libpng12.git
cd libpng12
makepkg -si
```

### ncurses 5 (only if Quartus reports missing libncurses.so.5 / libtinfo.so.5)

```bash
git clone https://aur.archlinux.org/ncurses5-compat-libs.git
cd ncurses5-compat-libs
makepkg -si
```

---

## 5. Verify Missing Libraries

Run:

```bash
ldd ~/intelFPGA_lite/20.1/quartus/linux64/quartus | grep "not found"
```

If no output appears, all libraries are correctly installed.

If a library is missing, install the corresponding AUR package.

---

## 6. Running Quartus Under Hyprland

Start Quartus with:

```bash
~/intelFPGA_lite/20.1/quartus/bin/quartus &
```

It will automatically run in XWayland.

### If you see display authorization errors:

```bash
xhost +local:
~/intelFPGA_lite/20.1/quartus/bin/quartus &
```

This grants local processes access to the XWayland display.

---

## 7. Optional: Create a “quartus” Command

Create a wrapper script:

```bash
sudo tee /usr/local/bin/quartus >/dev/null <<EOF
#!/bin/sh
exec /home/USERNAME/intelFPGA_lite/20.1/quartus/bin/quartus "\$@"
EOF
sudo chmod +x /usr/local/bin/quartus
```

Replace `USERNAME` with your actual user name.

Now Quartus can be launched with:

```bash
quartus
```

---

## 8. Desktop Entry for Rofi, Wofi and App Menus

Create a launcher:

```bash
nano ~/.local/share/applications/quartus.desktop
```

Insert:

```ini
[Desktop Entry]
Name=Intel Quartus Prime Lite 20.1
Comment=Intel FPGA design software with MAX10 support
Exec=/home/USERNAME/intelFPGA_lite/20.1/quartus/bin/quartus
Icon=/home/USERNAME/intelFPGA_lite/20.1/quartus/adm/quartus.png
Type=Application
Terminal=false
Categories=Development;IDE;Electronics;
StartupNotify=true
```

Replace `USERNAME`.

Apply permissions:

```bash
chmod +x ~/.local/share/applications/quartus.desktop
update-desktop-database ~/.local/share/applications
```

Rofi must be launched in drun mode:

```bash
rofi -show drun
```

Quartus will now appear.

---

## 9. USB-Blaster Support (for Programming MAX10 Boards)

Create the udev rule:

```bash
sudo tee /etc/udev/rules.d/51-usbblaster.rules >/dev/null <<EOF
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", MODE="0666"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger
```

Reconnect the DE10-Lite board.

Verify detection:

```bash
lsusb | grep 09fb
```

---

## 10. Uninstallation

Remove Quartus:

```bash
rm -rf ~/intelFPGA_lite
```

Remove launcher:

```bash
rm ~/.local/share/applications/quartus.desktop
```

Remove wrapper:

```bash
sudo rm /usr/local/bin/quartus
```
