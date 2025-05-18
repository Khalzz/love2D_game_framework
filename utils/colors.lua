-- This file contains all the colors used in the game

local function hexToColor(hex)
    -- Remove # if present
    hex = hex:gsub("#", "")
    
    -- Handle different hex format lengths
    if #hex == 3 then
        -- Short format (#RGB)
        local r = tonumber("0x"..hex:sub(1,1)) / 15
        local g = tonumber("0x"..hex:sub(2,2)) / 15
        local b = tonumber("0x"..hex:sub(3,3)) / 15
        return {r, g, b, 1}
    elseif #hex == 6 then
        -- Standard format (#RRGGBB)
        local r = tonumber("0x"..hex:sub(1,2)) / 255
        local g = tonumber("0x"..hex:sub(3,4)) / 255
        local b = tonumber("0x"..hex:sub(5,6)) / 255
        return {r, g, b, 1}
    elseif #hex == 8 then
        -- Format with alpha (#RRGGBBAA)
        local r = tonumber("0x"..hex:sub(1,2)) / 255
        local g = tonumber("0x"..hex:sub(3,4)) / 255
        local b = tonumber("0x"..hex:sub(5,6)) / 255
        local a = tonumber("0x"..hex:sub(7,8)) / 255
        return {r, g, b, a}
    else
        error("Invalid hex color format")
    end
end

-- UI Colors
local colors = {
    base_background_color = {0.40784313725490196, 0.615686274509804, 0.41568627450980394, 1},
    base_button_color = {0.984313725490196, 0.9450980392156862, 0.7803921568627451, 1},
    darker_button_color = {0.5725490196078431, 0.5137254901960784, 0.4549019607843137, 1},
    light_red = hexToColor("#fb4934"),
    medium_red = hexToColor("#cc241d"),
    obscure_red = hexToColor("#9d0006"),
    
    dark_fg0 = hexToColor("#282828"),
    dark_fg1 = hexToColor("#3c3836"),
    dark_fg2 = hexToColor("#504945"),
    dark_fg3 = hexToColor("#665c54"),
    dark_fg4 = hexToColor("#7c6f64"),

}




return colors