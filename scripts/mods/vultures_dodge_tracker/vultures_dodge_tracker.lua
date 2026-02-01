local mod = get_mod("vultures_dodge_tracker")

-- Mod initialization
mod:io_dofile("vultures_dodge_tracker/scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker_data")

-- Debug mode - set to true for detailed console logging
local DEBUG_MODE = false

local function debug_log(message)
	if DEBUG_MODE then
		mod:echo("[Vulture Debug] " .. tostring(message))
	end
end

-- Constants
local COLOR_ACTIVE = {0, 255, 0, 255}     -- Green (RGBA) - NOTE: May need {0, 1, 0, 1} if normalized
local COLOR_INACTIVE = {255, 0, 0, 255}   -- Red (RGBA) - NOTE: May need {1, 0, 0, 1} if normalized

-- State variables
local _is_buff_active = false
local _last_check_time = 0
local _check_interval = 0.1 -- Check every 0.1 seconds

-- ⚠️ ASSUMPTION: These buff names are educated guesses!
-- The real buff name might be different. See ASSUMPTIONS.md for details.
-- Enable DEBUG_MODE and dodge in-game to see all active buff names.
local VULTURE_BUFF_NAMES = {
	"trait_bespoke_dodge_defense",
	"trait_bespoke_dodge_damage",
	"ogryn_dodge_buff",
	"outcast_dodge_talent",
	"vultures_dodge",
	"content/items/traits/gadget_dr_vs_flamer",  -- Possible buff name
}

-- Helper function to get player unit
-- ⚠️ ASSUMPTION: Managers.player:local_player(1).player_unit is correct
-- Alternative: try local_player_safe(1) or .unit instead of .player_unit
local function get_player_unit()
	local player_manager = Managers.player
	if not player_manager then
		debug_log("Player manager not available")
		return nil
	end
	
	local player = player_manager:local_player(1)
	if not player then
		debug_log("Local player not found")
		return nil
	end
	
	local player_unit = player.player_unit
	if not player_unit then
		debug_log("Player unit not found on player object")
	end
	return player_unit
end

-- Helper function to check if buff is active
-- ⚠️ ASSUMPTIONS: 
-- - ScriptUnit.has_extension() exists and works this way
-- - buff_extension:has_keyword() and has_buff_type() exist
-- - buff_extension:buffs() returns an iterable table
-- See ASSUMPTIONS.md and DEBUG_GUIDE.md for troubleshooting
local function check_buff_active()
	local player_unit = get_player_unit()
	if not player_unit then
		return false
	end
	
	-- Try to get buff extension - may need adjustment
	local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	if not buff_extension then
		debug_log("Buff extension not found - may need different extension name")
		return false
	end
	
	-- Method 1: Check for any of the possible buff names using keywords/types
	for _, buff_name in ipairs(VULTURE_BUFF_NAMES) do
		-- Note: These methods might not exist - check DEBUG_GUIDE.md for alternatives
		if buff_extension:has_keyword(buff_name) or buff_extension:has_buff_type(buff_name) then
			debug_log("Buff detected via keyword/type: " .. buff_name)
			return true
		end
	end
	
	-- Method 2: Iterate through active buffs and pattern match
	local buffs = buff_extension:buffs()
	if buffs then
		for i, buff in pairs(buffs) do
			if buff.template and buff.template.name then
				-- Enable DEBUG_MODE to see all active buff names here
				if DEBUG_MODE then
					debug_log("Active buff [" .. i .. "]: " .. buff.template.name)
				end
				
				local name_lower = string.lower(buff.template.name)
				if string.find(name_lower, "vulture") or 
				   (string.find(name_lower, "dodge") and string.find(name_lower, "defense")) then
					debug_log("Buff detected via pattern match: " .. buff.template.name)
					return true
				end
			end
		end
	end
	
	return false
end

-- Hook into the UI update system
-- ⚠️ ASSUMPTION: "UIHud" and "update" are correct hook points
-- If this doesn't work, try: HudElementPersonalPlayerPanel, UIManager, etc.
-- See DEBUG_GUIDE.md for alternatives
mod:hook_safe("UIHud", "update", function(self, dt, t)
	debug_log("Update hook called at t=" .. tostring(t))
	
	-- Only check if mod is enabled
	if not mod:get("enabled") then
		return
	end
	
	-- Throttle checks to avoid performance issues
	if t - _last_check_time < _check_interval then
		return
	end
	_last_check_time = t
	
	-- Update buff status
	local prev_state = _is_buff_active
	_is_buff_active = check_buff_active()
	
	-- Log state changes
	if DEBUG_MODE and prev_state ~= _is_buff_active then
		debug_log("Buff state changed: " .. tostring(prev_state) .. " -> " .. tostring(_is_buff_active))
	end
end)

-- Hook into UI rendering to draw the indicator
-- ⚠️ ASSUMPTIONS: 
-- - UIHud.draw hook exists and provides ui_renderer
-- - UIRenderer.draw_text method exists with this signature
-- - Font "hell_shark" exists
-- - Color format is correct (0-255 RGBA)
-- See DEBUG_GUIDE.md for rendering troubleshooting
mod:hook_safe("UIHud", "draw", function(self, dt, t, ui_renderer, render_settings, input_service)
	-- Only render if mod is enabled
	if not mod:get("enabled") then
		return
	end
	
	-- Check if we should show the indicator
	local show_when_inactive = mod:get("show_when_inactive")
	if not _is_buff_active and not show_when_inactive then
		return
	end
	
	-- Get settings
	local font_size = mod:get("font_size")
	local pos_x = mod:get("pos_x")
	local pos_y = mod:get("pos_y")
	local indicator_text = mod:get("indicator_text")
	
	-- Determine color based on buff status
	local color = _is_buff_active and COLOR_ACTIVE or COLOR_INACTIVE
	
	-- Prepare UI renderer for drawing
	if ui_renderer then
		local position = {pos_x, pos_y, 1}
		local font_type = "hell_shark"  -- NOTE: Font name may need to change
		local font_material = "materials/fonts/" .. font_type
		
		-- Draw the text
		-- NOTE: UIFonts.get_font_options_by_style is called but result not used
		local text_options = UIFonts.get_font_options_by_style("body_small")
		local text_style = {
			text_color = color,
			offset = position,
			font_type = font_type,
			font_size = font_size,
			horizontal_alignment = "center",
			vertical_alignment = "top",
		}
		
		-- ⚠️ CRITICAL ASSUMPTION: This rendering method may be completely wrong
		-- If nothing displays, see DEBUG_GUIDE.md for alternative rendering methods
		if UIRenderer and UIRenderer.draw_text then
			UIRenderer.draw_text(ui_renderer, indicator_text, font_type, font_size, font_material, position, color)
			debug_log("Drew indicator: " .. indicator_text .. " (active: " .. tostring(_is_buff_active) .. ")")
		else
			if DEBUG_MODE then
				debug_log("UIRenderer.draw_text not available")
			end
		end
	else
		if DEBUG_MODE then
			debug_log("ui_renderer is nil in draw hook")
		end
	end
end)

-- Mod lifecycle hooks
mod.on_all_mods_loaded = function()
	mod:echo("Vulture's Dodge Tracker loaded successfully!")
	if DEBUG_MODE then
		mod:echo("⚠️ DEBUG MODE ENABLED - Check console for detailed logs")
		mod:echo("See ASSUMPTIONS.md and DEBUG_GUIDE.md for troubleshooting")
	end
end

mod.on_enabled = function()
	_is_buff_active = false
	_last_check_time = 0
	debug_log("Mod enabled")
end

mod.on_disabled = function()
	_is_buff_active = false
	debug_log("Mod disabled")
end
