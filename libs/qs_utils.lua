--[[
	QuickSlide Utils
	Copyright (C) 2023  slimit75

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as published
	by the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Affero General Public License for more details.
]]--

function print_info(string)
    term.blit("INFO: ","33338f","ffffff")
    print(string)
end

function print_warn(string)
    term.blit("WARN: ","44448f","ffffff")
    print(string)
end

function print_error(string)
    term.blit("ERROR: ","fffff8f","eeeeeff")
    print(string)
end

function qs_run(code)
	local func, msg = load(code, nil, 't', _G.qs_env)
	if not func then
        print_error(msg)
		return nil, msg
	end
	return xpcall(func, function(err)
        term.redirect(term.native())
        print_error(err)
    end)
end

function refresh_monitor(mon)
	for i = 0, 15 do
		mon.setPaletteColour(2^i, term.nativePaletteColor(2^i))
	end

	mon.setBackgroundColor(colors.black)
	mon.clear()
	mon.setCursorPos(1, 1)
end