local image_list = require "src.image_list"
local LANG = require "src.LANG"

local card_images = image_list.cards
local cardBackMain = card_images.cardBackMain

---@type CardBase[]
local card_list = {
    -- Clubs
    club1  = {baseImage = card_images.club1,  backImage = nil, suit = "club", rank = 14, chips = 11, title = LANG.card_ace_clubs},
    club2  = {baseImage = card_images.club2,  backImage = nil, suit = "club", rank = 2,  chips = 2,  title = LANG.card_2_clubs},
    club3  = {baseImage = card_images.club3,  backImage = nil, suit = "club", rank = 3,  chips = 3,  title = LANG.card_3_clubs},
    club4  = {baseImage = card_images.club4,  backImage = nil, suit = "club", rank = 4,  chips = 4,  title = LANG.card_4_clubs},
    club5  = {baseImage = card_images.club5,  backImage = nil, suit = "club", rank = 5,  chips = 5,  title = LANG.card_5_clubs},
    club6  = {baseImage = card_images.club6,  backImage = nil, suit = "club", rank = 6,  chips = 6,  title = LANG.card_6_clubs},
    club7  = {baseImage = card_images.club7,  backImage = nil, suit = "club", rank = 7,  chips = 7,  title = LANG.card_7_clubs},
    club8  = {baseImage = card_images.club8,  backImage = nil, suit = "club", rank = 8,  chips = 8,  title = LANG.card_8_clubs},
    club9  = {baseImage = card_images.club9,  backImage = nil, suit = "club", rank = 9,  chips = 9,  title = LANG.card_9_clubs},
    club10 = {baseImage = card_images.club10, backImage = nil, suit = "club", rank = 10, chips = 10, title = LANG.card_10_clubs},
    club11 = {baseImage = card_images.club11, backImage = nil, suit = "club", rank = 11, chips = 10, title = LANG.card_jack_clubs},
    club12 = {baseImage = card_images.club12, backImage = nil, suit = "club", rank = 12, chips = 10, title = LANG.card_queen_clubs},
    club13 = {baseImage = card_images.club13, backImage = nil, suit = "club", rank = 13, chips = 10, title = LANG.card_king_clubs},

    -- Diamonds
    diamond1  = {baseImage = card_images.diamond1,  backImage = nil, suit = "diamond", rank = 14, chips = 11, title = LANG.card_ace_diamonds},
    diamond2  = {baseImage = card_images.diamond2,  backImage = nil, suit = "diamond", rank = 2,  chips = 2,  title = LANG.card_2_diamonds},
    diamond3  = {baseImage = card_images.diamond3,  backImage = nil, suit = "diamond", rank = 3,  chips = 3,  title = LANG.card_3_diamonds},
    diamond4  = {baseImage = card_images.diamond4,  backImage = nil, suit = "diamond", rank = 4,  chips = 4,  title = LANG.card_4_diamonds},
    diamond5  = {baseImage = card_images.diamond5,  backImage = nil, suit = "diamond", rank = 5,  chips = 5,  title = LANG.card_5_diamonds},
    diamond6  = {baseImage = card_images.diamond6,  backImage = nil, suit = "diamond", rank = 6,  chips = 6,  title = LANG.card_6_diamonds},
    diamond7  = {baseImage = card_images.diamond7,  backImage = nil, suit = "diamond", rank = 7,  chips = 7,  title = LANG.card_7_diamonds},
    diamond8  = {baseImage = card_images.diamond8,  backImage = nil, suit = "diamond", rank = 8,  chips = 8,  title = LANG.card_8_diamonds},
    diamond9  = {baseImage = card_images.diamond9,  backImage = nil, suit = "diamond", rank = 9,  chips = 9,  title = LANG.card_9_diamonds},
    diamond10 = {baseImage = card_images.diamond10, backImage = nil, suit = "diamond", rank = 10, chips = 10, title = LANG.card_10_diamonds},
    diamond11 = {baseImage = card_images.diamond11, backImage = nil, suit = "diamond", rank = 11, chips = 10, title = LANG.card_jack_diamonds},
    diamond12 = {baseImage = card_images.diamond12, backImage = nil, suit = "diamond", rank = 12, chips = 10, title = LANG.card_queen_diamonds},
    diamond13 = {baseImage = card_images.diamond13, backImage = nil, suit = "diamond", rank = 13, chips = 10, title = LANG.card_king_diamonds},

    -- Hearts
    heart1  = {baseImage = card_images.heart1,  backImage = nil, suit = "heart", rank = 14, chips = 11, title = LANG.card_ace_hearts},
    heart2  = {baseImage = card_images.heart2,  backImage = nil, suit = "heart", rank = 2,  chips = 2,  title = LANG.card_2_hearts},
    heart3  = {baseImage = card_images.heart3,  backImage = nil, suit = "heart", rank = 3,  chips = 3,  title = LANG.card_3_hearts},
    heart4  = {baseImage = card_images.heart4,  backImage = nil, suit = "heart", rank = 4,  chips = 4,  title = LANG.card_4_hearts},
    heart5  = {baseImage = card_images.heart5,  backImage = nil, suit = "heart", rank = 5,  chips = 5,  title = LANG.card_5_hearts},
    heart6  = {baseImage = card_images.heart6,  backImage = nil, suit = "heart", rank = 6,  chips = 6,  title = LANG.card_6_hearts},
    heart7  = {baseImage = card_images.heart7,  backImage = nil, suit = "heart", rank = 7,  chips = 7,  title = LANG.card_7_hearts},
    heart8  = {baseImage = card_images.heart8,  backImage = nil, suit = "heart", rank = 8,  chips = 8,  title = LANG.card_8_hearts},
    heart9  = {baseImage = card_images.heart9,  backImage = nil, suit = "heart", rank = 9,  chips = 9,  title = LANG.card_9_hearts},
    heart10 = {baseImage = card_images.heart10, backImage = nil, suit = "heart", rank = 10, chips = 10, title = LANG.card_10_hearts},
    heart11 = {baseImage = card_images.heart11, backImage = nil, suit = "heart", rank = 11, chips = 10, title = LANG.card_jack_hearts},
    heart12 = {baseImage = card_images.heart12, backImage = nil, suit = "heart", rank = 12, chips = 10, title = LANG.card_queen_hearts},
    heart13 = {baseImage = card_images.heart13, backImage = nil, suit = "heart", rank = 13, chips = 10, title = LANG.card_king_hearts},

    -- Spades
    spade1  = {baseImage = card_images.spade1,  backImage = nil, suit = "spade", rank = 14, chips = 11, title = LANG.card_ace_spades},
    spade2  = {baseImage = card_images.spade2,  backImage = nil, suit = "spade", rank = 2,  chips = 2,  title = LANG.card_2_spades},
    spade3  = {baseImage = card_images.spade3,  backImage = nil, suit = "spade", rank = 3,  chips = 3,  title = LANG.card_3_spades},
    spade4  = {baseImage = card_images.spade4,  backImage = nil, suit = "spade", rank = 4,  chips = 4,  title = LANG.card_4_spades},
    spade5  = {baseImage = card_images.spade5,  backImage = nil, suit = "spade", rank = 5,  chips = 5,  title = LANG.card_5_spades},
    spade6  = {baseImage = card_images.spade6,  backImage = nil, suit = "spade", rank = 6,  chips = 6,  title = LANG.card_6_spades},
    spade7  = {baseImage = card_images.spade7,  backImage = nil, suit = "spade", rank = 7,  chips = 7,  title = LANG.card_7_spades},
    spade8  = {baseImage = card_images.spade8,  backImage = nil, suit = "spade", rank = 8,  chips = 8,  title = LANG.card_8_spades},
    spade9  = {baseImage = card_images.spade9,  backImage = nil, suit = "spade", rank = 9,  chips = 9,  title = LANG.card_9_spades},
    spade10 = {baseImage = card_images.spade10, backImage = nil, suit = "spade", rank = 10, chips = 10, title = LANG.card_10_spades},
    spade11 = {baseImage = card_images.spade11, backImage = nil, suit = "spade", rank = 11, chips = 10, title = LANG.card_jack_spades},
    spade12 = {baseImage = card_images.spade12, backImage = nil, suit = "spade", rank = 12, chips = 10, title = LANG.card_queen_spades},
    spade13 = {baseImage = card_images.spade13, backImage = nil, suit = "spade", rank = 13, chips = 10, title = LANG.card_king_spades}
}

return card_list
