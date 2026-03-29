local image_folder = "src/images/"
local cards_folder = image_folder .. "cards/"
local sparks_folder = image_folder .. "sparks/"

-- Just renaming the function
local newImage = love.graphics.newImage

-- Images dont become blurry woohoo
love.graphics.setDefaultFilter('nearest', 'nearest')

local image_list = {
    settings_icon = newImage(image_folder .. "settings_icon.png"),
    sparks_background = newImage(image_folder .. "sparks_background.png"),
    language_icon = newImage(image_folder .. "language_icon.png"),

    -- All poker cards (© ElvGames sigma) 
    cards = {
        -- Card Backs
        cardBackMain = newImage(cards_folder .. "Card_Back_Main.png"),

        -- Clubs
        club1  = newImage(cards_folder .. "Clubs_1.png"),
        club2  = newImage(cards_folder .. "Clubs_2.png"),
        club3  = newImage(cards_folder .. "Clubs_3.png"),
        club4  = newImage(cards_folder .. "Clubs_4.png"),
        club5  = newImage(cards_folder .. "Clubs_5.png"),
        club6  = newImage(cards_folder .. "Clubs_6.png"),
        club7  = newImage(cards_folder .. "Clubs_7.png"),
        club8  = newImage(cards_folder .. "Clubs_8.png"),
        club9  = newImage(cards_folder .. "Clubs_9.png"),
        club10 = newImage(cards_folder .. "Clubs_10.png"),
        club11 = newImage(cards_folder .. "Clubs_11.png"),
        club12 = newImage(cards_folder .. "Clubs_12.png"),
        club13 = newImage(cards_folder .. "Clubs_13.png"),

        -- Diamonds
        diamond1  = newImage(cards_folder .. "Diamonds_1.png"),
        diamond2  = newImage(cards_folder .. "Diamonds_2.png"),
        diamond3  = newImage(cards_folder .. "Diamonds_3.png"),
        diamond4  = newImage(cards_folder .. "Diamonds_4.png"),
        diamond5  = newImage(cards_folder .. "Diamonds_5.png"),
        diamond6  = newImage(cards_folder .. "Diamonds_6.png"),
        diamond7  = newImage(cards_folder .. "Diamonds_7.png"),
        diamond8  = newImage(cards_folder .. "Diamonds_8.png"),
        diamond9  = newImage(cards_folder .. "Diamonds_9.png"),
        diamond10 = newImage(cards_folder .. "Diamonds_10.png"),
        diamond11 = newImage(cards_folder .. "Diamonds_11.png"),
        diamond12 = newImage(cards_folder .. "Diamonds_12.png"),
        diamond13 = newImage(cards_folder .. "Diamonds_13.png"),

        -- Hearts
        heart1  = newImage(cards_folder .. "Hearts_1.png"),
        heart2  = newImage(cards_folder .. "Hearts_2.png"),
        heart3  = newImage(cards_folder .. "Hearts_3.png"),
        heart4  = newImage(cards_folder .. "Hearts_4.png"),
        heart5  = newImage(cards_folder .. "Hearts_5.png"),
        heart6  = newImage(cards_folder .. "Hearts_6.png"),
        heart7  = newImage(cards_folder .. "Hearts_7.png"),
        heart8  = newImage(cards_folder .. "Hearts_8.png"),
        heart9  = newImage(cards_folder .. "Hearts_9.png"),
        heart10 = newImage(cards_folder .. "Hearts_10.png"),
        heart11 = newImage(cards_folder .. "Hearts_11.png"),
        heart12 = newImage(cards_folder .. "Hearts_12.png"),
        heart13 = newImage(cards_folder .. "Hearts_13.png"),

        -- Spades
        spade1  = newImage(cards_folder .. "Spades_1.png"),
        spade2  = newImage(cards_folder .. "Spades_2.png"),
        spade3  = newImage(cards_folder .. "Spades_3.png"),
        spade4  = newImage(cards_folder .. "Spades_4.png"),
        spade5  = newImage(cards_folder .. "Spades_5.png"),
        spade6  = newImage(cards_folder .. "Spades_6.png"),
        spade7  = newImage(cards_folder .. "Spades_7.png"),
        spade8  = newImage(cards_folder .. "Spades_8.png"),
        spade9  = newImage(cards_folder .. "Spades_9.png"),
        spade10 = newImage(cards_folder .. "Spades_10.png"),
        spade11 = newImage(cards_folder .. "Spades_11.png"),
        spade12 = newImage(cards_folder .. "Spades_12.png"),
        spade13 = newImage(cards_folder .. "Spades_13.png"),
    },

    -- Sparks (Balatro jokers but renamed hihi)
    sparks = {
        spark1 = newImage(sparks_folder .. "spark1.png"),
        spark2 = newImage(sparks_folder .. "spark2.png"),
        spark3 = newImage(sparks_folder .. "spark3.png"),
        spark4 = newImage(sparks_folder .. "spark4.png"),
        spark5 = newImage(sparks_folder .. "spark5.png"),
        spark6 = newImage(sparks_folder .. "spark6.png"),
        spark7 = newImage(sparks_folder .. "spark7.png"),
        spark8 = newImage(sparks_folder .. "spark8.png"),
        spark9 = newImage(sparks_folder .. "spark9.png"),
        spark10 = newImage(sparks_folder .. "spark10.png"),
        controller = newImage(sparks_folder .. "controller.png"),
        spark12 = newImage(sparks_folder .. "spark12.png"),
        spark13 = newImage(sparks_folder .. "spark13.png"),
        spark14 = newImage(sparks_folder .. "spark14.png")
    }
}

return image_list
