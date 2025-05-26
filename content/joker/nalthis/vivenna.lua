--Vivenna: This Joker gives +5 mult for each unscored card
SMODS.Joker {
	key = 'vivenna',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, mult_mod = 5 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod
            }
        }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
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
				return {
                    mult = card.ability.extra.mult_mod * #unscored_cards
                }
			end
		end
	end
}
