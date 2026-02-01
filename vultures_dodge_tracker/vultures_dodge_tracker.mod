return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`vultures_dodge_tracker` encountered an error loading the Darktide Mod Framework.")

		new_mod("vultures_dodge_tracker", {
			mod_script       = "vultures_dodge_tracker/vultures_dodge_tracker",
			mod_data         = "vultures_dodge_tracker/vultures_dodge_tracker_data",
			mod_localization = "vultures_dodge_tracker/vultures_dodge_tracker_localization",
		})
	end,
	packages = {},
}
