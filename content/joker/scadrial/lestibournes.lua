--Lestibournes: Upgrade Poker Hand every 4th time it is played
SMODS.Joker {
	key = 'lestibournes',
	atlas = 'scadrial_joker',
	pos = { x = 3, y = 0 },
	rarity = 2,
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
		local hand_selected = nil
		if G.hand and G.hand.highlighted then
			local ok, result = pcall(function()
				return select(1, G.FUNCS.get_poker_hand_info(G.hand.highlighted))
			end)
			if ok then
				hand_selected = result
			end
		end
		if hand_selected == 'NULL' then
			hand_selected = nil
		end
		if hand_selected then
			if card.ability.extra.played_hands[hand_selected] == nil then
				card.ability.extra.played_hands[hand_selected] = 0
			end
		end
		return {
			vars = {
				card.ability.extra.hands,
				hand_selected,
				card.ability.extra.played_hands[hand_selected],
			}
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	update = function(self, card, dt)
		if G.STAGE == G.STAGES.RUN then
			local hand = select(1, G.FUNCS.get_poker_hand_info(G.hand.highlighted))
			if not hand or hand == 'NULL' then
				card.ability.extra.last_juiced_hand = nil
				return
			end
			if card.ability.extra.played_hands[hand] == nil then
				card.ability.extra.played_hands[hand] = 0
			end
			if card.ability.extra.last_juiced_hand == hand then
				return
			end
			card.ability.extra.last_juiced_hand = hand
			local eval = function()
				local current_hand = select(1, G.FUNCS.get_poker_hand_info(G.hand.highlighted))
				return current_hand and current_hand ~= 'NULL'
					and card.ability.extra.played_hands[current_hand] == (card.ability.extra.hands - 1)
			end
			juice_card_until(card, eval, true)
		end
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
			end
        end
	end
}
