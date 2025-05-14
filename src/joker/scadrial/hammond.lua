--Hammond: This Jokers gains +4 Mult for each Pewter Card in your full deck
SMODS.Joker {
	key = 'hammond',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	enhancement_gate = 'm_csmr_pewter',
	config = { extra = { mult_mod = 4, pewter_tally = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_csmr_pewter
		return {
			vars = {
				card.ability.extra.mult_mod,
				card.ability.extra.pewter_tally * card.ability.extra.mult_mod
			}
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	update = function(self, card, dt)
		if G.STAGE == G.STAGES.RUN then
			card.ability.extra.pewter_tally = 0
			for k, v in pairs(G.playing_cards) do
				if v.config.center == G.P_CENTERS.m_csmr_pewter then
					card.ability.extra.pewter_tally = card.ability.extra.pewter_tally + 1
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.pewter_tally > 0 then
			return {
				mult = card.ability.extra.pewter_tally * card.ability.extra.mult_mod
			}
		end
	end
}
