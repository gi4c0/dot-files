local shorten_buf_name = function(path)
	local name = vim.fs.basename(path)
	if not name or string.len(name) == 0 and path:sub(1, 6) == "oil://" then
		local cwd = vim.loop.cwd()
		if not cwd then
			name = path:sub(7)
		else
			name = path:sub(string.len(cwd) + 7)
		end
	end
	if not name or string.len(name) == 0 and path:sub(1, 11) == "fugitive://" then
		name = "git"
	end
	if not name or string.len(name) == 0 then
		name = path
	end
	return name
end

return {
    "cbochs/grapple.nvim",
    enabled = true,
    opts = {
        scope = "git_branch", -- also try out "git_branch"
        ---See :h nvim_open_win
        ---@type grapple.vim.win_opts
        win_opts = {
            -- Can be fractional
            width = 0.6,
            height = 0.3,
            -- row = 0.5,
            -- col = 0.5,

            relative = "editor",
            border = "single",
            focusable = false,
            style = "minimal",

            title = "Grapple", -- fallback title for Grapple windows
            title_pos = "center",
            title_padding = " ", -- custom: adds padding around window title

            -- footer = "", -- disable footer
            footer_pos = "center",
        },
    },
    keys = {
        { "<leader><leader>", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
        { "<leader><C-t>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

        { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
        { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
        { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
        { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
        { "<leader>5", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

        { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },

    config = function (_, opts)
        local grapple = require("grapple")
        grapple.setup(opts)

        -- local update_showtabline = function()
            --     local tags = grapple.tags()
            --     if tags and tags[1] then
            --         vim.opt.showtabline = 2
            --     else
            --         vim.opt.showtabline = 0
            --     end
            --     vim.cmd.redrawtabline()
            -- end
            --
            -- vim.api.nvim_create_autocmd("User", {
                --     pattern = "GrappleUpdate",
                --     group = vim.api.nvim_create_augroup("grapple-update", { clear = true }),
                --     callback = update_showtabline,
                -- })
                --
                -- _G.tabline = function()
                    --     local current_tag = grapple.find({ path = vim.fn.bufname() })
                    --
                    --     local line = ""
                    --
                    --     local tags = grapple.tags()
                    --     if not tags then
                    --         return ""
                    --     end
                    --     for i, tag in ipairs(tags) do
                    --         local is_current = current_tag and current_tag.path == tag.path
                    --         local tag_string = tag.name
                    --         if not tag_string or string.len(tag_string) == 0 then
                    --             tag_string = shorten_buf_name(tag.path)
                    --         end
                    --         if is_current then
                    --             line = line .. "%#TablineSel#  " .. i .. " " .. tag_string .. "  %#Tabline#"
                    --         else
                    --             line = line .. "%#Tabline#  " .. i .. " " .. tag_string .. "  %#Tabline#"
                    --         end
                    --     end
                    --
                    --     if not current_tag then
                    --         local cur_name = shorten_buf_name(vim.fn.bufname())
                    --         if cur_name and string.len(cur_name) > 0 then
                    --             line = line .. "%#Tabline#  %#TablineSel# %#TablineFill# " .. cur_name .. "  %#Tabline#"
                    --         end
                    --     end
                    --
                    --     return line
                    -- end
                    --
                    -- vim.opt.tabline = "%!v:lua.tabline()"
                    -- update_showtabline()
                end
            }
