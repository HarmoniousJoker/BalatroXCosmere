--Lord Ruler: Weakens Scoring Joker effects by 25% for each hand played
SMODS.Blind{
    key = "lordruler",
    dollars = 5,
    mult = 3,
    boss_colour = G.C.BLACK,
    --atlas = 'scadrial',
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 30},
    press_play = function(self)
        if not G.GAME["LordRulerMultiplier"] then
            G.GAME["LordRulerMultiplier"] = 1
        end
        G.GAME["LordRulerMultiplier"] = G.GAME["LordRulerMultiplier"] * 0.75
    end,
    calculate = function(self, blind, context)
        if context.before then
            G.E_MANAGER:add_event(Event({func = function()
                blind:wiggle()
                return true end }))
        end
    end
}
