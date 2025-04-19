--Marsh: One unscored card has a 4 in 16 chance of becoming a Steel card
SMODS.Joker {
	key = 'marsh',
	atlas = 'scadrial_joker',
	pos = { x = 0, y = 1 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 4 } },
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
