--Breath: Enhances 2 cards to Heightened Cards
SMODS.Consumable {
    set = 'Tarot',
    key = 'breath',
    atlas = 'tarot',
    pos = { x = 0, y = 0 },
    config = {
        min_highlighted = 1,
        max_highlighted = 2
    },
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, card)
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
            transform_card(v, 'm_csmr_heightened')
        end
    end
}
