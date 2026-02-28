local GameState = require "GameState"

---@class LANGTable
---@field title LanguageEntry
---@field quit LanguageEntry
---@field start LanguageEntry
---@field language LanguageEntry
---@field level1 LanguageEntry
---@field level2 LanguageEntry
---@field level3 LanguageEntry
---@field scoreText LanguageEntry
---@field roundScore LanguageEntry
local LANG = {
    title = {en="Poinker", sl="Poinker"},
    quit = {en="Quit", sl="Zapusti"},
    start = {en="Start", sl="Začni"},
    language = {en="Language", sl="Jezik"},

    level1 = {en="Level 1", sl="Stopnja 1"},
    level2 = {en="Level 2", sl="Stopnja 2"},
    level3 = {en="Level 3", sl="Stopnja 3"},
    scoreText = {en="Score at least:", sl="Doseži vsaj:"},
    roundScore = {en="Round\nScore", sl="Točke\nstopnje"}
}

---returns the language entry for the current level 
---@return LanguageEntry
function LANG:getCurrentLevelText()
    if GameState.level == 1 then
        return self.level1
    elseif GameState.level == 2 then
        return self.level2
    elseif GameState.level == 3 then
        return self.level3
    else
        error("No current level text found")
    end
end

return LANG