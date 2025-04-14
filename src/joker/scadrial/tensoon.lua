--Tensoon: Gains mult when 3 or more cards that are scored are enhanced cards
SMODS.Joker {
	key = 'tensoon',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
    rarity = 'csmr_preserver',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { mult = 0, mult_mod = 8, cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_mod,
                card.ability.extra.mult,
                card.ability.extra.cards,
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then  
            local enhanced_cards = 0
            for _,v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    enhanced_cards = enhanced_cards + 1
                end
            end
            if enhanced_cards >= card.ability.extra.cards then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                card:juice_up()
                return {
                message = 'Upgraded!'
                }
            end
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
