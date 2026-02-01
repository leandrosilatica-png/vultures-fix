local mod = get_mod("vultures_dodge_tracker")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id    = "enabled",
				type          = "checkbox",
				default_value = true,
			},
			{
				setting_id      = "font_size",
				type            = "numeric",
				default_value   = 24,
				range           = {12, 48},
				decimals_number = 0,
			},
			{
				setting_id      = "pos_x",
				type            = "numeric",
				default_value   = 960,
				range           = {0, 1920},
				decimals_number = 0,
			},
			{
				setting_id      = "pos_y",
				type            = "numeric",
				default_value   = 100,
				range           = {0, 1080},
				decimals_number = 0,
			},
			{
				setting_id    = "show_when_inactive",
				type          = "checkbox",
				default_value = true,
			},
			{
				setting_id    = "indicator_text",
				type          = "textbox",
				default_value = "VULTURE'S DODGE",
			},
		}
	}
}
