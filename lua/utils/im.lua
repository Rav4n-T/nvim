-- Reference:
-- https://www.cnblogs.com/yf-zhao/p/16018481.html
-- https://zhuanlan.zhihu.com/p/425951648

local M = {}

M.setup = function()
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		-- Windows 系统
		local ffi = require("ffi")

		ffi.cdef([[
    typedef unsigned int UINT, HWND, WPARAM;
    typedef unsigned long LPARAM, LRESULT;
    LRESULT SendMessageA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
    HWND ImmGetDefaultIMEWnd(HWND unnamedParam1);
    HWND GetForegroundWindow();
]])

		local user32 = ffi.load("user32.dll")
		local imm32 = ffi.load("imm32.dll")

		local ime_hwnd
		local ime_group = vim.api.nvim_create_augroup("ime_toggle", { clear = true })

		-- Get ime control's hwnd after InsertEnter or CmdlineEnter
		-- to ensure getting correct foregroundwindow
		vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
			group = ime_group,
			once = true,
			desc = "Get ime control hwnd attached to nvim window",
			callback = function()
				ime_hwnd = imm32.ImmGetDefaultIMEWnd(user32.GetForegroundWindow())
			end,
		})

		local WM_IME_CONTROL = 0x283
		local IMC_GETCONVERSIONMODE = 0x001
		local IMC_SETCONVERSIONMODE = 0x002 -- It's said this value differs on different ime, I'm not sure
		local ime_mode_ch = 1025
		local ime_mode_en = 0

		local function set_ime_mode(mode)
			return user32.SendMessageA(ime_hwnd, WM_IME_CONTROL, IMC_SETCONVERSIONMODE, mode)
		end

		local function get_ime_mode()
			return user32.SendMessageA(ime_hwnd, WM_IME_CONTROL, IMC_GETCONVERSIONMODE, 0)
		end

		vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
			group = ime_group,
			desc = "Toggle ime to English mode on normal mode",
			callback = function()
				if ime_mode_ch == get_ime_mode() then
					set_ime_mode(ime_mode_en)
				end
			end,
		})
	else
		-- 类 Unix 系统（Linux、macOS）
		vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
			callback = function()
				local input_status = tonumber(vim.fn.system("fcitx5-remote"))
				if input_status == 2 then
					vim.fn.system("fcitx5-remote -c")
				end
			end,
		})
	end
end

return M
