
--function clearTable2(t)
--for k in pairs(t) do
--t[k] = nil
--end
--end

--function sleep (a) 
    --local sec = tonumber(os.clock() + a); 
    --while (os.clock() < sec) do 
    --end 
--end

--sleep(20)
// Clear pervious data if it exists
--InfMap.clear_parsed_objects()
--clearTable2(InfMap.parsed_object_names)
// Create a matrix to scale the model
local mat = Matrix()
mat:SetTranslation(Vector(0, 0, 0))		// Sets the models position
mat:SetAngles(Angle(0, 0, 0))			// Sets the models rotation
mat:SetScale(Vector(1, 1, 1) * 39.3701)	// Conversion from Meters to Inches
//Entity(1):SetPos(Vector(-3357, -1544, -600)) 
// visuals = 1
// collision = 2
--This table defines the objects for culling, put the objects in the same order as they are parsed.
--name is the chunk offset vector, the objname is the same obj name as for the parse function, this is also needed or the code won't work.
// nocull Shader = No backface culling
// alphatest Shader = Enable transparency on the model

// Create our visual model, note the "1" which means it is ONLY visual
InfMap.parse_obj("treesnshitcombined", mat, 1, "alphatest")
InfMap.parse_obj("buildingsandshitcombined", mat, 1, "alphatest")
//InfMap.parse_obj("0_0_0", mat, 1, "nocull")
//InfMap.parse_obj("0_1_0", mat, 1, "nocull")
//InfMap.parse_obj("test", mat, 3, "nocull")
//InfMap.parse_obj("nfsmw2", mat, 3, "nocull")
//InfMap.parse_obj("worldrwd2vis", mat, 1, "nocull alphatest")
//InfMap.parse_obj("worldrcp", mat, 1, "nocull alphatest")
//InfMap.parse_obj("rosewood2collider", mat, 2)

// Create our physical model, note the "2" which means it is ONLY collision
// Because it is collision, we do not need the shader option
//InfMap.parse_obj("cloud_collision", mat, 2)
    
// If you wish to have collision AND visuals combined, you can do so by using "0" or "3"
// Example: InfMap.parse_obj("cloud", mat, 3, "nocull alphatest"

