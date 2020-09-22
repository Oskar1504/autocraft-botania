local count = 0
local amount = 0
function getitems(...)
    args = {...}
    --go to row
    for i=1,args[1] do
        turtle.forward()
    end
    turtle.turnRight()
    --grab items
    for i=1,args[2] do
        turtle.forward()
        turtle.suckDown(args[i+2])
    end
    turtle.turnRight()
    turtle.turnRight()
    --goes back to line
    for i=1,args[2] do
        turtle.forward()
    end
    turtle.turnRight()
    --gos back
    for i=1,args[1] do
        turtle.back()
    end
end

function send_status(name)
	msg = "Crafted:"..count.."/"..amount.." "..name.."//".."Fuellevel:"..turtle.getFuelLevel()
	rednet.send(67,msg,"status")
end

function getamount(msg)
    start = string.find(msg," ")
    ende = string.find(msg," ",start+1)
    output = string.sub(msg,start+1,ende-1)
    return output
end

function check_fuel()
    local fuel = turtle.getFuelLevel()
    if fuel < 100 then
        turtle.suckUp()
        turtle.refuel(64)
    end
    print(fuel)
end

function craft(name)
	--go back over altar
    for i=1,4 do
        turtle.back()
    end
	--drop all items
	for i=1,12 do
	    turtle.select(i)
	    turtle.dropDown()
	end
	turtle.select(1)
	--collect items
	redstone.setAnalogOutput("left",14)
	os.sleep(1)
	redstone.setAnalogOutput("left",0)
	count = count + 1
	send_status(name)
end

function water()
	turtle.forward()
	turtle.forward()
	turtle.suckDown(1)
	turtle.forward()
	turtle.suckDown(1)
	turtle.forward()
end


check_fuel()
function daisy()
    --get water and seed
    water()
    --getitems <row> <amount different items> <item1 amount> <item2 amount> ..
   getitems(1,1,4)
    --drop items
    craft("daisy")
    check_fuel()
    
end

function endoflame()
    --get water and seed
    water()
   	getitems(2,3,2,1,1)
    --drop items
    craft("endoflame")
    check_fuel()
end


rednet.open("left")


local sender,msg,prot =  rednet.receive()
print("SenderID:",sender,"Protocol:",prot)

print("Message:",msg)

if prot == "command" then
    if string.find(msg,"craft") then
        --get amount 7 is the string index
        amount = tonumber(getamount(msg))

        if string.find(msg,"daisy") then
             print("Craft:",amount,"Daisy")
             for i=1,amount do
                 daisy()
             end          
        elseif string.find(msg,"endoflame") then
             print("Craft:",amount,"endoflame")
             for i=1,amount do
                 endoflame()
             end          
        end
    end
end


shell.run("main.lua")
