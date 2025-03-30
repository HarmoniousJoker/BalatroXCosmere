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
