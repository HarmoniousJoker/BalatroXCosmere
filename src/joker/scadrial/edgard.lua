--Edgard: Sell this Joker to immediately gain 75% of required chips for this Blind
SMODS.Joker {
	key = 'edgard',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 'csmr_preserver',
	cost = 6,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context)
        if G.GAME.blind.in_blind and context.selling_card then
			if context.card.config.center.key == 'j_csmr_edgard' then
            	ease_chips(0.75 * G.GAME.blind.chips + G.GAME.chips)
			end
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
				delay = 0.5,
                func = function()
					if G.GAME.chips >= G.GAME.blind.chips then					
						G.STATE = G.STATES.HAND_PLAYED
						G.STATE_COMPLETE = true
						end_round()
					end
					return true
				end
            }))
        end
	end
}
