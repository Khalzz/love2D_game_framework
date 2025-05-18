local love = require("love")

ButtonSystem = require("ui.button")
Width, Height = love.graphics.getDimensions()
MouseX, MouseY = love.mouse.getPosition()

TransitionSystem = require("ui.transitions")
SceneManager = require("utils.scene_manager")

function love.load()
    SceneManager:register("main_menu", require("scenes.main_menu"))
    SceneManager:register("level_selection", require("scenes.level_selection"))
    SceneManager:switch("main_menu")
    love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.draw()
    SceneManager[SceneManager.current_scene].draw()
    ButtonSystem.render()
    TransitionSystem.draw()
end

function love.update(dt)
    MouseX, MouseY = love.mouse.getPosition()
    SceneManager[SceneManager.current_scene].update(dt)
    ButtonSystem.update(MouseX, MouseY)
    TransitionSystem.update(dt)
end

function love.mousepressed(x, y)
    ButtonSystem.handleClick(x, y)
end
