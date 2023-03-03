InfMap.parsed_object_names = InfMap.parsed_object_names or {}
--InfMap.parsed_object_lod_list = InfMap.parsed_object_lod_list or {}
local playervecstate = Vector()
--InfMap.globallocalplayerlmao = InfMap.globallocalplayerlmao
--InfMap.stupidbullshitfuckyou = InfMap.stupidbullshitfuckyou
function clearTable(t)
    for k in pairs(t) do
      t[k] = nil
    end
end

hook.Add("PostDrawOpaqueRenderables", "this_is_retarded", function()
    if LocalPlayer().CHUNK_OFFSET != playervecstate then
        print("running")
        InfMap.parsed_object_lod_list = {}
        for i = 1, #InfMap.parsed_object_names do
            objectname2222 = InfMap.parsed_object_names[i]
            if Vector(objectname2222.name):WithinAABox(LocalPlayer().CHUNK_OFFSET - Vector(1,1,1),LocalPlayer().CHUNK_OFFSET + Vector(1,1,1)) then
                table.insert(InfMap.parsed_object_lod_list, {
                    isculled = true,
                    originobjname = objectname2222.objname
                })
                print("truecull")
            else
                table.insert(InfMap.parsed_object_lod_list, {
                    isculled = false,
                    originobjname = objectname2222.objname
        
                })
                print("falsecull")
            end
            print("objname: ", objectname2222.objname)
            print("culled: ", InfMap.parsed_object_lod_list.isculled)
            print("table first entry: ", InfMap.parsed_object_lod_list.originobjname)
            print("table second entry: ", InfMap.parsed_object_lod_list[2])
            playervecstate = LocalPlayer().CHUNK_OFFSET
        end
    end
end)
