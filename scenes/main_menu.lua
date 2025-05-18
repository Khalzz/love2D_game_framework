local love = require("love")
local colors = require("utils.colors")

local jersey_font = love.graphics.newFont("assets/fonts/Jersey20-Regular.ttf", 14)
local background = love.graphics.newImage("assets/sprites/background.png")
local background_quad = love.graphics.newQuad(0, 0, Width, Height, 384, 192)
local background_scroll = 0
local BACKGROUND_SCROLL_SPEED = 50


-- Runs on load of the game
local function load()
    background:setWrap("repeat", "repeat")
    TransitionSystem.loadTransition("bars", Width, Height, 10, 0.3, {
        bars_orientation = "vertical",
        bars_direction = "horizontal",
        opening = false,
        multiplier = 1,
    })
    
    ButtonSystem.load({
        visibility = {
            visible = true,
        },
        rect = {
            x = (Width / 2) - (100 / 2),
            y = (Height / 2) - ((love.graphics.getFont():getHeight("Play") + 20) / 2),
            width = 100,
            height = love.graphics.getFont():getHeight("Play") + 20,
            color = colors.base_button_color,
        },
        shadow = {
            position = {
                x = 0,
                y = 3,
            },
        },
        border = {
            color = colors.dark_fg0,
            border_radius = 10,
        },
        label = {
            x = 0,
            y = 10,
            text = "Play",
            font = jersey_font,
            color = colors.dark_fg0,
        },
        interactivity = {
            hover = true,
            click = true,
            onclick = function()
                TransitionSystem.loadTransition("bars", Width, Height, 10, 0.3, {
                    bars_orientation = "horizontal",
                    bars_direction = "horizontal",
                    opening = true,
                    multiplier = 1,
                }, function()
                    SceneManager:switch("level_selection")
                end)
            end,
        },
    })
    ButtonSystem.load({
        visibility = {
            visible = true,
        },
        rect = {
            x = (Width / 2) - (60 / 2),
            y = (Height / 2) - ((love.graphics.getFont():getHeight("Play") + 20) / 2) + love.graphics.getFont():getHeight("Play") + 30,
            width = 60,
            height = love.graphics.getFont():getHeight("Play") + 10,
            color = colors.light_red,
        },
        shadow = {
            position = {
                x = 0,
                y = 3,
            },
        },
        border = {
            color = colors.obscure_red,
            border_radius = 10,
        },
        label = {
            text = "Quit",
            font = jersey_font,
            font_size = 10,
            color = colors.obscure_red,
        },
        interactivity = {
            hover = true,
            click = true,
            onclick = function()
                love.event.quit()
            end,
        },
    })
end

-- Draws stuff on the screen
local function draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(background, background_quad, 0, 0)
    love.graphics.setBackgroundColor(colors.base_background_color)
    love.graphics.setColor(colors.base_button_color)

    -- debug
    love.graphics.print(Width .. "x" .. Height, 10, 10)
    love.graphics.print("x:" .. MouseX .. " y:" .. MouseY, 10, 30)
end

local function update(dt)
    -- movement of the background
    background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt)
    background_quad:setViewport(background_scroll, background_scroll, Width, Height, 384, 192)
end

return {
    load = load,
    draw = draw,
    update = update,
}