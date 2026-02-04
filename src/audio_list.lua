local audio_folder = "audio/"

local audio_list = {
    uderehee = love.audio.newSource(audio_folder .. "uderehee.mp3", "static"),

    -- https://pixabay.com/music/video-games-waiting-time-175800/
    background_music = love.audio.newSource(audio_folder .. "waiting-time.mp3", "stream")
}

return audio_list
