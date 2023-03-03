function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
if game.GetMap() == "gm_infmap_objexample" then
    print("firstload")
    include("donotautorun/loadobjectobjexample.lua")
    print("going to sleep for 10 secs")
    sleep(10)
    print("awake, running again")
    include("donotautorun/loadobjectobjexample.lua")
    print("finished")
end