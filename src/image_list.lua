local image_folder = "images/"
local cards_folder = image_folder .. "cards/"
local sparks_folder = image_folder .. "sparks/"

-- Just renaming the function
local newImage = love.graphics.newImage

love.graphics.setDefaultFilter('nearest', 'nearest') --images dont become blurry woohoo

local image_list = {
    settings_icon = newImage(image_folder .. "settings_icon.png"),

    -- All poker cards (© ElvGames sigma) 
    cards = {
        -- Card Backs
        cardBack1 = newImage(cards_folder .. "Card Back 1.png"),
        cardBack2 = newImage(cards_folder .. "Card Back 2.png"),
        cardBack3 = newImage(cards_folder .. "Card Back 3.png"),

        -- Clubs
        club1  = newImage(cards_folder .. "Clubs 1.png"),
        club2  = newImage(cards_folder .. "Clubs 2.png"),
        club3  = newImage(cards_folder .. "Clubs 3.png"),
        club4  = newImage(cards_folder .. "Clubs 4.png"),
        club5  = newImage(cards_folder .. "Clubs 5.png"),
        club6  = newImage(cards_folder .. "Clubs 6.png"),
        club7  = newImage(cards_folder .. "Clubs 7.png"),
        club8  = newImage(cards_folder .. "Clubs 8.png"),
        club9  = newImage(cards_folder .. "Clubs 9.png"),
        club10 = newImage(cards_folder .. "Clubs 10.png"),
        club11 = newImage(cards_folder .. "Clubs 11.png"),
        club12 = newImage(cards_folder .. "Clubs 12.png"),
        club13 = newImage(cards_folder .. "Clubs 13.png"),

        -- Diamonds
        diamond1  = newImage(cards_folder .. "Diamonds 1.png"),
        diamond2  = newImage(cards_folder .. "Diamonds 2.png"),
        diamond3  = newImage(cards_folder .. "Diamonds 3.png"),
        diamond4  = newImage(cards_folder .. "Diamonds 4.png"),
        diamond5  = newImage(cards_folder .. "Diamonds 5.png"),
        diamond6  = newImage(cards_folder .. "Diamonds 6.png"),
        diamond7  = newImage(cards_folder .. "Diamonds 7.png"),
        diamond8  = newImage(cards_folder .. "Diamonds 8.png"),
        diamond9  = newImage(cards_folder .. "Diamonds 9.png"),
        diamond10 = newImage(cards_folder .. "Diamonds 10.png"),
        diamond11 = newImage(cards_folder .. "Diamonds 11.png"),
        diamond12 = newImage(cards_folder .. "Diamonds 12.png"),
        diamond13 = newImage(cards_folder .. "Diamonds 13.png"),

        -- Hearts
        heart1  = newImage(cards_folder .. "Hearts 1.png"),
        heart2  = newImage(cards_folder .. "Hearts 2.png"),
        heart3  = newImage(cards_folder .. "Hearts 3.png"),
        heart4  = newImage(cards_folder .. "Hearts 4.png"),
        heart5  = newImage(cards_folder .. "Hearts 5.png"),
        heart6  = newImage(cards_folder .. "Hearts 6.png"),
        heart7  = newImage(cards_folder .. "Hearts 7.png"),
        heart8  = newImage(cards_folder .. "Hearts 8.png"),
        heart9  = newImage(cards_folder .. "Hearts 9.png"),
        heart10 = newImage(cards_folder .. "Hearts 10.png"),
        heart11 = newImage(cards_folder .. "Hearts 11.png"),
        heart12 = newImage(cards_folder .. "Hearts 12.png"),
        heart13 = newImage(cards_folder .. "Hearts 13.png"),

        -- Spades
        spade1  = newImage(cards_folder .. "Spades 1.png"),
        spade2  = newImage(cards_folder .. "Spades 2.png"),
        spade3  = newImage(cards_folder .. "Spades 3.png"),
        spade4  = newImage(cards_folder .. "Spades 4.png"),
        spade5  = newImage(cards_folder .. "Spades 5.png"),
        spade6  = newImage(cards_folder .. "Spades 6.png"),
        spade7  = newImage(cards_folder .. "Spades 7.png"),
        spade8  = newImage(cards_folder .. "Spades 8.png"),
        spade9  = newImage(cards_folder .. "Spades 9.png"),
        spade10 = newImage(cards_folder .. "Spades 10.png"),
        spade11 = newImage(cards_folder .. "Spades 11.png"),
        spade12 = newImage(cards_folder .. "Spades 12.png"),
        spade13 = newImage(cards_folder .. "Spades 13.png"),

        -- Empty (Not needed for now)
        --[[
        empty1  = newImage(card_image_folder .. "Empty 1.png"),
        empty2  = newImage(card_image_folder .. "Empty 2.png"),
        empty3  = newImage(card_image_folder .. "Empty 3.png"),
        empty4  = newImage(card_image_folder .. "Empty 4.png"),
        empty5  = newImage(card_image_folder .. "Empty 5.png"),
        empty6  = newImage(card_image_folder .. "Empty 6.png"),
        empty7  = newImage(card_image_folder .. "Empty 7.png"),
        empty8  = newImage(card_image_folder .. "Empty 8.png"),
        empty9  = newImage(card_image_folder .. "Empty 9.png"),
        empty10 = newImage(card_image_folder .. "Empty 10.png"),
        empty11 = newImage(card_image_folder .. "Empty 11.png"),
        empty12 = newImage(card_image_folder .. "Empty 12.png"),
        empty13 = newImage(card_image_folder .. "Empty 13.png")
        ]]
    },

    -- Sparks (Balatro jokers but renamed hihi)
    sparks = {   
        controller = newImage(sparks_folder .. "controller.png")
    }
}

return image_list
