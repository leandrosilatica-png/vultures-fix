--[[
	Vulture's Dodge Tracker with Automatic Shot-Blocking
	
	This mod provides visual tracking of the Vulture's Dodge buff for Hive Scum (Outcast) class
	and includes an EXPERIMENTAL automatic shot-blocking feature.
	
	EXPERIMENTAL FEATURE: Automatic Shot-Blocking
	When all conditions are met, this mod will prevent ONE shot from firing:
	1. Vulture's Dodge buff is currently active
	2. The last shot was a critical hit
	3. The buff is within a configurable threshold of expiring (default: 0.01 seconds)
	4. Player is using an SMG-type weapon (if smg_only setting is enabled)
	
	This gives the player time to dodge and refresh the buff, helping to maintain the
	buff's uptime, especially when it bugs out and doesn't refresh properly.
	
	NOTES:
	- This feature is experimental and may need adjustments based on game updates
	- The hook points may change with Darktide patches
	- The mod will fail gracefully if hooks don't work as expected
	- Since Darktide has no anti-cheat, input/action manipulation is possible
--]]

local mod = get_mod("vultures_dodge_tracker")

-- ====================
-- Mod State Variables
-- ====================
local _is_buff_active = false        -- Tracks if Vulture's Dodge is currently active
local _last_shot_was_crit = false    -- Tracks if the last shot fired was a critical hit

-- ====================
-- Constants
-- ====================
-- Internal buff name for Vulture's Dodge (may need adjustment based on game version)
local VULTURES_DODGE_BUFF_NAME = "toughness_regen_on_crit_kills"

-- List of SMG weapon templates to identify SMG-type weapons
-- NOTE: This list may need to be expanded as new weapons are added to the game
local SMG_WEAPON_TEMPLATES = {
	"autogun_p1_m1",  -- Autopistol
	"autogun_p2_m1",  -- Autopistol variant
	"autogun_p3_m1",  -- Autopistol variant
	-- Add more SMG templates as needed
}

-- ====================
-- Helper Functions
-- ====================

--[[
	Check if the current weapon is an SMG-type weapon
	
	@param weapon_template - The weapon template object from the game
	@return boolean - True if weapon is an SMG, false otherwise
--]]
local function is_smg_weapon(weapon_template)
	if not weapon_template then
		return false
	end
	
	local template_name = weapon_template.name or ""
	
	-- Check if it's in our SMG list
	for _, smg_template in ipairs(SMG_WEAPON_TEMPLATES) do
		if template_name:find(smg_template) then
			return true
		end
	end
	
	-- Also check for common SMG keywords in the name
	if template_name:find("autogun_p") or template_name:find("stubber") then
		return true
	end
	
	return false
end

--[[
	Get the player's buff extension to query buff status
	
	@return BuffExtension or nil - The player's buff extension if available
--]]
local function get_player_buff_extension()
	local player = Managers.player:local_player(1)
	if not player then
		return nil
	end
	
	local player_unit = player.player_unit
	if not player_unit then
		return nil
	end
	
	local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	return buff_extension
end

--[[
	Get the remaining time on the Vulture's Dodge buff
	
	This function queries the buff extension to determine:
	1. If the buff is currently active
	2. How much time remains before it expires
	
	@return number - Remaining time in seconds (0 if buff is not active)
--]]
local function get_buff_remaining_time()
	local buff_extension = get_player_buff_extension()
	if not buff_extension then
		return 0
	end
	
	-- Try to check if the buff is active using available methods
	-- The exact API may vary, so we try multiple approaches
	local has_buff = false
	
	-- Try the most common method first
	if buff_extension.has_buff_using_buff_template then
		has_buff = buff_extension:has_buff_using_buff_template(VULTURES_DODGE_BUFF_NAME)
	elseif buff_extension.has_buff then
		has_buff = buff_extension:has_buff(VULTURES_DODGE_BUFF_NAME)
	end
	
	if not has_buff then
		_is_buff_active = false
		return 0
	end
	
	_is_buff_active = true
	
	-- Try to get the buff data to find remaining time
	-- Access buff data through available API, with fallback to internal access if needed
	local buffs = nil
	if buff_extension.get_buffs then
		buffs = buff_extension:get_buffs()
	elseif buff_extension._buffs then
		-- Fallback: Access internal field (may be fragile)
		buffs = buff_extension._buffs
	end
	
	if buffs then
		for i = 1, #buffs do
			local buff = buffs[i]
			if buff and buff.template_name == VULTURES_DODGE_BUFF_NAME then
				-- Calculate remaining time
				local duration = buff.duration or 0
				local start_time = buff.start_time or 0
				local current_time = Managers.time:time("gameplay")
				local elapsed_time = current_time - start_time
				local remaining = duration - elapsed_time
				
				return math.max(0, remaining)
			end
		end
	end
	
	-- If we can't determine remaining time but buff is active, return a safe value
	-- This ensures the feature doesn't trigger incorrectly
	return 1
end

-- ====================
-- Critical Hit Tracking Hooks
-- ====================
-- These hooks monitor when shots are fired and track whether they were critical hits
-- This information is used to determine if shot-blocking should be triggered
-- NOTE: Critical hit detection is challenging because crits are determined during damage
-- calculation, not at the time of shooting. We use multiple hooks for reliability.

-- Hook into damage dealt events to track critical hits more reliably
-- This monitors when the player deals damage and checks if it was a critical hit
mod:hook_safe(CLASS.AttackReportManager, "add_attack_result", function(self, damage_profile, hit_unit, attack_type, attack_result, target_index, target_is_enemy, damage, attack_direction, ...)
	-- Check if this is a critical hit
	-- In Darktide, attack_result typically contains information about hit type
	if attack_result then
		-- Try multiple ways to detect crits as the structure may vary
		if attack_result == "critical_hit" or 
		   (type(attack_result) == "table" and (attack_result.critical_hit or attack_result.is_critical)) then
			_last_shot_was_crit = true
		end
	end
end)

-- Fallback: Track when ranged actions finish, reset crit flag
mod:hook_safe(CLASS.ActionShoot, "finish", function(self, reason, data, t, ...)
	-- After an action completes, we may need to reset or maintain the crit flag
	-- This is intentionally left minimal to avoid false negatives
end)

-- ====================
-- Automatic Shot-Blocking Hook (EXPERIMENTAL)
-- ====================
-- This is the core of the shot-blocking feature. It intercepts weapon firing
-- and prevents a shot when conditions are met to help preserve the buff.
-- 
-- EXPERIMENTAL NOTES:
-- - The exact hook point may need adjustment based on Darktide's code structure
-- - This may break with game updates and require maintenance
-- - The mod fails gracefully if the hook doesn't work as expected

-- Hook into weapon action to block shots when conditions are met
-- EXPERIMENTAL: This hook intercepts weapon firing to block a shot
mod:hook(CLASS.ActionShoot, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
	-- Check if shot blocking is enabled
	if not mod:get("enable_shot_block") then
		return func(self, action_settings, t, time_scale, action_start_params, ...)
	end
	
	-- Check conditions for shot blocking BEFORE the shot fires
	local threshold = mod:get("expiry_threshold") or 0.01
	local smg_only = mod:get("smg_only")
	local buff_time = get_buff_remaining_time()
	
	-- Check weapon type if SMG-only is enabled
	local weapon_ok = true
	if smg_only then
		local weapon_extension = self._weapon_extension
		if weapon_extension then
			local weapon_template = weapon_extension:weapon_template()
			weapon_ok = is_smg_weapon(weapon_template)
		else
			weapon_ok = false
		end
	end
	
	-- Check if we should block THIS shot
	if _is_buff_active 
		and _last_shot_was_crit 
		and buff_time > 0 
		and buff_time <= threshold
		and weapon_ok then
		
		-- Block this shot by not calling the original function
		mod:echo("Shot blocked to preserve Vulture's Dodge buff")
		_last_shot_was_crit = false  -- Reset so we don't block multiple shots
		
		-- Return a minimal valid result instead of nil to avoid breaking the action chain
		-- This tells the game the action has been handled without actually firing
		return true
	end
	
	-- Call original function to proceed with normal shot
	return func(self, action_settings, t, time_scale, action_start_params, ...)
end)

-- ====================
-- Visual Indicator
-- ====================
-- Draws the on-screen indicator showing buff status (green = active, red = inactive)

-- Visual indicator drawing
mod:hook_safe(CLASS.HudElementPersonalPlayerPanel, "update", function(self, dt, t, ui_renderer, render_settings, input_service)
	if not mod:get("enable_visual_indicator") then
		return
	end
	
	-- Update buff status
	local buff_time = get_buff_remaining_time()
	
	-- Determine indicator color
	local color = _is_buff_active and Color.green(255, true) or Color.red(255, true)
	local text = _is_buff_active and "VULTURE ACTIVE" or "VULTURE INACTIVE"
	
	-- Get position and size from settings
	local pos_x = mod:get("indicator_position_x") or 960
	local pos_y = mod:get("indicator_position_y") or 540
	local font_size = mod:get("indicator_font_size") or 32
	
	-- Draw the indicator
	local position = Vector3(pos_x, pos_y, 1)
	local font_type = "proxima_nova_bold"
	local font_size_scaled = font_size
	
	if ui_renderer then
		-- Draw text with the determined color
		-- Note: The exact signature of draw_text may vary between game versions
		-- This uses a common pattern that should work in most cases
		local inverse_scale = 1
		if render_settings and render_settings.inverse_scale then
			inverse_scale = render_settings.inverse_scale
		end
		
		ui_renderer:draw_text(text, font_type, font_size_scaled, inverse_scale, position, color)
	end
end)

-- ====================
-- Mod Lifecycle Callbacks
-- ====================

-- Mod initialization
mod.on_all_mods_loaded = function()
	mod:echo("Vulture's Dodge Tracker loaded with automatic shot-blocking feature")
	mod:echo("Note: Shot-blocking feature is EXPERIMENTAL and may need adjustments")
end

-- Mod settings changed callback
mod.on_setting_changed = function(setting_id)
	if setting_id == "enable_shot_block" then
		local enabled = mod:get("enable_shot_block")
		mod:echo("Automatic shot blocking " .. (enabled and "enabled" or "disabled"))
	end
end
