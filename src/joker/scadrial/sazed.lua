--Sazed: Preserver Jokers each give X1 Mult
SMODS.Joker {
	key = 'sazed',
	--atlas = 'scadrial_joker',
	pos = { x = 9, y = 9 },
	rarity = 'csmr_preserver',
	cost = 8,
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
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.xmult = 0
			for k,v in ipairs(G.jokers.cards) do
				if v.config.center.rarity == 'csmr_preserver' and v.ability.set == 'Joker' and not v.debuff then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(0.3, 0.4)
							return true
						end,
					}))
				end
			end
		elseif context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end
}
