--Kandra: Create 2 copies of the last destroyed card with a random enhancement and seal
SMODS.Consumable {
    set = 'Tarot',
    key = 'kandra',
    atlas = 'tarot',
    pos = { x = 0, y = 0 },
    config = {
        copies = 2,
    },
    discovered = true,
    unlocked = true,
    in_pool = function(self, args)
        if not G.GAME.destroyed_cards then
            G.GAME.destroyed_cards = {}
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.copies
			}
		}
    end,
    can_use = function(self, card)
		if not G.GAME.destroyed_cards or #G.hand.cards < 1 then
			return false
		end
	    return true
	end,
    use = function(self)
        local card_info = G.GAME.destroyed_cards[#G.GAME.destroyed_cards]
        local cen_pool = {}
        for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
            cen_pool[#cen_pool+1] = v
        end
        for i=1, self.config.copies do
            local _rank = base_to_letter_rank(card_info.base.value)
            local _suit = base_to_suit(card_info.base.suit)
            local _card = create_playing_card({
                front = G.P_CARDS[_suit..'_'.._rank],
                center = pseudorandom_element(cen_pool, pseudoseed('kandra'))
            }, G.hand, false, false, nil)
            local seal_type = pseudorandom(pseudoseed('kandra1'))
            if seal_type > 0.75 then _card:set_seal('Red', true)
            elseif seal_type > 0.5 then _card:set_seal('Blue', true)
            elseif seal_type > 0.25 then _card:set_seal('Gold', true)
            else _card:set_seal('Purple', true) end
            _card:set_edition(card_info.edition.key, nil, true)
            _card:add_to_deck()
            table.insert(G.playing_cards, _card)
            _card.states.visible = nil
            G.GAME.blind:debuff_card(_card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    return true
                    end}))
        end
    end
}