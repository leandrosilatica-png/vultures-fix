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

- [Darktide Mod Framework (DMF)](https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework)
- Warhammer 40,000: Darktide

## Installation

1. Install the Darktide Mod Framework
2. Copy the `vultures_dodge_tracker.mod` file to your Darktide mods directory (typically `%AppData%\Fatshark\Darktide\mods`)
3. Copy the `scripts` folder to your Darktide mods directory
4. Enable the mod in the Darktide Mod Framework mod manager
5. Configure settings in-game through the mod options menu

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

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

MIT License