--Vasher: Makes the first played card Polychrome and Heightened, 1 in 2 chance of being destroyed after scoring, gains 5 mult per destroyed card
SMODS.Joker{
    key = 'vasher',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, mult_mod = 5, odds = 2, edition = {polychrome = true}, destroy = false, flag = false } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_csmr_heightened
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
		return {
			vars = {
				card.ability.extra.mult_mod,
				card.ability.extra.mult
			}
		}
    end,
	calculate = function(self, card, context)
        if context.before and context.scoring_hand and not context.blueprint then
            card.ability.extra.flag = true
            transform_card(context.scoring_hand[1], 'm_csmr_heightened', card.ability.extra.edition)
            return {
                message = 'Awakened!',
                message_card = context.scoring_hand[1]
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return{
                mult = card.ability.extra.mult
            }
        end
        if context.final_scoring_step and not context.blueprint then
            if context.scoring_hand[1] then
                if pseudorandom('vasher') < G.GAME.probabilities.normal / card.ability.extra.odds and card.ability.extra.flag then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    card.ability.extra.flag = false
                    card.ability.extra.destroy = true
                    return {
                        message = 'Heightened!',
                        colour = G.C.BLACK
                    }
                else
                    return {
                        message = localize('k_safe_ex'),
                        message_card = context.scoring_hand[1]
                    }
                end
            end
        end
        if context.destroy_card and context.destroy_card == context.scoring_hand[1] and card.ability.extra.destroy and not context.blueprint then
            card.ability.extra.destroy = false
            return {
                message = 'Destroyed!',
                remove = true
            }
        end
    end
}
