-- This is atransition generation module
local love = require("love")

local transition = {}

--[[
    -- Direction:
    { 
        bars_orientation = "vertical" or "horizontal" // defines if the bars are set horizontally or vertically
        bars_direction = "top" or "bottom" or "left" or "right" // defines if the bars are set on the top, bottom, left or right of the screen
        opening = true or false // defines if the bars starts covering the screen or not
        multiplier = -1 to 1 for normal movement if horizontal 1 is left if vertical 1 is up
    }
]]--

local function loadBars(quantity_of_bars, screen_width, screen_height, time_between_bars, direction, on_complete)
    transition.bars = {}
    transition.time_between_bars = time_between_bars
    transition.reference_time_between_bars = time_between_bars
    transition.current_element = 0
    transition.window_width = screen_width
    transition.completed = false
    transition.direction = direction
    transition.on_complete = {
        executable = on_complete,
        activated = false,
    }

    print(direction.bars_orientation)

    if direction.bars_orientation == "horizontal" then
        for i = 0, quantity_of_bars do
            transition.bars[i] = {
                x = 0,
                y = (screen_height / quantity_of_bars) * i,
                width = direction.opening and 0 or transition.window_width,
                height = screen_height / quantity_of_bars,
                color = {1, 1, 1, 1},
                time_between_bars = time_between_bars,
            }
        end
    elseif direction.bars_orientation == "vertical" then
        for i = 0, quantity_of_bars do
            transition.bars[i] = {
                x = (screen_width / quantity_of_bars) * i,
                y = 0,
                width = screen_width / quantity_of_bars,
                height = screen_height,
                color = {1, 1, 1, 1},
                time_between_bars = time_between_bars,
            }
        end
    end
    return transition
end

local function generateTransition(type, screen_width, screen_height, divisions, time_between_bars, direction, on_complete)
    if type == "bars" then
        return loadBars(divisions, screen_width, screen_height, time_between_bars, direction, on_complete)
    end
end

local function updateTransition(dt)
    if transition.completed then return end
    
    local target_width = 0
    local transition_speed = 2
    local all_bars_completed = true
    
    for i = 0, #transition.bars do
        transition.time_between_bars = transition.time_between_bars - dt
        
        if transition.time_between_bars <= 0 then
            transition.current_element = transition.current_element + 1
            transition.time_between_bars = transition.reference_time_between_bars
        end

        if i < transition.current_element then
            if transition.direction.opening then
                if transition.direction.bars_direction == "horizontal" then
                    transition.bars[i].width = transition.bars[i].width + (transition.window_width - transition.bars[i].width) * dt * transition_speed * (10)
                elseif transition.direction.bars_direction == "vertical" then
                    transition.bars[i].height = transition.bars[i].height + (transition.window_height - transition.bars[i].height) * dt * transition_speed * (10)
                end
                if transition.bars[i].width < transition.window_width - 1 then
                    all_bars_completed = false
                end
            else
                if transition.direction.bars_direction == "horizontal" then
                    transition.bars[i].width = math.max(0, transition.bars[i].width - ((transition.bars[i].width) * transition.direction.multiplier) * dt * transition_speed * (10))
                elseif transition.direction.bars_direction == "vertical" then
                    transition.bars[i].height = math.max(0, transition.bars[i].height - ((transition.bars[i].height) * transition.direction.multiplier) * dt * transition_speed * (10))
                end
                if transition.bars[i].width > 0.1 then
                    all_bars_completed = false
                end
            end
        else
            all_bars_completed = false
        end
    end

    if all_bars_completed and not transition.completed and not transition.on_complete.activated then
        transition.completed = true
        if transition.on_complete.executable then
            transition.on_complete.executable()
            transition.on_complete.activated = true
        end
    end
end

local function drawTransition()
    for i, bar in pairs(transition.bars) do
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", bar.x, bar.y, bar.width, bar.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return {
    loadTransition = generateTransition,
    update = updateTransition,
    draw = drawTransition
}