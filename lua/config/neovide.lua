local opts = {
	o = {
		linespace = 0,
		guifont = "JetBrainsMono Nerd Font Mono:h14",
	},
	g = {
		neovide_scale_factor = 1.0,
		neovide_padding_top = 0,
		neovide_padding_bottom = 0,
		neovide_padding_right = 0,
		neovide_padding_left = 0,
		neovide_floating_blur_amount_x = 0.0,
		neovide_floating_blur_amount_y = 0.0,
		neovide_floating_shadow = false,
		neovide_floating_z_height = 10,
		neovide_light_angle_degrees = 45,
		neovide_light_radius = 5,
		neovide_transparency = 0.8,
		neovide_hide_mouse_typing = true,
		neovide_refresh_rate = 60,
		neovide_refresh_rate_idle = 5,
		neovide_remember_window_size = true,
		neovide_cursor_animation_length = 0.13,
		neovide_cursor_trail_size = 0.8,
		neovide_cursor_antialiasing = true,
		neovide_cursor_animate_command_line = true,
		neovide_cursor_vfx_mode = "ripple",
		neovide_cursor_vfx_opacity = 200.0,
		neovide_cursor_vfx_particle_lifetime = 1.2,
		neovide_cursor_vfx_particle_density = 7.0,
		neovide_cursor_vfx_particle_speed = 10.0,
		neovide_cursor_vfx_particle_phase = 1.5,
		neovide_cursor_vfx_particle_curl = 1.0,
	},
}

for opt_model, opts_set in pairs(opts) do
	for opt_key, opt_val in pairs(opts_set) do
		vim[opt_model][opt_key] = opt_val
	end
end
