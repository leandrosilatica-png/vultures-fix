# Quick Reference: Enabling Debug Mode

If the mod doesn't work immediately, follow these steps:

## 1. Enable Debug Logging

Edit: `scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker.lua`

Change line 9 from:
```lua
local DEBUG_MODE = false
```

To:
```lua
local DEBUG_MODE = true
```

## 2. Launch Game & Check Console

1. Start Darktide with mod enabled
2. Open DMF console (usually `~` key)
3. Look for debug messages prefixed with `[Vulture Debug]`

## 3. What to Look For

### If you see: "Update hook called at t=..."
✅ Hook system is working

### If you see: "Buff extension not found"
❌ Need to change buff extension name
- Try changing `"buff_system"` to `"buff"` on line 66

### If you see: "Active buff [1]: some_buff_name"
✅ Buff detection is working!
- Look for the Vulture's Dodge buff name in the list
- Update `VULTURE_BUFF_NAMES` table (lines 27-34) with the correct name

### If you see: "Drew indicator: VULTURE'S DODGE"
✅ Rendering is working!

### If you DON'T see rendering messages:
❌ UI rendering needs adjustment
- See DEBUG_GUIDE.md section "Issue: Buff detected but indicator doesn't show"

## 4. Common Quick Fixes

### Wrong buff name:
1. Enable debug mode
2. Dodge in combat
3. Check console for list of active buffs
4. Find the one that looks like Vulture's Dodge
5. Add it to `VULTURE_BUFF_NAMES` array

### Indicator not visible:
1. Set "Show When Inactive" to ON in mod settings
2. Check X/Y position settings (default: 960, 100)
3. Try changing color format from {0, 255, 0, 255} to {0, 1, 0, 1} on lines 15-16

### Mod not loading:
1. Check all files are in correct directories
2. Enable mod in DMF manager
3. Check console for Lua errors
4. Look in `%AppData%\Fatshark\Darktide\console_logs\`

## 5. Still Not Working?

Read the full troubleshooting guides:
- `ASSUMPTIONS.md` - What was assumed during development
- `DEBUG_GUIDE.md` - Step-by-step debugging procedures
- `INSTALL.md` - Detailed installation instructions

## Files to Check

| File | Line | What to Check |
|------|------|---------------|
| vultures_dodge_tracker.lua | 9 | DEBUG_MODE setting |
| vultures_dodge_tracker.lua | 27-34 | Buff names array |
| vultures_dodge_tracker.lua | 66 | Buff extension name |
| vultures_dodge_tracker.lua | 15-16 | Color format |
| vultures_dodge_tracker.lua | 99 | Hook point |
| vultures_dodge_tracker.lua | 141 | Font name |

## Expected Debug Output (when working)

```
Vulture's Dodge Tracker loaded successfully!
⚠️ DEBUG MODE ENABLED - Check console for detailed logs
See ASSUMPTIONS.md and DEBUG_GUIDE.md for troubleshooting
[Vulture Debug] Update hook called at t=12.345
[Vulture Debug] Active buff [1]: some_buff_name
[Vulture Debug] Active buff [2]: another_buff_name
[Vulture Debug] Buff detected via pattern match: vultures_dodge_buff
[Vulture Debug] Buff state changed: false -> true
[Vulture Debug] Drew indicator: VULTURE'S DODGE (active: true)
```

## Disable Debug Mode After Fixing

Once everything works, set `DEBUG_MODE = false` to reduce console spam.
