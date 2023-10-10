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
