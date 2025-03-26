SMODS.Atlas {
	key = 'scadrial',
	path = 'scadrial.png',
	px = 71,
	py = 95
}

--Gains 20 Chips, when 3 or more face cards are discarded at the same time.
SMODS.Joker {
	key = 'scdrl_survivor',
	atlas = 'scadrial',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { chip = 0, chip_mod = 20, faces = 3 } },
	loc_txt = {
		name = 'Survivor of Hathsin',
		text = {
			'This Joker gains {C:blue}+#1#{} Chips,',
			'if {C:attention}3{} or more {C:attention}face cards{}',
			'are discarded at the same time',
			'{C:inactive}(Currently {C:blue}+#2#{C:inactive} Chips)'
		}
	},
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

--Retriggers all Lucky cards twice 
SMODS.Joker {
	key = 'scdrl_vin',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 }, -- TBD after new art
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	loc_txt = {
		name = 'Vin',
		text = {
			'Retriggers all {c:attention}Lucky{} cards twice'
		}
	},
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then	
			for k, v in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, 'm_lucky') then
					return {
						message = "Again!",
                        repetitions = 2,
					}
				end
			end
		end
	end
}