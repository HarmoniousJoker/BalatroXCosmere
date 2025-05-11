--Thug: Enhances 2 cards to Pewter Cards
SMODS.Consumable {
    set = 'Tarot',
    key = 'thug',
    atlas = 'tarot',
    pos = { x = 0, y = 0 },
    config = {
        min_highlighted = 1,
        max_highlighted = 2
    },
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_csmr_pewter
		return {
			vars = {
				card.ability.max_highlighted
			}
		}
    end,
    can_use = function(self, card)
		if #G.hand.highlighted < card.ability.min_highlighted or #G.hand.highlighted > card.ability.max_highlighted then
			return false
		end
	    return true
	end,
    use = function(self, card)
        for k, v in ipairs(G.hand.highlighted) do
            transform_card(v, 'm_csmr_pewter')
        end
    end
}
