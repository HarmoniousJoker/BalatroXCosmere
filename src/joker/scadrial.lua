--Survivor of Hathsin: Gains 20 Chips, when 3 or more face cards are discarded at the same time
SMODS.Joker {
	key = 'survivor',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { chip = 0, chip_mod = 20, faces = 3 } },
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
				card.ability.extra.chip_mod,
				card.ability.extra.chip
			} 
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.chip > 0 then
			return {
				chips = card.ability.extra.chip
			}
		end
		if context.pre_discard then
			local face_cards = 0
			for k, v in ipairs(context.full_hand) do
				if v:is_face() then 
					face_cards = face_cards + 1 
				end
			end
			if face_cards >= card.ability.extra.faces and not context.blueprint then
				card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.chip_mod
				return {
					message = 'Upgraded!',
					color = G.C.CHIPS
				}
			end
		end
	end
}

--Vin: Retriggers all Lucky cards 
SMODS.Joker {
	key = 'vin',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 }, -- TBD after new art
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then    
			if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                    return {
                        repetitions = 1,
                    }
            end
        end
    end
}

--Dockson: Earn $2 per scored preservation numbers, dies after 8 rounds
SMODS.Joker {
	key = 'dockson',
	atlas = 'dockson',  -- TBD after new art
	pos = { x = 1, y = 0 }, -- TBD after new art
	rarity = 1,
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

--Spook: Upgrade Poker Hand every 8th time it is played
SMODS.Joker {
	key = 'spook',
	atlas = 'spook', -- TBD after new art
	pos = { x = 0, y = 0 }, -- TBD after new art
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = {
		extra = {
			hands = 8,
			played_hands = {}
		}
	},
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
				card.ability.extra.hands,
			} 
		}
	end,
	calculate = function(self, card, context)
        if context.before then
			card.ability.extra.played_hands[context.scoring_name] = (card.ability.extra.played_hands[context.scoring_name] or 0) + 1
			if card.ability.extra.played_hands[context.scoring_name] % card.ability.extra.hands == 0 then
				return {
					level_up = true,
					message = localize('k_level_up_ex')
				}
			end
        end
	end
}