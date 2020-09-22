print("Wait for data")
rednet.open("right")
id,msg,prot = rednet.receive()
print("SID: ",id," Prot: ",prot)

--get storage data and show index
lagermtx =  textutils.unserialize(msg)

--display on monitor
   local mon = peripheral.wrap("top")
    local count = 1
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Storage Info")
    for i=1,#lagermtx do
	    for j=1,#lagermtx[i] do
	        count = count + 1
	        mon.setCursorPos(1,count)
	        mon.write("Chest: ")
	        mon.write(lagermtx[i][j].x)
	        mon.write(" | ")
	        mon.write(lagermtx[i][j].y)
	        --display items
	        for k=2,#lagermtx[i][j].items do
	        	count = count + 1
	        	mon.setCursorPos(1,count)
	        	mon.write("   ")
	        	mon.write(lagermtx[i][j].items[k].count)
	        	mon.write(" x ")
	        	--remove minercaft: ore other mod directions
	        	longname = lagermtx[i][j].items[k].name
	        	name = string.sub(longname,string.find(longname,":")+1,string.len(longname))
	        	mon.write(name)
    		end
	    end
	end

shell.run("empf_lagermtx")