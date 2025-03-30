--Tindwyl: Played Preservation Cards, when scored, have a 2 in 16 chance of becoming a King or Queen
SMODS.Joker {
	key = 'tindwyl',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { init_odds = 8, end_odds = 2 } },
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_hand then
            if context.other_card:is_preservation() then
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
