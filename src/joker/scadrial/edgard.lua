--Edgard: Sell this Joker to immediately gain 75% of required chips for this Blind
SMODS.Joker {
	key = 'edgard',
	--atlas = 'scadrial_joker',
	pos = { x = 9, y = 9 },
	rarity = 'csmr_preserver',
	cost = 6,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context)
        if G.GAME.blind.in_blind and context.selling_card then
            ease_chips(0.75 * G.GAME.blind.chips + G.GAME.chips)
        end
	end
}
