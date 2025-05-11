--Vin: Retriggers all Lucky cards, transforms into Lady Mistborn after 8 rounds
SMODS.Joker {
	key = 'vin',
	atlas = 'scadrial_joker',
	pos = { x = 1, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	enhancement_gate = 'm_lucky',
	config = { extra = { rounds = 1, uses = 0, flag = false } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_csmr_lucky
		return {
			vars = {
				card.ability.extra.rounds,
				card.ability.extra.rounds - card.ability.extra.uses
			}
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.flag = false
		end
        if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                    return {
                        repetitions = 1,
                    }
            end
        end
		if context.end_of_round and not card.ability.extra.flag and config.evolution_enabled then
			card.ability.extra.flag = true
			card.ability.extra.uses = card.ability.extra.uses + 1
			if card.ability.extra.uses == card.ability.extra.rounds then
				transform_card(card, 'j_csmr_ladymistborn')
				SMODS.calculate_effect({message = 'Upgraded!'}, card)
			end
		end
    end
}
