--Spike: Select 2 cards, apply the modifications of the left card on the right card, destroy the left card
SMODS.Consumable {
    set = 'Tarot',
    key = 'spike',
    atlas = 'tarot',
    pos = { x = 0, y = 0 },
    config = {
        highlighted = 2,
    },
    discovered = true,
    unlocked = true,
    can_use = function(self, card)
		if #G.hand.highlighted ~= self.config.highlighted then
			return false
		end
	    return true
	end,
    use = function(self, card)
        local leftmost = G.hand.highlighted[1]
        local rightmost = G.hand.highlighted[2]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        modify_card(leftmost, rightmost)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            leftmost:start_dissolve()
            return true end }))
        end,
}
