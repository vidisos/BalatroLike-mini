local LANG = require "src.LANG"
local hand_rankings_list = {
    high_card = {chips=5, mult=1, display_index = 10, title = {en="High Card", sl="Visoka karta"}},
    pair = {chips=10, mult=2, display_index = 9, title = {en="Pair", sl="En par"}},
    two_pair = {chips=20, mult=2, display_index = 8, title = {en="Two Pair", sl="Dva para"}},
    three_of_a_kind = {chips=30, mult=3, display_index = 7, title = {en="Three of a Kind", sl="Tris"}},
    straight = {chips=30, mult=4, display_index = 6, title = {en="Straight", sl="Lestvica"}},
    flush = {chips=35, mult=4, display_index = 5, title = {en="Flush", sl="Barva"}},
    full_house = {chips=40, mult=4, display_index = 4, title = {en="Full House", sl="Polna hiša"}},
    four_of_a_kind = {chips=60, mult=7, display_index = 3, title = {en="Four of a Kind", sl="Poker"}},
    straight_flush = {chips=100, mult=8, display_index = 2, title = {en="Straight Flush", sl="Barvna lestvica"}},
    royal_flush = {chips=100, mult=8, display_index = 1, title = {en="Royal Flush", sl="Kraljeva barvna lestvica"}},
}

return hand_rankings_list
