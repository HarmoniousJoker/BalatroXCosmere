--Siri: Each played Heightened Card, before scoring, has a 1 in 5 chance of making the cards around it Heightened
SMODS.Joker {
	key = 'siri',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
    enhancement_gate = 'm_csmr_heightened',
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.odds,
			}
		}
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
            local i = 1
            while i <= #context.full_hand do
                if SMODS.has_enhancement(context.full_hand[i], 'm_csmr_heightened') then
                    if pseudorandom('siri') < G.GAME.probabilities.normal/card.ability.extra.odds then
                        if i - 1 > 0 then
                            transform_card(context.full_hand[i-1],'m_csmr_heightened')
                        end
                        if i + 1 <= #context.full_hand then
                            transform_card(context.full_hand[i+1],'m_csmr_heightened')
                        end
                        i = i + 2
                    else
                        i = i + 1
                    end
                else
                    i = i + 1
                end
            end
        end
    end
}
