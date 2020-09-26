print("Wait for data")
rednet.open("left")

id,msg,prot = rednet.receive()
print("SID: ",id," Prot: ",prot)

--get blueprint data
blueprint =  textutils.unserialize(msg)

local blocks_cant_placed = 0
sizex = blueprint[1].size.x
sizey = blueprint[1].size.y
sizez = blueprint[1].size.z
print("Size: x:"..sizex.." | y:"..sizey.." | z:"..sizez)

local count,placed = 0,0

if prot == "build" then
    	print("blueprint received")
    	
    	for i=2,#blueprint do
    		count = count +1
    	end

    	--bauen
    	--action per layer
    	for y=0,sizey-1 do
	    	--actions per row
	    	for x=0,sizex-1 do
	    		turtle.turnRight()
	    		print("Start row "..x)
	    		print(placed.."/"..count.." blocks placed")
	    		smsg = placed.."/"..count.." blocks placed"
	    		rednet.broadcast(smsg,"build_status")
	    		--step each block per row
	    		for z=0,sizez-1 do
	    			--scan all blueprint blocks if chords match active position 2 index cause first blueprint index is size
	    			for i=2,#blueprint do
		    			if x==blueprint[i].x and z == blueprint[i].z and y == blueprint[i].y then
		    				--scan all inventory block if they match blueprint id
		    				for s=1,16 do
		    					turtle.select(s)
		    					item_data = turtle.getItemDetail()
		    					if item_data then
			    					if item_data.name == blueprint[i].id and item_data.damage == blueprint[i].damage then
			    						turtle.placeDown()
			    						placed = placed +1
			    						break;
			    					elseif item_data.name ~= blueprint[i].id and s == 16 or item_data.damage ~= blueprint[i].damage and s == 16 then
			    						blocks_cant_placed = blocks_cant_placed+1
			    					end
			    				end
		    				end
		    				turtle.select(1)
		    			end
	    			end
	    			turtle.forward()
	    		end

	    		turtle.turnLeft()
	    		turtle.turnLeft()
	    		--go back
	    		for z=0,sizez-1 do
	    			turtle.forward()
	    		end
	    		turtle.turnRight()
	    		turtle.forward()
	    	end

	    	--back to start pos
	    	for x=0,sizex-1 do
	    		turtle.back()
	    	end
	    	
	    	--next layer
	    	turtle.up()
	    end
    	
    	
    
end
--substract cuase the turtle walks where no blcoks should be
blocks_cant_placed = blocks_cant_placed - (sizex+sizez+1)
print(blocks_cant_placed.." blocks cant be placed")
print("finished")
shell.run("build")
