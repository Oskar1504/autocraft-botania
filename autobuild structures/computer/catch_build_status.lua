print("Wait for data")
rednet.open("right")
id,msg,prot = rednet.receive()
print("SID: ",id," Prot: ",prot)
print("Status: ",msg)
local mon = peripheral.wrap("top")
mon.setCursorPos(1,5)
mon.write("Build status")
mon.setCursorPos(1,6)
mon.write(msg)
if prot == "build_status" then
	shell.run("catch_build_status")
end