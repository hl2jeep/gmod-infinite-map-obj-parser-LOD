function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
if game.GetMap() == "gm_infmap_nfsmwtesting" then
    print("firstload")
    include("donotautorun/loadobject111.lua")
    print("going to sleep for 10 secs")
    sleep(10)
    print("awake, running again")
    include("donotautorun/loadobject111.lua")
    print("finished")
end