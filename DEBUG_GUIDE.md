# Debugging Guide

This guide will help you troubleshoot issues and adapt the mod to work with your specific Darktide setup.

## Step 1: Verify the Mod Loads

### Check for Load Message
1. Launch Darktide with the mod enabled
2. Open the DMF console (usually `~` key or through mod manager)
3. Look for: `"Vulture's Dodge Tracker loaded successfully!"`

**If you see the message**: ✅ Mod structure is correct, proceed to Step 2
**If you DON'T see it**: ❌ Check these:
- Is the mod enabled in Mod Manager?
- Are all files in the correct directories?
- Check DMF console for Lua errors
- Look in `%AppData%\Fatshark\Darktide\console_logs\` for error logs

## Step 2: Add Debug Logging

Replace the main mod file with this debug version to see what's happening:

### Enhanced Debug Version

Add these lines at the start of `vultures_dodge_tracker.lua` (after line 13):

```lua
-- Debug mode - set to true to see detailed logging
local DEBUG_MODE = true

local function debug_log(message)
	if DEBUG_MODE then
		mod:echo("[VDT DEBUG] " .. tostring(message))
	end
end
```

### Add Logging to Update Hook (around line 78):

```lua
mod:hook_safe("UIHud", "update", function(self, dt, t)
	debug_log("Update hook called - t: " .. tostring(t))
	
	if not mod:get("enabled") then
		debug_log("Mod is disabled")
		return
	end
	
	if t - _last_check_time < _check_interval then
		return
	end
	_last_check_time = t
	
	debug_log("Checking buff status...")
	_is_buff_active = check_buff_active()
	debug_log("Buff active: " .. tostring(_is_buff_active))
end)
```

### Add Logging to Buff Check (around line 42):

```lua
local function check_buff_active()
	debug_log("Getting player unit...")
	local player_unit = get_player_unit()
	if not player_unit then
		debug_log("ERROR: Player unit not found!")
		return false
	end
	debug_log("Player unit found: " .. tostring(player_unit))
	
	local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	if not buff_extension then
		debug_log("ERROR: Buff extension not found!")
		return false
	end
	debug_log("Buff extension found: " .. tostring(buff_extension))
	
	-- Rest of function...
end
```

## Step 3: Diagnose Common Issues

### Issue: "Update hook called" never appears

**Problem**: Hook point is wrong
**Solutions to try**:
1. Try different hook targets:
```lua
-- Try these one at a time:
mod:hook_safe("HudElementPersonalPlayerPanel", "update", ...)
mod:hook_safe("UIManager", "update", ...)
mod:hook_safe("HudElementCrosshair", "update", ...)
```

2. List all available hooks:
```lua
-- Add this temporarily to see what's available:
mod.on_all_mods_loaded = function()
	for k, v in pairs(UIHud) do
		mod:echo("UIHud method: " .. tostring(k))
	end
end
```

### Issue: "Buff extension not found"

**Problem**: Wrong extension name or access method
**Solutions to try**:

```lua
-- Method 1: Different extension name
local buff_extension = ScriptUnit.has_extension(player_unit, "buff")

-- Method 2: Direct extension access
local buff_extension = ScriptUnit.extension(player_unit, "buff_system")

-- Method 3: Check available extensions
for ext_name, ext in pairs(player_unit) do
	debug_log("Extension: " .. tostring(ext_name))
end
```

### Issue: Hooks work but buff never detected

**Problem**: Wrong buff names
**Solution**: Print ALL active buffs:

```lua
local function check_buff_active()
	local player_unit = get_player_unit()
	if not player_unit then return false end
	
	local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	if not buff_extension then return false end
	
	-- TEMPORARY: Print all active buffs
	local buffs = buff_extension:buffs()
	if buffs then
		debug_log("=== ACTIVE BUFFS START ===")
		for i, buff in pairs(buffs) do
			if buff.template and buff.template.name then
				debug_log("Buff #" .. tostring(i) .. ": " .. buff.template.name)
			end
		end
		debug_log("=== ACTIVE BUFFS END ===")
	end
	
	-- Original detection logic...
end
```

**Action**: 
1. Run this version
2. Dodge in combat (to trigger Vulture's Dodge)
3. Check console for the buff list
4. Find the real buff name
5. Update `VULTURE_BUFF_NAMES` with the correct name

### Issue: Buff detected but indicator doesn't show

**Problem**: UI rendering method is wrong
**Solutions to try**:

```lua
-- In the draw hook, try these alternatives:

-- Alternative 1: Simpler draw_text call
if ui_renderer then
	ui_renderer:draw_text("VULTURE'S DODGE", "hell_shark", 24, {pos_x, pos_y, 1}, color)
end

-- Alternative 2: Using Gui
local gui = self._ui_scenegraph  -- might need to find the right gui object
if gui then
	Gui.text(gui, indicator_text, "hell_shark", 24, {pos_x, pos_y}, color)
end

-- Alternative 3: Check what self contains
debug_log("Draw hook - self type: " .. type(self))
for k, v in pairs(self) do
	if type(v) == "function" and string.find(k, "draw") then
		debug_log("Draw method found: " .. k)
	end
end
```

### Issue: Wrong color format

**Problem**: Color values wrong (255 vs 1.0)
**Solution**: Try normalized values:

```lua
-- Instead of {0, 255, 0, 255}
local COLOR_ACTIVE = {0, 1, 0, 1}       -- Normalized RGB
local COLOR_INACTIVE = {1, 0, 0, 1}

-- Or try different format
local COLOR_ACTIVE = Color(0, 255, 0, 255)   -- Using Color constructor
```

## Step 4: Find Working Examples

Look at other DMF mods that do similar things:

### For Buff Tracking:
- Search for mods that track toughness buffs
- Look at how they access the buff system
- Copy their buff checking approach

### For UI Rendering:
- Find mods that draw custom HUD elements
- Look at crosshair mods or numeric UI mods
- Copy their rendering code structure

### Where to Look:
1. DMF mod repository/workshop
2. Nexus Mods Darktide section
3. Discord servers for Darktide modding

## Step 5: Systematic Testing

### Test 1: Can you get player unit?
```lua
mod.on_all_mods_loaded = function()
	local player = Managers.player:local_player(1)
	if player then
		mod:echo("✅ Player found")
		if player.player_unit then
			mod:echo("✅ Player unit found")
		else
			mod:echo("❌ Player unit not found - try 'unit' instead")
		end
	else
		mod:echo("❌ Player not found")
	end
end
```

### Test 2: Can you access extensions?
```lua
local player_unit = Managers.player:local_player(1).player_unit
if player_unit then
	-- Try all these:
	local ext1 = ScriptUnit.has_extension(player_unit, "buff_system")
	local ext2 = ScriptUnit.has_extension(player_unit, "buff")
	local ext3 = ScriptUnit.extension(player_unit, "buff_system")
	
	mod:echo("Extension attempt 1: " .. tostring(ext1 ~= nil))
	mod:echo("Extension attempt 2: " .. tostring(ext2 ~= nil))
	mod:echo("Extension attempt 3: " .. tostring(ext3 ~= nil))
end
```

### Test 3: Can you draw anything?
```lua
mod:hook_safe("UIHud", "draw", function(self, dt, t, ui_renderer)
	if ui_renderer then
		mod:echo("✅ UI renderer available")
		-- Try to draw SOMETHING, anything
		-- Try different methods until something works
	else
		mod:echo("❌ UI renderer is nil")
	end
end)
```

## Step 6: Common Quick Fixes

### If mod crashes on load:
- Comment out the draw hook entirely
- Make sure all commas are correct
- Check for syntax errors with a Lua linter

### If nothing happens:
- Verify mod is actually enabled
- Check that `enabled` setting is true
- Set `show_when_inactive` to true to always see indicator

### If performance issues:
- Increase `_check_interval` from 0.1 to 0.5 or 1.0
- Add more thorough nil checks
- Reduce logging in production

## Emergency Fallback: Minimal Working Version

If all else fails, start with this ultra-minimal version that just tries to draw text:

```lua
local mod = get_mod("vultures_dodge_tracker")

mod:hook_safe("UIHud", "draw", function(self, dt, t, ui_renderer)
	if ui_renderer then
		-- Just try to draw SOMETHING
		mod:echo("Attempting to draw...")
		-- Try different methods here
	end
end)
```

Once ANY text renders, build back up from there.

## Getting Help

If you can't get it working after following this guide:

1. **Gather Information**:
   - What error messages do you see?
   - What does the debug logging show?
   - What other mods work for you?

2. **Check These Resources**:
   - DMF Discord/Community
   - Other working Darktide mods' source code
   - Darktide modding documentation

3. **Provide This When Asking for Help**:
   - Your console log output
   - DMF version
   - Darktide version
   - What you've tried from this guide

## Success Indicators

You'll know it's working when:
- ✅ Console shows "Update hook called" periodically
- ✅ You see buff detection messages
- ✅ Text appears on screen (any color is progress!)
- ✅ Text changes color when you dodge

Good luck! Remember: the logic is sound, it just needs calibration for your specific game version.
