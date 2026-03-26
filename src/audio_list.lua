local audio_folder = "src/audio/"

local newSource = love.audio.newSource

local audio_list = {
    -- https://pixabay.com/music/video-games-waiting-time-175800/
    background_music = newSource(audio_folder .. "waiting-time.mp3", "stream")
}

return audio_list
