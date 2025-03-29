--Kelsier: Gains 20 Chips, when 3 or more face cards are discarded at the same time
SMODS.Joker {
	key = 'kelsier',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
	rarity = 'csmr_preserver',
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
	rarity = 'csmr_preserver',
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
	atlas = 'scadrial',  -- TBD after new art
	pos = { x = 1, y = 0 }, -- TBD after new art
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

--Spook: Upgrade Poker Hand every 8th time it is played
SMODS.Joker {
	key = 'spook',
	atlas = 'scadrial', -- TBD after new art
	pos = { x = 0, y = 0 }, -- TBD after new art
	rarity = 'csmr_preserver',
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

--Elend: 4 in 16 chance of gaining +2 mult per scored face card
SMODS.Joker {
	key = 'elend',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, mult_mod = 2, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
				card.ability.extra.mult,
				card.ability.extra.mult_mod,
			} 
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local upgraded_elend = 0
			if context.other_card:is_face() then 
				if pseudorandom('elend') < G.GAME.probabilities.normal/card.ability.extra.odds then
					upgraded_elend = upgraded_elend + 1
				end
			end
			if upgraded_elend > 0 then
				card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * upgraded_elend)
				return {
					message = 'Upgraded!',
					color = G.C.MULT,
					message_card = card
				}
			end
		end
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

--Marsh: Played cards that are not scored have an 4 in 16 chance of becoming Steel cards
SMODS.Joker {
	key = 'marsh',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 4 } },
	calculate = function(self, card, context)
		if context.individual and context.cardarea == 'unscored' then
			local upgraded_marsh = 0
			if pseudorandom('marsh') < G.GAME.probabilities.normal/card.ability.extra.odds then
				upgraded_marsh = upgraded_marsh + 1
				context.other_card:set_ability(G.P_CENTERS.m_steel, nil, true)
				return {
					message = 'Upgraded!',
					color = G.C.MULT,
					message_card = card
				}
			end
		end
	end
}

--Tindwyl: Played Jacks when scored have a 2 in 16 chance of becoming a King or Queen
SMODS.Joker {
	key = 'tindwyl',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { init_odds = 1, end_odds = 2 } },
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_hand then
            if context.other_card:get_id() == 11 then
                if pseudorandom('tindwyl_one') < G.GAME.probabilities.normal/card.ability.extra.init_odds then
                    local jack_card = context.other_card
					if pseudorandom('tindwyl_two') < G.GAME.probabilities.normal/card.ability.extra.end_odds then
                    	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                            local suit_prefix = string.sub(jack_card.base.suit, 1, 1)..'_'
                            jack_card:juice_up()
                            jack_card:set_base(G.P_CARDS[suit_prefix..'Q'])
							return true end }))
						SMODS.calculate_effect({message = 'Queened!'}, jack_card)
					else
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                            local suit_prefix = string.sub(jack_card.base.suit, 1, 1)..'_'
                            jack_card:juice_up()
                            jack_card:set_base(G.P_CARDS[suit_prefix..'K'])
							return true end }))
						SMODS.calculate_effect({message = 'Kinged!'}, jack_card)
					end
                end 
            end
        end
    end
}

--Sazed: Preserver Jokers each give X1 Mult
SMODS.Joker {
	key = 'sazed',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
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
		if context.before and not context.blueprint and not context.retrigger_joker then
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
