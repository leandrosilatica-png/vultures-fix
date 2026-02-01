--[[
\tVulture's Dodge Tracker with Automatic Shot-Blocking
\n\tThis mod provides visual tracking of the Vulture's Dodge buff for Hive Scum (Outcast) class
and includes an EXPERIMENTAL automatic shot-blocking feature.
--]]
\nlocal mod = get_mod("vultures_dodge_tracker")
\n-- State Variables
local _is_buff_active = false
local _last_shot_was_crit = false
\n-- Constants
local VULTURES_DODGE_BUFF_NAME = "toughness_regen_on_crit_kills"
\nlocal SMG_WEAPON_TEMPLATES = {
\t"autogun_p1_m1",
\t"autogun_p2_m1",
\t"autogun_p3_m1",
}\n\n-- Helper Functions
local function is_smg_weapon(weapon_template)
\tif not weapon_template then
\t\treturn false
\tend\n\t\n\tlocal template_name = weapon_template.name or ""
\t\n\tfor _, smg_template in ipairs(SMG_WEAPON_TEMPLATES) do
\t\tif template_name:find(smg_template) then
\t\t\treturn true
\t\tend
\tend\n\t\n\tif template_name:find("autogun_p") or template_name:find("stubber") then
\t\treturn true
\tend\n\n\treturn false
end\n\nlocal function get_player_buff_extension()
\tlocal player = Managers.player:local_player(1)
\tif not player then
\t\treturn nil
\tend\n\t\n\tlocal player_unit = player.player_unit
\tif not player_unit then
\t\treturn nil
\tend\n\t\n\tlocal buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
\treturn buff_extension
end\n\nlocal function get_buff_remaining_time()
\tlocal buff_extension = get_player_buff_extension()
\tif not buff_extension then
\t\treturn 0
\tend\n\t\n\tlocal has_buff = false\n\n\tif buff_extension.has_buff_using_buff_template then
\t\thas_buff = buff_extension:has_buff_using_buff_template(VULTURES_DODGE_BUFF_NAME)
\telseif buff_extension.has_buff then
\t\thas_buff = buff_extension:has_buff(VULTURES_DODGE_BUFF_NAME)
\tend\n\n\tif not has_buff then
\t\t_is_buff_active = false
\t\treturn 0
\tend\n\n\t_is_buff_active = true\n\n\tlocal buffs = nil
\tif buff_extension.get_buffs then
\t\tbuffs = buff_extension:get_buffs()
\telseif buff_extension._buffs then
\t\tbuffs = buff_extension._buffs
\tend\n\n\tif buffs then
\t\tfor i = 1, #buffs do
\t\t\tlocal buff = buffs[i]
\t\t\tif buff and buff.template_name == VULTURES_DODGE_BUFF_NAME then
\t\t\t\tlocal duration = buff.duration or 0
\t\t\t\tlocal start_time = buff.start_time or 0
\t\t\t\tlocal current_time = Managers.time:time("gameplay")
\t\t\t\tlocal elapsed_time = current_time - start_time
\t\t\t\tlocal remaining = duration - elapsed_time
\n\t\t\t\treturn math.max(0, remaining)
\t\t\tend
\t\tend
\tend\n\nreturn 1
end\n\n-- Critical Hit Tracking
mod:hook_safe(CLASS.AttackReportManager, "add_attack_result", function(self, damage_profile, hit_unit, attack_type, attack_result, target_index, target_is_enemy, damage, attack_direction, ...)
\tif attack_result then
\t\tif attack_result == "critical_hit" then
\t\t\t_last_shot_was_crit = true
\t\telseif type(attack_result) == "table" and (attack_result.critical_hit or attack_result.is_critical) then
\t\t\t_last_shot_was_crit = true
\t\tend
\tend
end)\n\nmod:hook_safe(CLASS.ActionShoot, "finish", function(self, reason, data, t, ...)
end)\n\n-- Automatic Shot-Blocking Hook (EXPERIMENTAL)
mod:hook(CLASS.ActionShoot, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
\tif not mod:get("enable_shot_block") then
\t\treturn func(self, action_settings, t, time_scale, action_start_params, ...)
\tend\n\n\tlocal threshold = mod:get("expiry_threshold") or 0.01
\tlocal smg_only = mod:get("smg_only")
\tlocal buff_time = get_buff_remaining_time()
\n\tlocal weapon_ok = true
\tif smg_only then
\t\tlocal weapon_extension = self._weapon_extension
\t\tif weapon_extension then
\t\t\tlocal weapon_template = weapon_extension:weapon_template()
\t\t\tweapon_ok = is_smg_weapon(weapon_template)
\t\telse
\t\t\tweapon_ok = false
\tend\n\n\tif _is_buff_active 
\t\tand _last_shot_was_crit 
\t\tand buff_time > 0 
\t\tand buff_time <= threshold
\t\tand weapon_ok then
\t\t\tmod:echo("Shot blocked to preserve Vulture's Dodge buff")
\t\t\t_last_shot_was_crit = false
\n\t\t\treturn true
\tend\n\nreturn func(self, action_settings, t, time_scale, action_start_params, ...)
end)\n\n-- Visual Indicator
mod:hook_safe(CLASS.HudElementPersonalPlayerPanel, "update", function(self, dt, t, ui_renderer, render_settings, input_service)
\tif not mod:get("enable_visual_indicator") then
\t\treturn
\tend\n\n\tlocal buff_time = get_buff_remaining_time()
\n\tlocal color = _is_buff_active and Color.green(255, true) or Color.red(255, true)
\tlocal text = _is_buff_active and "VULTURE ACTIVE" or "VULTURE INACTIVE"
\n\tlocal pos_x = mod:get("indicator_position_x") or 960
\tlocal pos_y = mod:get("indicator_position_y") or 540
\tlocal font_size = mod:get("indicator_font_size") or 32
\n\tlocal position = Vector3(pos_x, pos_y, 1)
\tlocal font_type = "proxima_nova_bold"
\tlocal font_size_scaled = font_size\n\n\tif ui_renderer then
\t\tlocal inverse_scale = 1
\t\tif render_settings and render_settings.inverse_scale then
\t\t\tinverse_scale = render_settings.inverse_scale
\t\tend
\n\t\tpcall(function()
\t\t\tui_renderer:draw_text(text, font_type, font_size_scaled, inverse_scale, position, color)
\t\tend)
\tend
end)\n\n-- Mod Lifecycle
mod.on_all_mods_loaded = function()
\tmod:echo("Vulture's Dodge Tracker loaded with automatic shot-blocking feature")
\tmod:echo("Note: Shot-blocking feature is EXPERIMENTAL and may need adjustments")
end\n\nmod.on_setting_changed = function(setting_id)
\tif setting_id == "enable_shot_block" then
\t\tlocal enabled = mod:get("enable_shot_block")
\t\tmod:echo("Automatic shot blocking " .. (enabled and "enabled" or "disabled"))
\tend
end