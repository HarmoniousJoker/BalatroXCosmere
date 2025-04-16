--Marsh: Played cards that are not scored have an 4 in 16 chance of becoming Steel cards
SMODS.Joker {
	key = 'marsh',
	atlas = 'scadrial_joker',
	pos = { x = 5, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 4 } },
	calculate = function(self, card, context)
		if context.individual and context.cardarea == 'unscored' then
			local upgraded_marsh = 0
			if pseudorandom('marsh') < G.GAME.probabilities.normal/card.ability.extra.odds then
				upgraded_marsh = upgraded_marsh + 1
				context.other_card:set_ability(G.P_CENTERS.m_steel, nil, true)
				return {
					message = 'Upgraded!',
					color = G.C.MULT,
					message_card = card
				}
			end
		end
	end
}
