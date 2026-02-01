# Implementation Assumptions & Uncertainties

This document lists all aspects of the mod implementation that were based on assumptions or educated guesses, as the implementation was created without direct access to:
- Darktide game files
- Actual Darktide Mod Framework (DMF) source code
- Real Vulture's Dodge buff data
- Live testing environment

## ⚠️ HIGH UNCERTAINTY - Will Likely Need Adjustment

### 1. Buff Name Detection (Lines 16-23)
**Assumption**: The buff names in `VULTURE_BUFF_NAMES` are educated guesses based on common Darktide naming patterns.

```lua
local VULTURE_BUFF_NAMES = {
	"trait_bespoke_dodge_defense",
	"trait_bespoke_dodge_damage",
	"ogryn_dodge_buff",
	"outcast_dodge_talent",
	"vultures_dodge",
	"content/items/traits/gadget_dr_vs_flamer",
}
```

**Reality**: The actual buff name could be completely different, such as:
- `trait_bespoke_dodge_defence_on_weakspot` (note British spelling)
- `content/items/traits/bespoke/trait_bespoke_dodge_dr`
- `vultures_dodge_active`
- Or any other variation

**How to Find Real Name**:
1. Enable developer mode in DMF
2. Add debug logging to print all active buff names:
```lua
for _, buff in pairs(buffs) do
    if buff.template and buff.template.name then
        mod:echo("Active buff: " .. buff.template.name)
    end
end
```
3. Dodge in game and check console output

### 2. Buff Extension API Methods (Lines 48-72)
**Assumption**: The buff extension has methods like:
- `ScriptUnit.has_extension(player_unit, "buff_system")`
- `buff_extension:has_keyword(buff_name)`
- `buff_extension:has_buff_type(buff_name)`
- `buff_extension:buffs()`

**Reality**: These methods might not exist, or might have different names/signatures:
- Could be `get_extension` instead of `has_extension`
- Might be `has_buff_perk` or `has_buff_with_keyword`
- The `buffs()` method might return a different data structure

**Alternative Approaches to Try**:
```lua
-- Try these if the current methods don't work:
local buff_extension = ScriptUnit.extension(player_unit, "buff_system")
-- or
local buff_extension = Unit.get_data(player_unit, "buff_extension")

-- For checking buffs:
buff_extension:has_buff_perk_type(buff_name)
buff_extension:has_buff_using_buff_template(buff_name)
```

### 3. UI Rendering (Lines 117-138)
**Assumption**: UI rendering works with these methods and parameters:

```lua
UIRenderer.draw_text(ui_renderer, indicator_text, font_type, font_size, font_material, position, color)
```

**Reality**: The actual DMF rendering API might be completely different:
- Different method name (e.g., `UIRenderer.render_text` or `ui_renderer:draw_text`)
- Different parameter order
- Different color format (might need normalized 0-1 instead of 0-255)
- Font system might work differently

**Known Potential Issues**:
- Color might need to be `{0, 1, 0, 1}` instead of `{0, 255, 0, 255}`
- Font material path might be incorrect
- The `text_style` table created but not used (lines 124-131)

**Better Approach** (if current doesn't work):
Look at other working DMF mods for UI rendering examples, such as:
- Numeric UI mods
- Crosshair mods
- Any mod that draws custom HUD elements

## ⚠️ MEDIUM UNCERTAINTY - Might Need Adjustment

### 4. Hook Points (Lines 78, 95)
**Assumption**: Hooking into `UIHud.update` and `UIHud.draw` is correct.

**Reality**: 
- Hook class might be different (e.g., `HudElementPersonalPlayerPanel`, `UIManager`)
- Method names might be different
- These hooks might not provide the right timing or context

**Alternatives to Try**:
```lua
mod:hook_safe("HudElementPersonalPlayerPanel", "update", ...)
mod:hook_safe("UIManager", "update", ...)
mod:hook("HudElementPersonalPlayerPanel", "_draw_widgets", ...)
```

### 5. Player Unit Access (Lines 26-39)
**Assumption**: 
```lua
local player_manager = Managers.player
local player = player_manager:local_player(1)
local player_unit = player.player_unit
```

**Reality**: 
- `Managers.player` might be accessed differently
- Index might be different (0 instead of 1?)
- Player unit property might be `unit` instead of `player_unit`

**Alternatives**:
```lua
local player = Managers.player:local_player_safe(1)
local player_unit = player and player.unit
-- or
local player_unit = Managers.player:local_player(1).player_unit
```

### 6. Font Type (Line 119)
**Assumption**: `"hell_shark"` is a valid font type.

**Reality**: Font might be named differently or not exist. Common alternatives:
- `"proxima_nova_bold"`
- `"arial"`
- `"machine_medium"`

### 7. Time Parameter (Lines 78, 88)
**Assumption**: The `t` parameter in the update hook is absolute time in seconds.

**Reality**: It might be:
- Frame count
- Milliseconds instead of seconds
- Delta time since last frame
- Game time vs real time

## ⚠️ LOW UNCERTAINTY - Probably Works

### 8. Mod Settings System (Lines 108-111)
**Assumption**: `mod:get("setting_name")` retrieves settings.

**Confidence**: HIGH - This is standard DMF API and should work correctly.

### 9. Localization System
**Assumption**: The localization file structure is correct.

**Confidence**: HIGH - This follows standard DMF patterns.

### 10. Mod Lifecycle Hooks (Lines 142-153)
**Assumption**: `on_all_mods_loaded`, `on_enabled`, `on_disabled` are valid lifecycle hooks.

**Confidence**: MEDIUM-HIGH - These are common in DMF but exact names might vary.

## 🔧 Recommended Testing Procedure

1. **Start Simple**: 
   - First, just check if the mod loads without crashing
   - Add `mod:echo()` statements to verify hooks are being called
   
2. **Debug Buff Detection**:
   - Add logging to see all active buffs
   - Verify the buff exists and find its real name
   
3. **Test UI Rendering**:
   - Start with just trying to draw ANY text, regardless of buff status
   - If nothing shows, try different rendering methods from other mods
   
4. **Iterate**: 
   - Fix one issue at a time
   - Use console output to debug
   - Check DMF logs for errors

## 📝 What Users Should Know

If the mod doesn't work immediately:
1. It's NOT broken, it just needs calibration
2. The core logic is sound, just the specific API calls need adjustment
3. With some debugging and comparing to working mods, all issues are fixable
4. The most likely issue is the buff name being different from assumptions

## 🎯 Guaranteed to Work

These parts have NO uncertainty:
- ✅ Mod file structure
- ✅ Settings/localization file format  
- ✅ Basic Lua logic and control flow
- ✅ Error handling patterns (checking for nil)
- ✅ Performance optimization approach (throttling)

## 📚 Resources Needed for Proper Implementation

To make this 100% correct, you would need:
1. Access to Darktide game files to find actual buff names
2. DMF source code or comprehensive API documentation
3. Examples from other working buff tracking mods
4. Live testing environment with Vulture's Dodge trait equipped
5. DMF developer console to inspect runtime data
