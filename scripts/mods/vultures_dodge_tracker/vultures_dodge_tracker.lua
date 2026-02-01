local mod = get_mod("vultures_dodge_tracker")

-- Mod initialization
mod:io_dofile("vultures_dodge_tracker/scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker_data")

-- Constants
local COLOR_ACTIVE = {0, 255, 0, 255}     -- Green (RGBA)
local COLOR_INACTIVE = {255, 0, 0, 255}   -- Red (RGBA)

-- State variables
local _is_buff_active = false
local _last_check_time = 0
local _check_interval = 0.1 -- Check every 0.1 seconds

-- Common buff names for Vulture's Dodge
local VULTURE_BUFF_NAMES = {
	"trait_bespoke_dodge_defense",
	"trait_bespoke_dodge_damage",
	"ogryn_dodge_buff",
	"outcast_dodge_talent",
	"vultures_dodge",
	"content/items/traits/gadget_dr_vs_flamer",  -- Possible buff name
}

-- Helper function to get player unit
local function get_player_unit()
	local player_manager = Managers.player
	if not player_manager then
		return nil
	end
	
	local player = player_manager:local_player(1)
	if not player then
		return nil
	end
	
	local player_unit = player.player_unit
	return player_unit
end

-- Helper function to check if buff is active
local function check_buff_active()
	local player_unit = get_player_unit()
	if not player_unit then
		return false
	end
	
	local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	if not buff_extension then
		return false
	end
	
	-- Check for any of the possible buff names
	for _, buff_name in ipairs(VULTURE_BUFF_NAMES) do
		if buff_extension:has_keyword(buff_name) or buff_extension:has_buff_type(buff_name) then
			return true
		end
	end
	
	-- Alternative check: iterate through active buffs
	local buffs = buff_extension:buffs()
	if buffs then
		for _, buff in pairs(buffs) do
			if buff.template and buff.template.name then
				local name_lower = string.lower(buff.template.name)
				if string.find(name_lower, "vulture") or 
				   (string.find(name_lower, "dodge") and string.find(name_lower, "defense")) then
					return true
				end
			end
		end
	end
	
	return false
end

-- Hook into the UI update system
mod:hook_safe("UIHud", "update", function(self, dt, t)
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
	_is_buff_active = check_buff_active()
end)

-- Hook into UI rendering to draw the indicator
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
		local font_type = "hell_shark"
		local font_material = "materials/fonts/" .. font_type
		
		-- Draw the text
		local text_options = UIFonts.get_font_options_by_style("body_small")
		local text_style = {
			text_color = color,
			offset = position,
			font_type = font_type,
			font_size = font_size,
			horizontal_alignment = "center",
			vertical_alignment = "top",
		}
		
		-- Attempt to draw using available UI rendering methods
		-- This is a simplified version - actual implementation may need adjustment based on DMF version
		if UIRenderer and UIRenderer.draw_text then
			UIRenderer.draw_text(ui_renderer, indicator_text, font_type, font_size, font_material, position, color)
		end
	end
end)

-- Mod lifecycle hooks
mod.on_all_mods_loaded = function()
	mod:echo("Vulture's Dodge Tracker loaded successfully!")
end

mod.on_enabled = function()
	_is_buff_active = false
	_last_check_time = 0
end

mod.on_disabled = function()
	_is_buff_active = false
end
