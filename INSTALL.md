# Installation Guide

## 📍 Where is the Mods Folder?

**The mods folder is in your Darktide game installation directory, NOT in AppData!**

### Default Steam Installation:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

### How to Find Your Mods Folder:

**Method 1: Through Steam (Easiest)**
1. Open Steam
2. Right-click "Warhammer 40,000: Darktide" in your library
3. Select "Properties" → "Installed Files" → "Browse"
4. This opens your game folder
5. Look for or create a `mods` folder here

**Method 2: Direct Navigation**
- Default location: `C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods`
- Custom Steam Library: `[Your Steam Library]\steamapps\common\Warhammer 40,000 DARKTIDE\mods`

### ⚠️ Mods Folder Doesn't Exist?

**If the `mods` folder doesn't exist in your game directory:**

1. **Install Darktide Mod Framework (DMF) First** ⭐ REQUIRED
   - Download from: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
   - Follow their installation instructions
   - DMF will create the mods folder automatically

2. **Or Create It Manually**
   - Navigate to your game installation folder (see above)
   - Create a new folder called `mods`
   - But you still need DMF for mods to work!

### Alternative: Microsoft Store Version
If you installed via Microsoft Store, the path is different:
```
C:\Users\[YourUsername]\AppData\Local\Packages\FatsharkAB.Warhammer40000Darktide_[random]\LocalCache\Local\Fatshark\Darktide\mods
```

---

## 🚀 QUICK INSTALL (Drag & Drop)

**You need to copy TWO things into your Darktide mods folder:**

1. **`vultures_dodge_tracker.mod`** (the file in the root)
2. **`scripts`** folder (the entire folder)

### Where is your mods folder?
Your Darktide game installation directory:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

**Quick way to find it:**
- Open Steam → Right-click Darktide → Properties → Installed Files → Browse
- Look for the `mods` folder there

### What to drag and drop:
```
From this repository:          →    To your mods folder:
┌─────────────────────────┐         ┌──────────────────────────────────────────┐
│ vultures_dodge_tracker.mod  →    │ [Game Install]\Warhammer 40,000 DARKTIDE\mods\
│ scripts/                    →    │ [Game Install]\Warhammer 40,000 DARKTIDE\mods\
└─────────────────────────┘         └──────────────────────────────────────────┘
```

That's it! Both items go directly into the mods folder in your game directory.

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

**The mods folder is in your game installation directory:**

Default Steam location:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

**To find it easily:**
1. Open Steam
2. Right-click "Warhammer 40,000: Darktide" in your library
3. Select "Properties" → "Installed Files" → "Browse"
4. Look for the `mods` folder in the game directory

**⚠️ Folder doesn't exist?** Create it, or see the troubleshooting section at the top of this document!

### 3. Install the Mod Files

**Copy BOTH of these to your mods directory:**

```
✅ vultures_dodge_tracker.mod          (drag this file)
✅ scripts/                            (drag this entire folder)
```

**DO NOT** copy the documentation files (README.md, INSTALL.md, etc.) - only the two items above.

After copying, your mods folder structure should look like:
```
[Game Install]\Warhammer 40,000 DARKTIDE\mods\
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
