--Dockson: Earn $2 per scored preservation numbers, dies after 8 rounds
SMODS.Joker {
	key = 'dockson',
	--atlas = 'scadrial',
	pos = { x = 9, y = 9 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	config = { extra = { gold = 2, rounds = 8 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.gold, 
				card.ability.extra.rounds 
			}
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if card.ability.extra.rounds == 1 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = localize('k_eaten_ex'), --Message to be customized later
					colour = G.C.FILTER
				}
			else
				card.ability.extra.rounds = card.ability.extra.rounds - 1
			end
		end
		if context.individual and context.cardarea == G.play and context.scoring_hand then
			if context.other_card:is_preservation() then 
				return {
					dollars = card.ability.extra.gold
				}
			end
		end
	end
}
