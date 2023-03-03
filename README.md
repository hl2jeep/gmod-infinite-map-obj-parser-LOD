# gmod-infinite-map-obj-parser-LOD
A pretty simple LOD system for Mee12345's infinite map obj parser



## Overview
This is an example map with the obj LOD system.
LOD gets called only when the client player moves from their current chunk,
this is to prevent memory leaks.

### lod working:
![alt text](https://github.com/hl2jeep/gmod-infinite-map-obj-parser-LOD/blob/main/gifs/pt1.gif?raw=true)

### different lod position for each obj file:
![alt text](https://github.com/hl2jeep/gmod-infinite-map-obj-parser-LOD/blob/main/gifs/pt2.gif?raw=true)

The setup guide below assumes you are already familiar with the some of the obj parser

if you are not familiar with the obj parser, [Click here to go to mee's obj parser example.](https://github.com/Mee12345/Infinite-Map-OBJ-Example)


## Setup/Usage
To set up your own map to use this there are a couple of things to take note of.

Here are the scripts, the code will be in the files already, but i have added comments to explain what needs to go where.

### it is important that you try to read this carefully as else it can cause some issues.

#### autorun/reloadobjloader.lua
```
// this sleep function is required because of a bug where you have to reload the obj parser.
function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
// the "gm_infmap_objexample" should be the same as your bsp file's name.
if game.GetMap() == "gm_infmap_objexample" then
    print("firstload")
    // include loads the obj loader file in donotautorun folder,
    // i recommend naming that file "loadobject" followed by your map name.
    include("donotautorun/loadobjectobjexample.lua")
    print("going to sleep for 10 secs")
    sleep(10)
    print("awake, running again")
    include("donotautorun/loadobjectobjexample.lua")
    print("finished")
end
// if you want to have more than one map,
// just copy the whole if statement and fill in what is needed.
```
#### donotautorun/loadobjectobjexample
```
// Clear pervious data if it exists
--InfMap.clear_parsed_objects()
// Create a matrix to scale the model
local mat = Matrix()
mat:SetTranslation(Vector(0, 0, 0))		// Sets the models position
mat:SetAngles(Angle(0, 0, 0))			// Sets the models rotation
mat:SetScale(Vector(1, 1, 1) * 39.3701)	// Conversion from Meters to Inches
// visuals = 1
// collision = 2
// nocull Shader = No backface culling
// alphatest Shader = Enable transparency on the model

// Create our visual model, note the "1" which means it is ONLY visual
InfMap.parse_obj("0_0_0", mat, 1, "nocull")
// "0_0_0" is the name of the model without the obj prefix, keep that in mind.
// if you have multiple objects here, remember the order they are in, we will need it later.

// Create our physical model, note the "2" which means it is ONLY collision
// Because it is collision, we do not need the shader option
//InfMap.parse_obj("cloud_collision", mat, 2)
    
// If you wish to have collision AND visuals combined, you can do so by using "0" or "3"
// Example: InfMap.parse_obj("cloud", mat, 3, "nocull alphatest"
```
The next scripts have to be in a map folder with the same name as your map bsp.

for your own map replace "objexample" at the end with what your bsp name is.

#### infmap/gm_infmap_objexample/loadobjchunkstable

```
// don't modify this first line or it will cause problems.
InfMap.parsed_object_names = InfMap.parsed_object_names or {}

// if you have multiple objects in a obj, they cannot be culled individually,
// if you want them to be culled at a different position, seperate the objects you want into their own obj files.
// also these need to be in the same order as they are in the loadobject file.
InfMap.parsed_object_names = {
    {
        // "name" is actually the chunk position of your obj,
        // to work this out, in blender, set your grid scale to 254 
        // then switch to a topdown orthographic viewpoint and zoom out until it says 10 meters in the top left,
        // the small squares are 10 meters but the largest squares are the size of the map chunks,
        // from there figure out which square the centre of the object is and basically count the squares like a grid.
        // the world centre is always the 0,0 point, and the centre of the mesh will be always the centre chunk, regardless of its origin.
        // the last 0 in the vector is up/down and should always be 0
        name = Vector(0,0,0),
        objname = "0_0_0"
        // objname must be the same
    } // if you are adding more than one obj,
      // make sure to put a comma on the curly bracket that came before it
      // don't put a comma on the last curly bracket in the list. 
    {
        name = Vector(0,0,0),
        objname = "0_1_0"
    } // this is the last curly bracket. 
}
```
#### Here is an example of what i mean by getting the squares like a grid:
![alt text](https://i.imgur.com/NXgSZo2.png)

### cullinghelper.lua and sh_inf_obj do not need to be modified, but you need to put them in your infmap map folder!

