--Code Credit: https://github.com/BustyCatbot/AetherJokers/
--God King: Converts any played Straight, Full House, or Five of a Kind into its Flush Variant and converts all scored cards into Wild Cards
SMODS.Joker {
	key = 'godking',
    atlas = 'joker',
	pos = { x = 0, y = 0 },
    rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	config = {extra = { scored_cards = 0, triggers = 0 } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.before and (next(context.poker_hands['Straight']) or next(context.poker_hands['Full House']) or next(context.poker_hands['Five of a Kind'])) and not next(context.poker_hands['Straight Flush']) and not next(context.poker_hands['Flush House']) and not next(context.poker_hands['Flush Five']) and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.3,0.5)
                    return true
                end,
                blocking = true
            }))
            if next(context.poker_hands['Straight']) then
                G.GAME.old_poker_hand = 'Straight'
                G.GAME.new_poker_hand = 'Straight Flush'
            elseif next(context.poker_hands['Full House']) then
                G.GAME.old_poker_hand = 'Full House'
                G.GAME.new_poker_hand = 'Flush House'
            elseif next(context.poker_hands['Five of a Kind']) then
                G.GAME.old_poker_hand = 'Five of a Kind'
                G.GAME.new_poker_hand = 'Flush Five'
            end
            context.poker_hands[G.GAME.new_poker_hand] = context.poker_hands[G.GAME.old_poker_hand]
            context.scoring_hand = G.GAME.hands[G.GAME.new_poker_hand][1]
            update_hand_text({delay = 0}, {chips = G.GAME.hands[G.GAME.new_poker_hand].chips, mult = G.GAME.hands[G.GAME.new_poker_hand].mult, handname = G.GAME.new_poker_hand})
            for k,v in pairs(G.play.cards) do
                if not SMODS.has_enhancement(v, 'm_wild') and not v.debuff then
                    SMODS.debuff_card(v, 'prevent_debuff', 'godking')
                end
            end
            for k,v in pairs(G.jokers.cards) do
                if v.ability.type == 'Flush' or (G.GAME.new_poker_hand == 'Straight Flush' and v.ability.type == 'Straight Flush') then
                    v.force_trigger = true
                end
            end
            card.ability.extra.triggers = 1
            return {
                message = 'Heightened!',
                colour = G.C.BLACK
            }
        end
        if context.final_scoring_step and card.ability.extra.triggers >= 1 then
            card.ability.extra.triggers = 0
            flushified_card = 1
            for k,v in pairs(G.play.cards) do
                if not SMODS.has_enhancement(v, 'm_wild') and not SMODS.has_enhancement(v, 'm_stone') and not SMODS.has_enhancement(v, 'm_aether_sleeved') and not v.debuff then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up(0.3,0.5)
                            v:flip()
                            return true
                        end,
                        blocking = true
                    }))
                    delay(0.2)
                    v:set_ability(G.P_CENTERS.m_wild, nil, true)
                    SMODS.debuff_card(v, 'reset', 'godking')
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up(0.3,0.5)
                            v:flip()
                            v:start_materialize({G.C.BLACK}, true, 1)
                            flushified_card = flushified_card + 1
                            return true
                        end,
                        blocking = true
                    }))
                    delay(0.1)
                end
            end
        end
    end
}