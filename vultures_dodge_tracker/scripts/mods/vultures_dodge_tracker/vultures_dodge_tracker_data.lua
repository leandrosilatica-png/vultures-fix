local mod = get_mod("vultures_dodge_tracker")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "enable_visual_indicator",
				type = "checkbox",
				default_value = true,
			},
			{
				setting_id = "indicator_font_size",
				type = "numeric",
				default_value = 32,
				range = {12, 72},
			},
			{
				setting_id = "indicator_position_x",
				type = "numeric",
				default_value = 960,
				range = {0, 3840},
			},
			{
				setting_id = "indicator_position_y",
				type = "numeric",
				default_value = 540,
				range = {0, 2160},
			},
			{
				setting_id = "enable_shot_block",
				type = "checkbox",
				default_value = true,
			},
			{
				setting_id = "expiry_threshold",
				type = "numeric",
				default_value = 0.01,
				range = {0.001, 0.5},
				decimals_number = 3,
			},
			{
				setting_id = "smg_only",
				type = "checkbox",
				default_value = true,
			},
			{
				setting_id = "weapon_template_filter",
				type = "text_input",
				default_value = "",
			},
		}
	}
}