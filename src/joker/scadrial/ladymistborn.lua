--Lady Mistborn: Preservation cards, before scoring, have a 4 in 16 chance of turning into a Glass Card 
SMODS.Joker {
	key = 'csmr_ladymistborn',
	atlas = 'scadrial_joker',
	pos = { x = 2, y = 0 },
	rarity = 'csmr_preserver',
    in_pool = function(self)
        return false
    end,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = { extra = { odds = 4 } },
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_preservation() and not SMODS.has_enhancement(v, 'm_glass') then
                    if pseudorandom('lady_mistborn') < G.GAME.probabilities.normal/card.ability.extra.odds then
                        transform_card(v, 'm_glass')
                        SMODS.calculate_effect({message = 'Glassed!'}, v)
                    else
                        SMODS.calculate_effect({message = localize('k_nope_ex')}, v)
                    end
                end
            end
        end
	end
}
