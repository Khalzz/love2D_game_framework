local love = require("love")

--[[
    This module is dedicated for button rendering and handling
    the main way of use is setting all this functions in different places of your code

    for using this module you need to add [local buttonSystem = require("ui.button")] without the [] at the top of your file

    To use it you need to follow this structure:
    - in love.draw() run buttonSystem.render(buttons) 
    - in love.update() run buttonSystem.update(MouseX, MouseY)
    - in love.mousepressed() run buttonSystem.handleClick(x, y)

    The actual structure for buttons brought to buttonRendering is something like this:
    local buttons = {
    {
        visibility = {
            visible = true,
        },
        rect = {
            x = (width / 2) - (100 / 2),
            y = (height / 2) - ((love.graphics.getFont():getHeight("Play") + 20) / 2),
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
                print("clicked")
            end,
        },
    }
]]--

local local_buttons = {}

--[[
    # Button Loading
    This function is used to load the button in the local_buttons table
    @param button: table - The button to load
]]--
local function clearButtons()
    local_buttons = {}
end

local function buttonLoading(button)
    table.insert(local_buttons, button)
end

local function buttonRendering()
    if local_buttons then
        for i, button in ipairs(local_buttons) do
            -- shadow
            if button.shadow then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", button.rect.x + button.shadow.position.x, button.rect.y + button.shadow.position.y, button.rect.width, button.rect.height, button.border.border_radius)
            end

            -- button shape
            love.graphics.setColor(button.rect.color)
            love.graphics.rectangle("fill", button.rect.x, button.interactivity.clicked and button.rect.y + 3 or button.rect.y, button.rect.width, button.rect.height, button.border.border_radius)
            
            -- border
            love.graphics.setColor(button.border.color)
            love.graphics.rectangle("line", button.rect.x, button.interactivity.clicked and button.rect.y + 3 or button.rect.y, button.rect.width, button.rect.height, button.border.border_radius)

            -- button text
            love.graphics.setFont(button.label.font)
            love.graphics.setColor(button.label.color)
            love.graphics.printf(button.label.text, button.rect.x, button.interactivity.clicked and (button.rect.y + (button.rect.height / 2) - (love.graphics.getFont():getHeight(button.label.text) / 2)) + 2 or button.rect.y + button.rect.height / 2 - love.graphics.getFont():getHeight(button.label.text) / 2, button.rect.width, "center")
        end
    end
end

local function updateButton(mouseX, mouseY)
    for i, button in ipairs(local_buttons) do
        if mouseX > button.rect.x and mouseX < button.rect.x + button.rect.width and mouseY > button.rect.y and mouseY < button.rect.y + button.rect.height then
            button.interactivity.hovered = true
            if love.mouse.isDown(1) then
                button.interactivity.clicked = true
            else
                button.interactivity.clicked = false
            end
        else
            button.interactivity.hovered = false
            button.interactivity.clicked = false
        end
    end
end

local function handleButtonClick(x, y)
    for i, btn in ipairs(local_buttons) do
        if x > btn.rect.x and x < btn.rect.x + btn.rect.width and y > btn.rect.y and y < btn.rect.y + btn.rect.height then
            btn.interactivity.onclick()
        end
    end
end

return {
    clear = clearButtons,
    load = buttonLoading,
    render = buttonRendering,
    handleClick = handleButtonClick,
    update = updateButton,
}