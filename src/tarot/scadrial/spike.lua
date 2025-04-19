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
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= rightmost then
                    modify_card(G.hand.highlighted[i], rightmost)
                end
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.5)
        for i=1, #G.hand.highlighted do
            if G.hand.highlighted[i] ~= rightmost then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:start_dissolve(); return true end }))
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end,
}
