SMODS.Blind{
    key = "lordruler",
    dollars = 5,
    mult = 3,
    boss_colour = G.C.BLACK,
    --atlas = 'scadrial',
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 30},
    loc_vars = function(self)
    end,
    collection_loc_vars = function(self)
    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
    end,
    in_pool = function(self)
        return true
    end,
    disable = function(self)
    end,
    defeat = function(self)
    end,
    press_play = function(self)
        if not G.GAME["LordRulerMultiplier"] then
            G.GAME["LordRulerMultiplier"] = 1
        end
        G.GAME["LordRulerMultiplier"] = G.GAME["LordRulerMultiplier"] * 0.75
        print('M:', G.GAME["LordRulerMultiplier"])
    end,
}