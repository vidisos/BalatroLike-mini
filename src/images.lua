local image_folder = "images/"
local image_list = {}

local images = {
    settings_icon = {"settings_icon.png", {}}
}

for key, image in pairs(images) do
    image_list[key] = love.graphics.newImage(image_folder .. image[1], image[2])
end

return image_list
