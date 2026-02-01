return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`vultures_dodge_tracker` encountered an error loading the Darktide Mod Framework.")

		new_mod("vultures_dodge_tracker", {
			mod_script       = "scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker",
			mod_data         = "scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker_data",
			mod_localization = "scripts/mods/vultures_dodge_tracker/vultures_dodge_tracker_localization",
		})
	end,
	packages = {},
}