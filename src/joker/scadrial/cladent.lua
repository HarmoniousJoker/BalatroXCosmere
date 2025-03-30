--Cladent: 2 in 16 chance of disabling Boss Blind
SMODS.Joker {
	key = 'cladent',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 8 } },
	calculate = function(self, card, context)
		if context.setting_blind then
			if pseudorandom('cladent') < G.GAME.probabilities.normal/card.ability.extra.odds then
				if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
						G.GAME.blind:disable()
						return true end }))
				end
			else
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_nope_ex')})
			end
		end
	end
}
