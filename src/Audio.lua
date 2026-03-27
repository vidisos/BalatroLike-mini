local audio_folder = "src/audio/"
local newSource = love.audio.newSource

local Audio = {
    -- https://pixabay.com/music/video-games-waiting-time-175800/
    background_music = newSource(audio_folder .. "waiting-time.mp3", "stream")
}

---plays a sound with the input volume
---@param source any
---@param volume number
function Audio:playSound(source, volume)
    local instance = source:clone()
    instance:setVolume(volume or 1)
    instance:play()
end

return Audio
