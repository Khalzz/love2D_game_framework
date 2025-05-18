--[[

Scene Manager

Scene manager is a functionality that will be dedicated to handle/switch and execute scene components
All these centered on the posibility of us having different levels inside the game.

]]--

local sceneManager = {
    current_scene = "main_menu",
}

-- For changing the scene being executed, we:
    -- 1. check if the scene executed exists, if not, show an error message
    -- 2. execute the scene 
function sceneManager:switch(scene_name)
    if sceneManager[scene_name] then
        ButtonSystem.clear()
        sceneManager.current_scene = scene_name
        sceneManager[scene_name].load()
    end
end

-- For adding new scenes we could manually add them to the sceneManager, but is better to do it diynamically
-- so we can do this without altering the code of the sceneManager
function sceneManager:register(scene_name, scene)
    sceneManager[scene_name] = scene
end

return sceneManager
