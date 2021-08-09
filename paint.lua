local event = require("event")
local shell = require("shell")
local fs = require("filesystem")
local args = shell.parse(...)
local component = require("component")
local gpu = component.gpu
local io = require("io")

local interface = 
"┌────────┐┌────────┐\n" ..
"│  quit  ││  save  │\n" ..
"└────────┘└────────┘"
local pixel = "█"


function parseArgs ()
	if (#args < 1) then
		error("nope")
	end
	return args[1]
end


function readClick ()
	local name, x, y = event.pull("touch")
	return x, y
end


function getCanvas (path)
	if (fs.exists(path)) then
		return readCanvas(path)
	else
		return createCanvas()
	end
end


function createCanvas ()
	local w, h = gpu.getResolution()
end


function readCanvas (path)
	todo()
end


function drawInterface ()
	local _, h = gpu.getResolution()
	local y = h - 3
	gpu.set(0, y, interface)
end


function drawCanvas (canvas)
	-- todo()
end


function saveCanvas (path)
	todo()
end


function drawPixel (x, y, canvas)
	gpu.set(x, y, pixel)
	local line = canvas[y]
	local left = line:sub(0, x - 1)
	local right = line:sub(x + 1)
	local newLine = left .. pixel .. right
	canvas[y] = newLine
end


function main ()
	local path = parseArgs()
	local canvas = getCanvas(path)
	drawCanvas(canvas)
	drawInterface()
	
	local continue = true
	while (continue) do
		local x, y = readClick()
		drawPixel(x, y, canvas)
	end
end

main()