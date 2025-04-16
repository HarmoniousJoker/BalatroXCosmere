--Nightblood: Before scoring, debuff a played card randomly and gain 0.1x mult. Debuffed cards reset at end of Ante
SMODS.Joker{
    key = 'nightblood',
    atlas = 'joker',
	pos = { x = 0, y = 0 },
    rarity = 2,
	cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	config = {extra = { xmult = 1, mult_mod = 0.1, debuffed_cards = {} } },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult_mod,
                card.ability.extra.xmult,
			}
		}
	end,
	calculate = function(self, card, context)
        if context.setting_blind then
            for k, v in ipairs(card.ability.extra.debuffed_cards) do
                v:set_debuff(true)
            end
        end
        if context.before then
            local cards = {}
            for k, v in ipairs(G.play.cards) do
                if not v.debuff then
                    table.insert(cards, v)
                end
            end
            if #cards > 0 then
                local debuffed_card = pseudorandom_element(cards, pseudoseed('nightblood'))
                debuffed_card:set_debuff(true)
                table.insert(card.ability.extra.debuffed_cards, debuffed_card)
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_mod
                debuffed_card:juice_up()
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                color = G.C.BLACK
            }
        end
        if context.end_of_round and G.GAME.blind.boss and #card.ability.extra.debuffed_cards > 0 then
            for k, v in ipairs(card.ability.extra.debuffed_cards) do
                v:set_debuff(false)
            end
            card.ability.extra.debuffed_cards = {}
        end
    end
}
