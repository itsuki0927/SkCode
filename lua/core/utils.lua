local M = {}

local cmd = vim.cmd

M.load_config = function()
	local conf = require("core.default_config")

	return conf
end

M.map = function(mode, keys, command, opt)
	local options = { noremap = true, silent = true }
	if opt then
		options = vim.tbl_extend("force", options, opt)
	end

	-- all valid modes allowed for mappings
	-- :h map-modes
	local valid_modes = {
		[""] = true,
		["n"] = true,
		["v"] = true,
		["s"] = true,
		["x"] = true,
		["o"] = true,
		["!"] = true,
		["i"] = true,
		["l"] = true,
		["c"] = true,
		["t"] = true,
	}

	-- helper function for M.map
	-- can gives multiple modes and keys
	local function map_wrapper(sub_mode, lhs, rhs, sub_options)
		if type(lhs) == "table" then
			for _, key in ipairs(lhs) do
				map_wrapper(sub_mode, key, rhs, sub_options)
			end
		else
			if type(sub_mode) == "table" then
				for _, m in ipairs(sub_mode) do
					map_wrapper(m, lhs, rhs, sub_options)
				end
			else
				if valid_modes[sub_mode] and lhs and rhs then
					vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
				else
					sub_mode, lhs, rhs = sub_mode or "", lhs or "", rhs or ""
					print(
						"Cannot set mapping [ mode = '"
							.. sub_mode
							.. "' | key = '"
							.. lhs
							.. "' | cmd = '"
							.. rhs
							.. "' ]"
					)
				end
			end
		end
	end

	map_wrapper(mode, keys, command, options)
end

M.packer_lazy_load = function(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end

-- 高亮函数

-- 定义背景
-- @param
M.bg = function(group, col)
	cmd("hi " .. group .. " guibg=" .. col)
end

M.fg = function(group, col)
	cmd("hi " .. group .. " guifg=" .. col)
end

M.fg_bg = function(group, fgcol, bgcol)
	cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

M.override_req = function(name, default_req)
	local override = load_config().plugins.default_plugin_config_replace[name]

	local result = default_req

	if override ~= nil then
		result = override
	end

	if string.match(result, "^%(") then
		result = result:sub(2)
		result = result:gsub("%)%.", "').", 1)
		return "require('" .. result
	end
	return "require('" .. result .. "')"
end

return M
