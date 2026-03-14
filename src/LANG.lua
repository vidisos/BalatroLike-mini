local Font = require "src.Font"

---@type LanguageEntry[]
local LANG = {
    -- start menu
    title = {en="Poinker", sl="Poinker"},
    quit = {en="Quit", sl="Zapusti"},
    start = {en="Start", sl="Začni"},
    language = {en="Language", sl="Jezik"},

    -- main game
    level = {en="Level", sl="Stopnja"},
    score_text = {en="Score at least:", sl="Doseži vsaj:"},
    round_score = {en="Round Score", sl="Točke stopnje"},
    hands = {en="Hands", sl="Roke"},
    discards = {en="Discards", sl="Zavržki"},
    ranking_info = {en="Ranking info", sl="Info rok"},
    play_hand = {en="Play hand", sl="Igraj roko"},
    discard_hand = {en="Discard", sl="Zavrži"},
    to_main_menu = {en="Main menu", sl="Glavni meni"},
    new_game = {en="New game", sl="Nova igra"},
    you_lose = {en="You lose!", sl="Zgubil si!"},
    choose_spark = {en="Choose a Spark!", sl="Izberi Iskro!"},

    chips = {en="chips", sl="žetonov"},
    delete_spark = {en="Remove", sl="Odstrani"},

    -- hands
    high_card = {en="High Card", sl="Visoka karta"},
    pair = {en="Pair", sl="En par"},
    two_pair = {en="Two Pair", sl="Dva para"},
    three_of_a_kind = {en="Three of a Kind", sl="Tris", font = Font.fonts.font_average},
    straight = {en="Straight", sl="Lestvica"},
    flush = {en="Flush", sl="Barva"},
    full_house = {en="Full House", sl="Polna hiša"},
    four_of_a_kind = {en="Four of a Kind", sl="Poker", font=Font.fonts.font_average},
    straight_flush = {en="Straight Flush", sl="Barvna lestvica", font=Font.fonts.font_average},
    royal_flush = {en="Royal Flush", sl="Kraljeva barvna lestvica", font=Font.fonts.font_small},

    -- cards
    card_ace_clubs = {en="Ace of Clubs", sl="As križev"},
    card_2_clubs = {en="2 of Clubs", sl="2 križev"},
    card_3_clubs = {en="3 of Clubs", sl="3 križev"},
    card_4_clubs = {en="4 of Clubs", sl="4 križev"},
    card_5_clubs = {en="5 of Clubs", sl="5 križev"},
    card_6_clubs = {en="6 of Clubs", sl="6 križev"},
    card_7_clubs = {en="7 of Clubs", sl="7 križev"},
    card_8_clubs = {en="8 of Clubs", sl="8 križev"},
    card_9_clubs = {en="9 of Clubs", sl="9 križev"},
    card_10_clubs = {en="10 of Clubs", sl="10 križev"},
    card_jack_clubs = {en="Jack of Clubs", sl="Fant križev"},
    card_queen_clubs = {en="Queen of Clubs", sl="Dama križev"},
    card_king_clubs = {en="King of Clubs", sl="Kralj križev"},

    card_ace_diamonds = {en="Ace of Diamonds", sl="As karo"},
    card_2_diamonds = {en="2 of Diamonds", sl="2 karo"},
    card_3_diamonds = {en="3 of Diamonds", sl="3 karo"},
    card_4_diamonds = {en="4 of Diamonds", sl="4 karo"},
    card_5_diamonds = {en="5 of Diamonds", sl="5 karo"},
    card_6_diamonds = {en="6 of Diamonds", sl="6 karo"},
    card_7_diamonds = {en="7 of Diamonds", sl="7 karo"},
    card_8_diamonds = {en="8 of Diamonds", sl="8 karo"},
    card_9_diamonds = {en="9 of Diamonds", sl="9 karo"},
    card_10_diamonds = {en="10 of Diamonds", sl="10 karo"},
    card_jack_diamonds = {en="Jack of Diamonds", sl="Fant karo"},
    card_queen_diamonds = {en="Queen of Diamonds", sl="Dama karo"},
    card_king_diamonds = {en="King of Diamonds", sl="Kralj karo"},

    card_ace_hearts = {en="Ace of Hearts", sl="As src"},
    card_2_hearts = {en="2 of Hearts", sl="2 src"},
    card_3_hearts = {en="3 of Hearts", sl="3 src"},
    card_4_hearts = {en="4 of Hearts", sl="4 src"},
    card_5_hearts = {en="5 of Hearts", sl="5 src"},
    card_6_hearts = {en="6 of Hearts", sl="6 src"},
    card_7_hearts = {en="7 of Hearts", sl="7 src"},
    card_8_hearts = {en="8 of Hearts", sl="8 src"},
    card_9_hearts = {en="9 of Hearts", sl="9 src"},
    card_10_hearts = {en="10 of Hearts", sl="10 src"},
    card_jack_hearts = {en="Jack of Hearts", sl="Fant src"},
    card_queen_hearts = {en="Queen of Hearts", sl="Dama src"},
    card_king_hearts = {en="King of Hearts", sl="Kralj src"},

    card_ace_spades = {en="Ace of Spades", sl="As pik"},
    card_2_spades = {en="2 of Spades", sl="2 pik"},
    card_3_spades = {en="3 of Spades", sl="3 pik"},
    card_4_spades = {en="4 of Spades", sl="4 pik"},
    card_5_spades = {en="5 of Spades", sl="5 pik"},
    card_6_spades = {en="6 of Spades", sl="6 pik"},
    card_7_spades = {en="7 of Spades", sl="7 pik"},
    card_8_spades = {en="8 of Spades", sl="8 pik"},
    card_9_spades = {en="9 of Spades", sl="9 pik"},
    card_10_spades = {en="10 of Spades", sl="10 pik"},
    card_jack_spades = {en="Jack of Spades", sl="Fant pik"},
    card_queen_spades = {en="Queen of Spades", sl="Dama pik"},
    card_king_spades = {en="King of Spades", sl="Kralj pik"},

    --sparks
    spark_1_title = {en="Zany Joker", sl="Nori Joker"},
    spark_1_desc = {en="+8 Mult if played hand contains a Pair", sl="+8 mult, če igrana roka vsebuje Par"},
    spark_2_title = {en="Zany Joker", sl="Nori Joker"},
    spark_2_desc = {en="+12 Mult if played hand contains a Three of a Kind", sl="+12 mult, če igrana roka vsebuje Tris"},
    spark_3_title = {en="Mad Joker", sl="Blazni Joker"},
    spark_3_desc = {en="+10 Mult if played hand contains a Two Pair", sl="+10 mult, če igrana roka vsebuje Dva para"},
    spark_4_title = {en="Crazy Joker", sl="Nor Joker"},
    spark_4_desc = {en="+12 Mult if played hand contains a Straight", sl="+12 mult, če igrana roka vsebuje Lestvico"},
    spark_5_title = {en="Droll Joker", sl="Zabaven Joker"},
    spark_5_desc = {en="+10 Mult if played hand contains a Flush", sl="+10 mult, če igrana roka vsebuje Barvo"},

    spark_6_title = {en="Sly Joker", sl="Prekanjen Joker"},
    spark_6_desc = {en="+50 Chips if played hand contains a Pair", sl="+50 žetonov, če igrana roka vsebuje Par"},
    spark_7_title = {en="Wily Joker", sl="Hiter Joker"},
    spark_7_desc = {en="+100 Chips if played hand contains a Three of a Kind", sl="+100 žetonov, če igrana roka vsebuje Tris"},
    spark_8_title = {en="Clever Joker", sl="Pameten Joker"},
    spark_8_desc = {en="+80 Chips if played hand contains a Two Pair", sl="+80 žetonov, če igrana roka vsebuje Dva para"},
    spark_9_title = {en="Devious Joker", sl="Zloben Joker"},
    spark_9_desc = {en="+100 Chips if played hand contains a Straight", sl="+100 žetonov, če igrana roka vsebuje Lestvico"},
    spark_10_title = {en="Crafty Joker", sl="Spreten Joker"},
    spark_10_desc = {en="+80 Chips if played hand contains a Flush", sl="+80 žetonov, če igrana roka vsebuje Barvo"},


    spark_11_title = {en="Spark 1", sl="Iskra 1"},
    spark_11_desc = {en="+1 Hand", sl="+1 Roka"},

    spark_12_title = {en="Spark", sl="Iskra"},
    spark_12_desc = {en="Get 2 more sparks as choices after winning a round", sl="2 dodatni izbiri isker po zmagi runde"},

    spark_13_title = {en="Spark 3", sl="Iskra 3"},
    spark_13_desc = {en="All played aces give x1.5 mult", sl="Vsi igrani as-i ponudijo x1.5 mult"},

    spark_14_title = {en="Trash can", sl="Smetnjak"},
    spark_14_desc = {en="+2 discards", sl="+2 zavržka"}
}

return LANG
