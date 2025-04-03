--Vin: Retriggers all Lucky cards 
SMODS.Joker {
	key = 'vin',
	atlas = 'scadrial_joker',
	pos = { x = 1, y = 0 },
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
