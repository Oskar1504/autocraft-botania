print("Empfanger ID:")
eid = tonumber(read())
print("protocol:")
prt = read()
print("Nachricht:")
msg = read()

rednet.open("back")
rednet.send(eid,msg,prt)
print("Message sent")

