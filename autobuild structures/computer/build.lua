

--get lager data and show index#
local args = {...}
local file = args[1]..".txt"
local blueprint =  textutils.unserialize(fs.open(file,"r").readAll())

--display on monitor
   local mon = peripheral.wrap("top")
    local count = 0
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Storage Info")
    mon.setCursorPos(1,2)
    mon.write("Size: ")
    mon.write(blueprint[1].size.x)
    mon.write(" | ")
    mon.write(blueprint[1].size.y)
    mon.write(" | ")
    mon.write(blueprint[1].size.z)
    --second index couse in the first is the size without id => err
    for i=2,#blueprint do
	        count = count + 1
	end

    mon.setCursorPos(1,3)
    mon.write("Blocks needs to be placed")
    mon.write(count)
    --send blueprint
	msg = textutils.serialize(blueprint)
	rednet.open("right")
	rednet.broadcast(msg,"build")

	shell.run("catch_build_status")