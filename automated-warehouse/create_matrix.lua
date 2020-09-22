local lagermtx = {}


local args = {...}

if args[1] == nil or args[1] == "info" then
    print("create_matrix <x> <y>")
    return
end

function create_slot(i,j)
return {
    x=i,
    y=j,
    items={{name="none",count =0}}
    
}
end

function create_lager(x,y)
    local zeile = {}
    local mtx = {}
    for i=1,x do
        zeile = {}
        
        for j=1,y do
            
            table.insert(zeile,create_slot(i,j))
        end
        table.insert(mtx,zeile)
    end
    return mtx
end
lagermtx = create_lager(args[1],args[2])
file = fs.open("lagermtx","w")

file.write(textutils.serialize(lagermtx))
file.close()
