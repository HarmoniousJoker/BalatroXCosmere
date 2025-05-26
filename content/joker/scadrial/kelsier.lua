--Kelsier: Gains 20 Chips, when 3 or more face cards are discarded at the same time
SMODS.Joker {
	key = 'kelsier',
	atlas = 'scadrial_joker',
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
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
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
