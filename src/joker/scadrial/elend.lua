--Elend: 4 in 16 chance of gaining +2 mult per scored face card
SMODS.Joker {
	key = 'elend',
	atlas = 'scadrial_joker',
	pos = { x = 5, y = 0 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, mult_mod = 2, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.mult_mod,
			}
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local upgraded_elend = 0
			if context.other_card:is_face() then 
				if pseudorandom('elend') < G.GAME.probabilities.normal/card.ability.extra.odds then
					upgraded_elend = upgraded_elend + 1
				end
			end
			if upgraded_elend > 0 then
				card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * upgraded_elend)
				return {
					message = 'Upgraded!',
					color = G.C.MULT,
					message_card = card
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
