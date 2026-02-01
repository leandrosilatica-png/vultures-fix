# Installation Guide

## ⚠️ MODS FOLDER DOESN'T EXIST?

**If `%AppData%\Fatshark\Darktide\mods` doesn't exist, you need to install the Darktide Mod Framework first!**

### Option 1: Install Darktide Mod Framework (DMF) First ⭐ RECOMMENDED
1. Download DMF from: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
2. Follow their installation instructions
3. Launch Darktide once with DMF installed - this creates the mods folder
4. Then come back here to install this mod

### Option 2: Create the Folder Manually
If DMF is installed but the folder still doesn't exist:
1. Press `Win + R`
2. Type `%AppData%\Fatshark\Darktide`
3. Press Enter
4. Create a new folder called `mods` (right-click → New → Folder)

### Alternative Mod Folder Locations

**Steam Version:**
```
%AppData%\Fatshark\Darktide\mods
```

**Microsoft Store Version:**
```
C:\Users\[YourUsername]\AppData\Local\Packages\FatsharkAB.Warhammer40000Darktide_[random]\LocalCache\Local\Fatshark\Darktide\mods
```

**Custom Install:**
If Darktide is installed elsewhere, look for:
```
[Darktide Install Path]\..\..\AppData\Fatshark\Darktide\mods
```

Still can't find it? Check where DMF installed - the mods folder should be in the same location.

---

## 🚀 QUICK INSTALL (Drag & Drop)

**You need to copy TWO things into your Darktide mods folder:**

1. **`vultures_dodge_tracker.mod`** (the file in the root)
2. **`scripts`** folder (the entire folder)

### Where to find your mods folder:
Press `Win + R`, type `%AppData%\Fatshark\Darktide\mods`, press Enter

**If this doesn't work, see troubleshooting section above ⬆️**

### What to drag and drop:
```
From this repository:          →    To your mods folder:
┌─────────────────────────┐         ┌──────────────────────────────┐
│ vultures_dodge_tracker.mod  →    │ %AppData%\Fatshark\Darktide\mods\
│ scripts/                    →    │ %AppData%\Fatshark\Darktide\mods\
└─────────────────────────┘         └──────────────────────────────┘
```

That's it! Both items go directly into the mods folder.

---

## Detailed Step-by-Step Installation

### ⚠️ Prerequisites (MUST DO FIRST!)
- ✅ Warhammer 40,000: Darktide installed
- ✅ **Darktide Mod Framework (DMF) installed and working** ← THIS IS REQUIRED!
  - Get it here: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
  - Launch the game once after installing DMF to create the mods folder
  - If you skip this, the mods folder won't exist!

### 1. Download the Mod
Download all files from this repository (use "Code" → "Download ZIP" on GitHub).

### 2. Locate Your Darktide Mods Directory
The default location is:
```
%AppData%\Fatshark\Darktide\mods
```

To get there:
1. Press `Win + R`
2. Type `%AppData%\Fatshark\Darktide\mods`
3. Press Enter

**⚠️ Folder doesn't exist?** See the troubleshooting section at the top of this document!

### 3. Install the Mod Files

**Copy BOTH of these to your mods directory:**

```
✅ vultures_dodge_tracker.mod          (drag this file)
✅ scripts/                            (drag this entire folder)
```

**DO NOT** copy the documentation files (README.md, INSTALL.md, etc.) - only the two items above.

After copying, your mods folder structure should look like:
```
%AppData%\Fatshark\Darktide\mods\
├── vultures_dodge_tracker.mod
├── scripts\
│   └── mods\
│       └── vultures_dodge_tracker\
│           ├── vultures_dodge_tracker.lua
│           ├── vultures_dodge_tracker_data.lua
│           └── vultures_dodge_tracker_localization.lua
└── [other mods...]
```

### 4. Enable the Mod
1. Launch Darktide
2. Open the Mod Manager (usually accessible from the main menu)
3. Find "Vulture's Dodge Tracker" in the mod list
4. Enable the mod
5. Configure settings as desired

## Configuration

Access settings through: **Mod Manager → Vulture's Dodge Tracker → Options**

### Available Settings:

- **Enable Mod**: Turn the mod on/off
- **Font Size**: 12-48 pixels (default: 24)
- **X Position**: 0-1920 pixels (default: 960, center)
- **Y Position**: 0-1080 pixels (default: 100, near top)
- **Show When Inactive**: Show red indicator when buff is not active
- **Indicator Text**: Customize the displayed text

## Usage

1. Equip a weapon with the Vulture's Dodge trait on your Hive Scum character
2. The indicator will appear on screen when you dodge (if buff is active)
3. **Green text** = Buff is currently active
4. **Red text** = Buff is not active (only shown if "Show When Inactive" is enabled)

## Troubleshooting

### Indicator Not Showing
- Ensure the mod is enabled in the Mod Manager
- Check that "Show When Inactive" is enabled if you want to see it all the time
- Verify you're playing as Hive Scum (Outcast) class
- Make sure you have a weapon with Vulture's Dodge trait equipped

### Buff Not Detected
- The mod checks for multiple buff name patterns
- If the buff name changes after a game update, it may need to be updated
- Try dodging in combat to trigger the buff

### Performance Issues
- The mod is optimized to check only every 0.1 seconds
- If you experience lag, try disabling other UI mods first
- Report any performance issues on the GitHub repository

## Uninstallation

1. Disable the mod in the Mod Manager
2. Delete the following files:
   - `vultures_dodge_tracker.mod`
   - `scripts/mods/vultures_dodge_tracker/` (entire folder)

## Support

For issues, questions, or contributions:
- Open an issue on the GitHub repository
- Check existing issues for similar problems
- Provide your game version and mod version when reporting bugs
