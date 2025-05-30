--Marsh: One unscored card has a 8 in 16 chance of becoming a Steel card
SMODS.Joker {
	key = 'marsh',
	atlas = 'scadrial_joker',
	pos = { x = 0, y = 1 },
	rarity = 3,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	calculate = function(self, card, context)
		if context.after then
			local scored_lookup = {}
			for _, v in ipairs(context.scoring_hand) do
				scored_lookup[v] = true
			end

			local unscored_cards = {}
			for _, v in ipairs(G.play.cards) do
				if not scored_lookup[v] then
					table.insert(unscored_cards, v)
				end
			end
			if #unscored_cards > 0 then
				if pseudorandom('marsh') < G.GAME.probabilities.normal / card.ability.extra.odds then
					local steel_card = pseudorandom_element(unscored_cards, pseudoseed('marsh1'))
					transform_card(steel_card, 'm_steel')
					return {
						message = 'Steeled!',
						message_card = steel_card
					}
				else
					return {
						message = 'Raided!',
					}
				end
			end
		end
	end
}
