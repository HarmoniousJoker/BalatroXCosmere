--Hammond: This Jokers gains +4 Mult for each Pewter Drag Card in your full deck
SMODS.Joker {
	key = 'hammond',
	--atlas = 'scadrial_joker',
	pos = { x = 9, y = 9 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult_mod = 4, pewterdrag_tally = 0 } },
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
				card.ability.extra.mult_mod,
				card.ability.extra.pewterdrag_tally * card.ability.extra.mult_mod
			} 
		}
	end,
	update = function(self, card, dt)
		if G.STAGE == G.STAGES.RUN then
			card.ability.extra.pewterdrag_tally = 0
			for k, v in pairs(G.playing_cards) do
				if v.config.center == G.P_CENTERS.m_csmr_pewterdrag then
					card.ability.extra.pewterdrag_tally = card.ability.extra.pewterdrag_tally + 1
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.pewterdrag_tally > 0 then
			return {
				mult = card.ability.extra.pewterdrag_tally * card.ability.extra.mult_mod
			}
		end
	end
}
