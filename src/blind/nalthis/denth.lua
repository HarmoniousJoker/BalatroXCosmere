--Denth: Before scoring, randomly make a Joker give the opposite effect if it is Scoring
SMODS.Blind{
    key = "denth",
    dollars = 5,
    mult = 1.5,
    boss_colour = G.C.BLACK,
    --atlas = 'scadrial',
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 30},
    press_play = function(self)
        local jokers = {}
        if G.jokers.cards and G.jokers.cards[1] then
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].debuff then
                    table.insert(jokers, G.jokers.cards[i])
                end
            end
        end
        if #jokers > 0 then
            local _card = pseudorandom_element(jokers, pseudoseed('denth'))
            if _card then
                if not _card.ability.multiplier  or _card.ability.multiplier == 1 then
                    _card.ability.multiplier = -1
                end
                _card:juice_up()
            end
        end
    end,
    calculate = function(self, blind, context)
        if context.final_scoring_step then
            if hand_chips and hand_chips < 0 then
                hand_chips = 0
            end
            if mult and mult < 0 then
                mult = 0
            end
        end
    end
}
