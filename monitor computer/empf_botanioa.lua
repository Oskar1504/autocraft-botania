print("This ID:",os.getComputerID())
local mon = peripheral.wrap("top")


rednet.open("left")
sender,msg,prot = rednet.receive()
mon.clear()
mon.setCursorPos(1,1)
mon.write("SenderID:")
mon.write(sender)
mon.write(" | Prot:")
mon.write(prot)
mon.setCursorPos(1,2)

local t = {0}
local i = 0
	while true do
	    i = string.find(msg, "//",i+1)
	    if i == nil then break end
	    table.insert(t,i)
	end

for i=1,#t do
	    if t[i] == 0 then
	        zeile = string.sub(msg,t[i],t[i+1]-1)
	    elseif t[i+1] ~= nil then
	        zeile = string.sub(msg,t[i]+2,t[i+1]-1)
	    else
	        zeile = string.sub(msg,t[i]+2,string.len(msg))
	    end
	    print(t[i])
		mon.setCursorPos(1,i+2)
	    mon.write(zeile)
	end

--restarted program
print("Message received")
shell.run("empf_botanioa")
