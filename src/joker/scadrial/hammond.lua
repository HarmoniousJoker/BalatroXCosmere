--Hammond: This Jokers gains +4 Mult for each Stone card in your full deck
SMODS.Joker {
	key = 'hammond',
	--atlas = 'scadrial',
	pos = { x = 9, y = 9 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult_mod = 4, stone_tally = 0 } },
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
				card.ability.extra.mult_mod,
				card.ability.extra.stone_tally * card.ability.extra.mult_mod
			} 
		}
	end,
	update = function(self, card, dt)
		if G.STAGE == G.STAGES.RUN then
			card.ability.extra.stone_tally = 0
			for k, v in pairs(G.playing_cards) do
				if v.config.center == G.P_CENTERS.m_stone then 
					card.ability.extra.stone_tally = card.ability.extra.stone_tally + 1
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.stone_tally > 0 then
			return {
				mult = card.ability.extra.stone_tally * card.ability.extra.mult_mod
			}
		end
	end
}
