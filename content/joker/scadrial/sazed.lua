local preserver_jokers = {
	['j_csmr_cladent'] = true,
	['j_csmr_dockson'] = true,
	['j_csmr_edgard'] = true,
	['j_csmr_elend'] = true,
	['j_csmr_hammond'] = true,
	['j_csmr_kelsier'] = true,
	['j_csmr_ladymistborn'] = true,
	['j_csmr_lestibournes'] = true,
	['j_csmr_marsh'] = true,
	['j_csmr_sazed'] = true,
	['j_csmr_tensoon'] = true,
	['j_csmr_tindwyl'] = true,
	['j_csmr_vin'] = true,
}

--Sazed: Preserver Jokers each give X1 Mult
SMODS.Joker {
	key = 'sazed',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { xmult = 0, xmult_gain = 1 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult_gain,
			}
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.xmult = 0
			for k,v in ipairs(G.jokers.cards) do
				local joker_key = v.config.center.key
				print(joker_key)
				if preserver_jokers[joker_key] and v.ability.set == 'Joker' and not v.debuff then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				end
			end
		elseif context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end
}
