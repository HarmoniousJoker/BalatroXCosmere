--Lestibournes: Upgrade Poker Hand every 4th time it is played
SMODS.Joker {
	key = 'lestibournes',
	atlas = 'scadrial_joker',
	pos = { x = 2, y = 0 },
	rarity = 'csmr_preserver',
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = {
		extra = {
			hands = 4,
			played_hands = {},
			current_hand = nil,
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
				card.ability.extra.played_hands[context.scoring_name] = 0
				return {
					level_up = true,
					message = localize('k_level_up_ex')
				}
			else
				return {
					message = card.ability.extra.hands - card.ability.extra.played_hands[context.scoring_name] .. ' hand(s) left',
				}
			end
        end
	end
}
