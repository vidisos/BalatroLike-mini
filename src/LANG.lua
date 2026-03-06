local GameState = require "src.GameState"

local pixel_font = "src/fonts/Karma Suture.otf"
local pixel_font_bold = "src/fonts/Karma Future.otf"
local FONTS = {
    font_small = love.graphics.newFont(pixel_font, 40),
    font_average = love.graphics.newFont(pixel_font, 50),
}

---@class LANGTable
---@field title LanguageEntry
---@field quit LanguageEntry
---@field start LanguageEntry
---@field language LanguageEntry
---@field level1 LanguageEntry
---@field level2 LanguageEntry
---@field level3 LanguageEntry
---@field score_text LanguageEntry
---@field round_score LanguageEntry
---@field hands LanguageEntry
---@field discards LanguageEntry
---@field ranking_info LanguageEntry
---@field play_hand LanguageEntry
---@field discard_hand LanguageEntry
---@field to_main_menu LanguageEntry
---@field new_game LanguageEntry
---@field you_lose LanguageEntry
---@field high_card LanguageEntry
---@field pair LanguageEntry
---@field two_pair LanguageEntry
---@field three_of_a_kind LanguageEntry
---@field straight LanguageEntry
---@field flush LanguageEntry
---@field full_house LanguageEntry
---@field four_of_a_kind LanguageEntry
---@field straight_flush LanguageEntry
---@field royal_flush LanguageEntry
local LANG = {
    -- start menu
    title = {en="Poinker", sl="Poinker"},
    quit = {en="Quit", sl="Zapusti"},
    start = {en="Start", sl="Začni"},
    language = {en="Language", sl="Jezik"},

    -- main game
    level1 = {en="Level 1", sl="Stopnja 1"},
    level2 = {en="Level 2", sl="Stopnja 2"},
    level3 = {en="Level 3", sl="Stopnja 3"},
    score_text = {en="Score at least:", sl="Doseži vsaj:"},
    round_score = {en="Round\nScore", sl="Točke\nstopnje"},
    hands = {en="Hands", sl="Roke"},
    discards = {en="Discards", sl="Zavržki"},
    ranking_info = {en="Ranking\ninfo", sl="Info\nrok"},
    play_hand = {en="Play hand", sl="Igraj roko"},
    discard_hand = {en="Discard", sl="Zavrži"},
    to_main_menu = {en="Main menu", sl="Glavni meni"},
    new_game = {en="New game", sl="Nova igra"},
    you_lose = {en="You\nlose!", sl="Zgubil\n   si!"},

    high_card = {en="High Card", sl="Visoka karta"},
    pair = {en="Pair", sl="En par"},
    two_pair = {en="Two Pair", sl="Dva para"},
    three_of_a_kind = {en="Three of a Kind", sl="Tris", font=FONTS.font_average},
    straight = {en="Straight", sl="Lestvica"},
    flush = {en="Flush", sl="Barva"},
    full_house = {en="Full House", sl="Polna hiša"},
    four_of_a_kind = {en="Four of a Kind", sl="Poker", font=FONTS.font_average},
    straight_flush = {en="Straight Flush", sl="Barvna lestvica", font=FONTS.font_average},
    royal_flush = {en="Royal Flush", sl="Kraljeva\nbarvna lestvica", font=FONTS.font_small},
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