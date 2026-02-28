local image_list = require "image_list"

local card_images = image_list.cards
local cardBack1 = card_images.cardBack1
local cardBack3 = card_images.cardBack3

local card_list = {
    ---@class CardBase
    cards = {
        -- Clubs (cardBack3)
        club1  = {baseImage = card_images.club1,  backImage = cardBack3, suit = "club",    rank = 1},
        club2  = {baseImage = card_images.club2,  backImage = cardBack3, suit = "club",    rank = 2},
        club3  = {baseImage = card_images.club3,  backImage = cardBack3, suit = "club",    rank = 3},
        club4  = {baseImage = card_images.club4,  backImage = cardBack3, suit = "club",    rank = 4},
        club5  = {baseImage = card_images.club5,  backImage = cardBack3, suit = "club",    rank = 5},
        club6  = {baseImage = card_images.club6,  backImage = cardBack3, suit = "club",    rank = 6},
        club7  = {baseImage = card_images.club7,  backImage = cardBack3, suit = "club",    rank = 7},
        club8  = {baseImage = card_images.club8,  backImage = cardBack3, suit = "club",    rank = 8},
        club9  = {baseImage = card_images.club9,  backImage = cardBack3, suit = "club",    rank = 9},
        club10 = {baseImage = card_images.club10, backImage = cardBack3, suit = "club",    rank = 10},
        club11 = {baseImage = card_images.club11, backImage = cardBack3, suit = "club",    rank = 11},
        club12 = {baseImage = card_images.club12, backImage = cardBack3, suit = "club",    rank = 12},
        club13 = {baseImage = card_images.club13, backImage = cardBack3, suit = "club",    rank = 13},

        -- Diamonds (cardBack1)
        diamond1  = {baseImage = card_images.diamond1,  backImage = cardBack1, suit = "diamond", rank = 1},
        diamond2  = {baseImage = card_images.diamond2,  backImage = cardBack1, suit = "diamond", rank = 2},
        diamond3  = {baseImage = card_images.diamond3,  backImage = cardBack1, suit = "diamond", rank = 3},
        diamond4  = {baseImage = card_images.diamond4,  backImage = cardBack1, suit = "diamond", rank = 4},
        diamond5  = {baseImage = card_images.diamond5,  backImage = cardBack1, suit = "diamond", rank = 5},
        diamond6  = {baseImage = card_images.diamond6,  backImage = cardBack1, suit = "diamond", rank = 6},
        diamond7  = {baseImage = card_images.diamond7,  backImage = cardBack1, suit = "diamond", rank = 7},
        diamond8  = {baseImage = card_images.diamond8,  backImage = cardBack1, suit = "diamond", rank = 8},
        diamond9  = {baseImage = card_images.diamond9,  backImage = cardBack1, suit = "diamond", rank = 9},
        diamond10 = {baseImage = card_images.diamond10, backImage = cardBack1, suit = "diamond", rank = 10},
        diamond11 = {baseImage = card_images.diamond11, backImage = cardBack1, suit = "diamond", rank = 11},
        diamond12 = {baseImage = card_images.diamond12, backImage = cardBack1, suit = "diamond", rank = 12},
        diamond13 = {baseImage = card_images.diamond13, backImage = cardBack1, suit = "diamond", rank = 13},

        -- Hearts (cardBack1)
        heart1  = {baseImage = card_images.heart1,  backImage = cardBack1, suit = "heart", rank = 1},
        heart2  = {baseImage = card_images.heart2,  backImage = cardBack1, suit = "heart", rank = 2},
        heart3  = {baseImage = card_images.heart3,  backImage = cardBack1, suit = "heart", rank = 3},
        heart4  = {baseImage = card_images.heart4,  backImage = cardBack1, suit = "heart", rank = 4},
        heart5  = {baseImage = card_images.heart5,  backImage = cardBack1, suit = "heart", rank = 5},
        heart6  = {baseImage = card_images.heart6,  backImage = cardBack1, suit = "heart", rank = 6},
        heart7  = {baseImage = card_images.heart7,  backImage = cardBack1, suit = "heart", rank = 7},
        heart8  = {baseImage = card_images.heart8,  backImage = cardBack1, suit = "heart", rank = 8},
        heart9  = {baseImage = card_images.heart9,  backImage = cardBack1, suit = "heart", rank = 9},
        heart10 = {baseImage = card_images.heart10, backImage = cardBack1, suit = "heart", rank = 10},
        heart11 = {baseImage = card_images.heart11, backImage = cardBack1, suit = "heart", rank = 11},
        heart12 = {baseImage = card_images.heart12, backImage = cardBack1, suit = "heart", rank = 12},
        heart13 = {baseImage = card_images.heart13, backImage = cardBack1, suit = "heart", rank = 13},

        -- Spades (cardBack3)
        spade1  = {baseImage = card_images.spade1,  backImage = cardBack3, suit = "spade", rank = 1},
        spade2  = {baseImage = card_images.spade2,  backImage = cardBack3, suit = "spade", rank = 2},
        spade3  = {baseImage = card_images.spade3,  backImage = cardBack3, suit = "spade", rank = 3},
        spade4  = {baseImage = card_images.spade4,  backImage = cardBack3, suit = "spade", rank = 4},
        spade5  = {baseImage = card_images.spade5,  backImage = cardBack3, suit = "spade", rank = 5},
        spade6  = {baseImage = card_images.spade6,  backImage = cardBack3, suit = "spade", rank = 6},
        spade7  = {baseImage = card_images.spade7,  backImage = cardBack3, suit = "spade", rank = 7},
        spade8  = {baseImage = card_images.spade8,  backImage = cardBack3, suit = "spade", rank = 8},
        spade9  = {baseImage = card_images.spade9,  backImage = cardBack3, suit = "spade", rank = 9},
        spade10 = {baseImage = card_images.spade10, backImage = cardBack3, suit = "spade", rank = 10},
        spade11 = {baseImage = card_images.spade11, backImage = cardBack3, suit = "spade", rank = 11},
        spade12 = {baseImage = card_images.spade12, backImage = cardBack3, suit = "spade", rank = 12},
        spade13 = {baseImage = card_images.spade13, backImage = cardBack3, suit = "spade", rank = 13}
    },

    sparks = {
        controller = {image = image_list}
    }
}

return card_list
