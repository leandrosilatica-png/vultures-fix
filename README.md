# Vulture's Dodge Tracker

A Darktide mod that displays an on-screen indicator showing whether the Vulture's Dodge buff is active for Hive Scum (Outcast) class, with an **experimental automatic shot-blocking feature**.

## Features

### Visual Indicator
- Visual indicator that turns **green** when buff is active
- Visual indicator that turns **red** when buff is inactive
- Configurable position and font size

### Automatic Shot-Blocking (EXPERIMENTAL)
When **all** of these conditions are met, the mod will block **ONE** shot from firing:
1. Vulture's Dodge buff is currently active
2. The last shot was a critical hit
3. The buff is within a configurable threshold of expiring (default: 0.01 seconds)
4. Player is using an SMG-type weapon (if SMG-only setting is enabled)

This gives you time to dodge and refresh the buff, helping to maintain buff uptime, especially when it bugs out and doesn't refresh properly.

**Note:** This feature is experimental and may need adjustments based on game updates. The hook points may change with Darktide patches, but the mod will fail gracefully if hooks don't work as expected.

## Settings

### Visual Indicator Settings
- **Enable Visual Indicator** - Toggle the on-screen buff status indicator
- **Indicator Font Size** - Size of the status text (default: 32)
- **Indicator X/Y Position** - Screen position of the indicator

### Shot-Blocking Settings
- **Enable Automatic Shot Blocking** - Toggle the shot-blocking feature (default: enabled)
- **Shot Block Expiry Threshold** - Time remaining (in seconds) before buff expiry to trigger shot blocking (default: 0.01, range: 0.001-0.5)
- **SMG Weapons Only** - Only apply shot blocking to SMG-type weapons (default: enabled)

## Requirements

- [Darktide Mod Framework (DMF)](https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework)

## Installation

1. Install the Darktide Mod Framework
2. Copy the mod folder to your Darktide mods directory
3. Enable the mod in the mod manager

## License

MIT License