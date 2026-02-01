local mod = get_mod("vultures_dodge_tracker")

-- Mod state variables
local _is_buff_active = false
local _last_shot_was_crit = false
local _should_block_next_shot = false

-- Constants
local VULTURES_DODGE_BUFF_NAME = "toughness_regen_on_crit_kills"  -- Internal buff name for Vulture's Dodge
local SMG_WEAPON_TEMPLATES = {
	"autogun_p1_m1",  -- Autopistol
	"autogun_p2_m1",  -- Autopistol variant
	"autogun_p3_m1",  -- Autopistol variant
	-- Add more SMG templates as needed
}

-- Helper function to check if weapon is an SMG type
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

-- Get the player's buff extension
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

-- Get remaining time on Vulture's Dodge buff
local function get_buff_remaining_time()
	local buff_extension = get_player_buff_extension()
	if not buff_extension then
		return 0
	end
	
	-- Check if the buff is active
	local has_buff = buff_extension:has_buff_using_buff_template(VULTURES_DODGE_BUFF_NAME)
	if not has_buff then
		_is_buff_active = false
		return 0
	end
	
	_is_buff_active = true
	
	-- Try to get the buff data to find remaining time
	local buffs = buff_extension._buffs
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
	return 1
end

-- Hook to track critical hits
-- This hooks into the damage dealt function to detect crits
mod:hook_safe(CLASS.ActionSweep, "finish", function(self, reason, data, t, ...)
	-- Reset crit tracking when action finishes
	_last_shot_was_crit = false
end)

-- Hook to track critical hits from ranged weapons
mod:hook_safe(CLASS.ActionShoot, "_finish_action", function(self, reason, ...)
	-- Check if the last shot was a critical hit
	-- This is a simplified approach - actual implementation may need to hook into damage system
	if self._critical_hit then
		_last_shot_was_crit = true
	else
		_last_shot_was_crit = false
	end
end)

-- Alternative hook for damage dealt to track crits more reliably
mod:hook_safe(CLASS.PlayerUnitDamageExtension, "add_damage", function(self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_profile, hit_actor, damaging_unit, attack_result, ...)
	-- Check if this is a critical hit
	if attack_result and attack_result[1] == "ATTACK_RESULT_CRIT" then
		_last_shot_was_crit = true
	end
end)

-- Hook into weapon action to block shots when conditions are met
-- EXPERIMENTAL: This hook intercepts weapon firing to block a shot
mod:hook(CLASS.ActionShoot, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
	-- Check if shot blocking is enabled
	if not mod:get("enable_shot_block") then
		return func(self, action_settings, t, time_scale, action_start_params, ...)
	end
	
	-- Check if we should block this shot
	if _should_block_next_shot then
		mod:echo("Shot blocked to preserve Vulture's Dodge buff")
		_should_block_next_shot = false
		_last_shot_was_crit = false
		
		-- Return early to prevent the shot from firing
		-- Note: This is experimental and may need adjustment
		return
	end
	
	-- Check conditions for shot blocking
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
	
	-- Determine if we should block the next shot
	if _is_buff_active 
		and _last_shot_was_crit 
		and buff_time > 0 
		and buff_time <= threshold
		and weapon_ok then
		
		-- Set flag to block next shot
		_should_block_next_shot = true
		mod:echo("Conditions met for shot blocking - next shot will be blocked")
	end
	
	-- Call original function
	return func(self, action_settings, t, time_scale, action_start_params, ...)
end)

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
		local text_options = UIFonts.get_font_options_by_style(font_type)
		ui_renderer:draw_text(text, font_type, font_size_scaled, ui_renderer.render_settings.inverse_scale, position, color)
	end
end)

-- Mod initialization
mod.on_all_mods_loaded = function()
	mod:echo("Vulture's Dodge Tracker loaded with automatic shot-blocking feature")
end

-- Mod settings changed callback
mod.on_setting_changed = function(setting_id)
	if setting_id == "enable_shot_block" then
		local enabled = mod:get("enable_shot_block")
		mod:echo("Automatic shot blocking " .. (enabled and "enabled" or "disabled"))
	end
end
