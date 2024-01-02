require("/libs/qs_utils")
print_info("Starting QuickSlide")
print_info("Board ID " .. os.getComputerID())

-- Sandbox
_G.qs_env = {
	term = {
		nativePaletteColor = term.nativePaletteColor,
		nativePaletteColour = term.nativePaletteColour,
		write = term.write,
		getCursorPos = term.getCursorPos,
		setCursorPos = term.setCursorPos,
		getSize = term.getSize,
		clear = term.clear,
		clearLine = term.clearLine,
		getTextColor = term.getTextColor,
		getTextColour = term.getTextColour,
		setTextColor = term.setTextColor,
		setTextColour = term.setTextColour,
		getBackgroundColor = term.getBackgroundColor,
		getBackgroundColour = term.getBackgroundColour,
		setBackgroundColor = term.setBackgroundColor,
		setBackgroundColour = term.setBackgroundColour,
		isColor = term.isColor,
		isColour = term.isColour,
		blit = term.blit,
		setPaletteColor = term.setPaletteColor,
		setPaletteColour = term.setPaletteColour,
		current = term.current
	},
	paintutils = paintutils,
		next = next,
		pairs = pairs,
		pcall = pcall,
		select = select,
		tonumber = tonumber,
		tostring = tostring,
		type = type,
		unpack = unpack,
		xpcall = xpcall,
		string = {
		byte = string.byte,
		char = string.char,
		find = string.find,
		format = string.format,
		gmatch = string.gmatch,
		gsub = string.gsub,
		len = string.len,
		lower = string.lower,
		match = string.match,
		rep = string.rep,
		reverse = string.reverse,
		sub = string.sub,
		upper = string.upper
	},
	table = {
		insert = table.insert,
		maxn = table.maxn,
		remove = table.remove,
		sort = table.sort
	},
	math = {
		abs = math.abs,
		acos = math.acos,
		asin = math.asin,
		atan = math.atan,
		atan2 = math.atan2,
		ceil = math.ceil,
		cos = math.cos,
		cosh = math.cosh,
		deg = math.deg,
		exp = math.exp,
		floor = math.floor,
		fmod = math.fmod,
		frexp = math.frexp,
		huge = math.huge,
		ldexp = math.ldexp,
		log = math.log,
		log10 = math.log10,
		max = math.max,
		min = math.min,
		modf = math.modf,
		pi = math.pi,
		pow = math.pow,
		rad = math.rad,
		sin = math.sin,
		sinh = math.sinh,
		sqrt = math.sqrt,
		tan = math.tan,
		tanh = math.tanh
	},
	textutils = textutils,
	colors = colors,
	colours = colours,
	io = nil,
	print = print,
	os = {
		version = os.version,
		getComputerID = os.getComputerID,
		computerID = os.computerID,
		getComputerLabel = os.getComputerLabel,
		computerLabel = os.computerLabel,
		clock = os.clock,
		time = os.time,
		day = os.day,
		epoch = os.epoch,
		date = os.date
	}
}

-- Load config
local conf_file = fs.open("/rom/help/intro.txt", "r")
local conf = conf_file.readAll()
conf_file.close()
conf = textutils.unserializeJSON(conf)

-- Run plugins
for i, plugin in pairs(fs.list("/plugins/")) do
	xpcall(function() 
		shell.run("/plugins/" .. plugin) 
	end, print_error)
end

-- Refresh the monitors
local monitors = { peripheral.find("monitor") }
if #monitors == 0 then
	print_warn("No monitors detected!")
end
for i, monitor in pairs(monitors) do
	monitor.setTextScale(0.5)
end

-- Refresh images list
local images = {}
for i, image in pairs(fs.list("/images/")) do
	local file = fs.open("/images/" .. image, "r")
	table.insert(images, file.readAll())
	file.close()
end
if #images == 0 then
	print_warn("No images detected!")
end

print_info("Started QuickSlide")

for i, monitor in pairs(monitors) do
	refresh_monitor(monitor)
end
  
while true do
	for i, image in pairs(images) do
		for i, monitor in pairs(monitors) do
			term.redirect(monitor)
			qs_run(image)
			term.redirect(term.native())
		end
		sleep(conf.adIntervalSec)
		if conf.sleepBeforeProceeding then
			for i, monitor in pairs(monitors) do
				refresh_monitor(monitor)
			end
			sleep(conf.blankIntervalSec)
		end
	end
end
