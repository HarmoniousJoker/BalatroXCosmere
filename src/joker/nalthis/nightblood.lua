--Nightblood: Before scoring, debuff a played card randomly and gain 0.1x mult. Debuffed cards reset at end of Ante or when Joker is sold
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
        if context.setting_blind and not context.blueprint then
            for k, v in ipairs(G.playing_cards) do
                if v.csmr_debuff_nightblood then
                    v:set_debuff(true)
                end
            end
        end
        if context.before and not context.blueprint then
            local cards = {}
            for k, v in ipairs(G.play.cards) do
                if not v.debuff then
                    table.insert(cards, v)
                end
            end
            if #cards > 0 then
                local debuffed_card = pseudorandom_element(cards, pseudoseed('nightblood'))
                debuffed_card:set_debuff(true)
                debuffed_card.csmr_debuff_nightblood = true
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_mod
                card:juice_up()
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                color = G.C.BLACK
            }
        end
        if context.end_of_round and G.GAME.blind.boss and not context.blueprint then
            for k, v in ipairs(G.playing_cards) do
                if v.csmr_debuff_nightblood then
                    v:set_debuff(false)
                end
            end
        end
        if context.selling_card and not context.blueprint then
            if context.card.config.center.key == 'j_csmr_nightblood' then
                for k, v in ipairs(G.playing_cards) do
                    if v.csmr_debuff_nightblood then
                        v:set_debuff(false)
                    end
                end
            end
        end
    end
}
