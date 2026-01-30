local audio_folder = "audio/"
local audio_list = {}

local sounds = {
    uderehee = {"uderehee.mp3", "static"},

    -- https://pixabay.com/music/video-games-waiting-time-175800/
    background_music = {"waiting-time.mp3", "stream"}
}

for key, sound in pairs(sounds) do
    audio_list[key] = love.audio.newSource(audio_folder .. sound[1], sound[2])
end

return audio_list
