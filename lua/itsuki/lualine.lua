local status_ok, configs = pcall(require, "lualine")

if not status_ok then
	return
end

configs.setup({
	options = {
		theme = "onedarker",
		section_separators = "",
		component_separators = "",
	},
})
