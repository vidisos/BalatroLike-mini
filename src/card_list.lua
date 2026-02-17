local image_list = require "image_list"

local card_list = {
    ---@class CardBase
    ---@field image love.Image
    ---@field suit string
    ---@field rank integer
    cards = {
        -- Clubs
        club1  = {image = image_list.cards.club1,  suit = "club",    rank = 1},
        club2  = {image = image_list.cards.club2,  suit = "club",    rank = 2},
        club3  = {image = image_list.cards.club3,  suit = "club",    rank = 3},
        club4  = {image = image_list.cards.club4,  suit = "club",    rank = 4},
        club5  = {image = image_list.cards.club5,  suit = "club",    rank = 5},
        club6  = {image = image_list.cards.club6,  suit = "club",    rank = 6},
        club7  = {image = image_list.cards.club7,  suit = "club",    rank = 7},
        club8  = {image = image_list.cards.club8,  suit = "club",    rank = 8},
        club9  = {image = image_list.cards.club9,  suit = "club",    rank = 9},
        club10 = {image = image_list.cards.club10, suit = "club",    rank = 10},
        club11 = {image = image_list.cards.club11, suit = "club",    rank = 11},
        club12 = {image = image_list.cards.club12, suit = "club",    rank = 12},
        club13 = {image = image_list.cards.club13, suit = "club",    rank = 13},

        -- Diamonds
        diamond1  = {image = image_list.cards.diamond1,  suit = "diamond", rank = 1},
        diamond2  = {image = image_list.cards.diamond2,  suit = "diamond", rank = 2},
        diamond3  = {image = image_list.cards.diamond3,  suit = "diamond", rank = 3},
        diamond4  = {image = image_list.cards.diamond4,  suit = "diamond", rank = 4},
        diamond5  = {image = image_list.cards.diamond5,  suit = "diamond", rank = 5},
        diamond6  = {image = image_list.cards.diamond6,  suit = "diamond", rank = 6},
        diamond7  = {image = image_list.cards.diamond7,  suit = "diamond", rank = 7},
        diamond8  = {image = image_list.cards.diamond8,  suit = "diamond", rank = 8},
        diamond9  = {image = image_list.cards.diamond9,  suit = "diamond", rank = 9},
        diamond10 = {image = image_list.cards.diamond10, suit = "diamond", rank = 10},
        diamond11 = {image = image_list.cards.diamond11, suit = "diamond", rank = 11},
        diamond12 = {image = image_list.cards.diamond12, suit = "diamond", rank = 12},
        diamond13 = {image = image_list.cards.diamond13, suit = "diamond", rank = 13},

        -- Hearts
        heart1  = {image = image_list.cards.heart1,  suit = "heart", rank = 1},
        heart2  = {image = image_list.cards.heart2,  suit = "heart", rank = 2},
        heart3  = {image = image_list.cards.heart3,  suit = "heart", rank = 3},
        heart4  = {image = image_list.cards.heart4,  suit = "heart", rank = 4},
        heart5  = {image = image_list.cards.heart5,  suit = "heart", rank = 5},
        heart6  = {image = image_list.cards.heart6,  suit = "heart", rank = 6},
        heart7  = {image = image_list.cards.heart7,  suit = "heart", rank = 7},
        heart8  = {image = image_list.cards.heart8,  suit = "heart", rank = 8},
        heart9  = {image = image_list.cards.heart9,  suit = "heart", rank = 9},
        heart10 = {image = image_list.cards.heart10, suit = "heart", rank = 10},
        heart11 = {image = image_list.cards.heart11, suit = "heart", rank = 11},
        heart12 = {image = image_list.cards.heart12, suit = "heart", rank = 12},
        heart13 = {image = image_list.cards.heart13, suit = "heart", rank = 13},

        -- Spades
        spade1  = {image = image_list.cards.spade1,  suit = "spade", rank = 1},
        spade2  = {image = image_list.cards.spade2,  suit = "spade", rank = 2},
        spade3  = {image = image_list.cards.spade3,  suit = "spade", rank = 3},
        spade4  = {image = image_list.cards.spade4,  suit = "spade", rank = 4},
        spade5  = {image = image_list.cards.spade5,  suit = "spade", rank = 5},
        spade6  = {image = image_list.cards.spade6,  suit = "spade", rank = 6},
        spade7  = {image = image_list.cards.spade7,  suit = "spade", rank = 7},
        spade8  = {image = image_list.cards.spade8,  suit = "spade", rank = 8},
        spade9  = {image = image_list.cards.spade9,  suit = "spade", rank = 9},
        spade10 = {image = image_list.cards.spade10, suit = "spade", rank = 10},
        spade11 = {image = image_list.cards.spade11, suit = "spade", rank = 11},
        spade12 = {image = image_list.cards.spade12, suit = "spade", rank = 12},
        spade13 = {image = image_list.cards.spade13, suit = "spade", rank = 13},
    },

    sparks = {
        controller = {image = image_list}
    }
}

return card_list
