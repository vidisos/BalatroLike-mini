local audio_folder = "src/audio/"

local newSource = love.audio.newSource

local Audio = {
    -- https://pixabay.com/music/video-games-waiting-time-175800/
    background_music = newSource(audio_folder .. "waiting_time.mp3", "stream"),

    sfx = {
        card_select = newSource(audio_folder .. "card_select.mp3", "static"),
        card_deselect = newSource(audio_folder .. "card_deselect.mp3", "static"),

        spark_select = newSource(audio_folder .. "spark_select.mp3", "static"),
        spark_click = newSource(audio_folder .. "spark_click.mp3", "static"),
        spark_remove = newSource(audio_folder .. "spark_remove.mp3", "static"),

        button_click = newSource(audio_folder .. "button_click.mp3", "static"),
        button_click_back = newSource(audio_folder .. "button_click_back.mp3", "static"),

        game_over = newSource(audio_folder .. "game_over.mp3", "static"),
        game_won = newSource(audio_folder .. "game_won.mp3", "static"),
        round_won = newSource(audio_folder .. "round_won.mp3", "static")
    }
}

---plays a sound with the input volume
---@param source any
function Audio:playSound(source)
    local instance = source:clone()
    instance:play()
end

function Audio:setSoundVolume(volume)
    for sound_name in pairs(self.sfx) do
        self.sfx[sound_name]:setVolume(volume)
    end
end

function Audio:setMusicVolume(volume)
    self.background_music:setVolume(volume)
end

function Audio:playBackgroundMusic()
    self.background_music:setLooping(true)
    self.background_music:play()
end

return Audio
