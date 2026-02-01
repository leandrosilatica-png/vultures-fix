# Vulture's Dodge Tracker

A Darktide mod that displays an on-screen indicator showing whether the Vulture's Dodge buff is active for Hive Scum (Outcast) class.

## Features

- Visual indicator that turns **green** when buff is active
- Visual indicator that turns **red** when buff is inactive
- Configurable position and font size
- Customizable indicator text
- Option to hide indicator when buff is inactive
- Performance-optimized buff checking

## Requirements

- [Darktide Mod Framework (DMF)](https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework) **← INSTALL THIS FIRST!**
- Warhammer 40,000: Darktide

**⚠️ Important:** You MUST install DMF before this mod will work. DMF creates the mods folder and enables modding.

## Installation

### ⚠️ First Time? Install DMF First!
If the mods folder doesn't exist, you need to [install Darktide Mod Framework](https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework) first.

### Quick Install (Drag & Drop)

**⚠️ IMPORTANT: Do NOT copy the entire repository folder!**

**The mods folder is in your game installation directory:**
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

**Drag these TWO items (and ONLY these two) into the mods folder:**
1. ✅ `vultures_dodge_tracker.mod` (the file)
2. ✅ `scripts` folder (the entire folder)

**❌ Don't copy:** README.md, documentation files, or the whole repository folder!

### Detailed Steps

1. Install the [Darktide Mod Framework](https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework) if not already installed
2. Find your Darktide installation:
   - Open Steam → Right-click Darktide → Properties → Installed Files → Browse
3. Look for or create the `mods` folder in your game directory
4. Copy **ONLY** these two items directly into the mods folder:
   - `vultures_dodge_tracker.mod` (file)
   - `scripts` (folder)
5. **Do NOT** copy the entire repository folder or any documentation files
6. Launch Darktide and enable the mod in the Mod Manager
7. Configure settings in-game through the mod options menu

**Common Error:** If you get "Mod file is invalid or missing", you copied the whole repository folder. Delete it and copy only the two items above. See [INSTALL.md](INSTALL.md) for troubleshooting.

For detailed installation help, see [INSTALL.md](INSTALL.md).

## Configuration

Access the mod settings through the Darktide Mod Framework options menu:

- **Enable Mod**: Toggle the entire mod on/off
- **Font Size**: Adjust the size of the indicator text (12-48, default: 24)
- **X Position**: Horizontal position on screen (0-1920, default: 960 - centered)
- **Y Position**: Vertical position on screen (0-1080, default: 100 - near top)
- **Show When Inactive**: Display the red indicator even when the buff is not active
- **Indicator Text**: Customize the text shown (default: "VULTURE'S DODGE")

## How It Works

The mod hooks into Darktide's UI system to:
1. Check for the Vulture's Dodge buff every 0.1 seconds
2. Display a colored text indicator on screen based on buff status
3. Green = Buff is active
4. Red = Buff is not active (if "Show When Inactive" is enabled)

The mod attempts to detect the Vulture's Dodge buff using multiple methods:
- Checking common buff name patterns
- Searching through active buffs for "vulture" or dodge-related buffs
- Gracefully handling cases where player data is unavailable

## Troubleshooting

- If the indicator doesn't appear, ensure:
  - The mod is enabled in the mod manager
  - You're playing as a Hive Scum (Outcast) class
  - The Vulture's Dodge trait is equipped on your weapon
  - "Show When Inactive" setting is enabled if you want to see it when buff is not active

- If the buff detection isn't working correctly:
  - The exact buff name may need to be updated based on game patches
  - Check the mod's code comments for potential buff name variations
  - See DEBUG_GUIDE.md for detailed troubleshooting steps

## Known Limitations & Assumptions

⚠️ **Important**: This mod was created without direct access to Darktide's game files or a testing environment. Some aspects are based on educated guesses about the Darktide Mod Framework API and buff system.

### What Might Need Adjustment:

1. **Buff Names** - The exact name of the Vulture's Dodge buff is assumed. It may be different in the actual game.
2. **UI Rendering** - The rendering method and parameters may need tweaking for your DMF version.
3. **Hook Points** - The update/draw hook locations are educated guesses.
4. **Buff API Methods** - The methods used to check for buffs may have different names.

### How to Fix Issues:

- **Enable Debug Mode**: Edit `vultures_dodge_tracker.lua` and set `DEBUG_MODE = true` at line 9
- **Read the Documentation**: See `ASSUMPTIONS.md` for all uncertain aspects and `DEBUG_GUIDE.md` for step-by-step troubleshooting
- **Find the Real Buff Name**: With debug mode enabled, dodge in combat and check the console for a list of all active buffs

The core logic is sound, but calibration may be needed for your specific setup. The mod is designed to be easily debuggable and adjustable.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

MIT License