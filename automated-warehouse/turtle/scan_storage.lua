-- functions
function display_info()
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

end

function scan(di,dj)
    --place temp chest
    turtle.placeUp()
    
    --scan
    while turtle.suckDown() do
         x = turtle.getItemDetail()
	    print(x.name,x.count)
	     --insert into table 
		for i=1,#lagermtx[di][dj].items do
			--count up when id is the same
			if lagermtx[di][dj].items[i].name == x.name then
				lagermtx[di][dj].items[i].count = lagermtx[di][dj].items[i].count +x.count
				break
				--add new when id dont exist in table
			elseif i == #lagermtx[di][dj].items then
				table.insert(lagermtx[di][dj].items,x) 
			end
		end
        --put item in temp chest
	    turtle.dropUp()
    end

    --put scanned item form temp chest int ochest
    while turtle.suckUp() do
		turtle.dropDown()
	end

	--destroy temp chest
	turtle.digUp()
	--write the data 

	file = fs.open("lagermtx","w")
	file.write(textutils.serialize(lagermtx))
	file.close()
end

--get lager data and show index
lagermtx =  textutils.unserialize(fs.open("lagermtx","r").readAll())
--query hole sotrage matrix
--get size
xs = table.getn(lagermtx)
ys = table.getn(lagermtx[1])

print("Size:",xs," | ",ys)
print("Chests to be scanned:",xs*ys)
--move to every chest
for i=1,xs do
    turtle.forward()
    turtle.turnRight()
    for j=1,ys do
        turtle.forward()
        scan(i,j)
    end
    for j=1,ys do
        turtle.back()
    end
    turtle.turnLeft()
end
--get back to startpos
for i=1,xs do
	turtle.back()
end
display_info()
print("Complete scan")


