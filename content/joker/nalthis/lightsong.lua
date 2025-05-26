--Lightsing: Gives Mult equal to half of the sum of the total ranks of all Destroyed Cards
SMODS.Joker {
	key = 'lightsong',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, parts = 2 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult
			}
		}
	end,
	update = function(self, card, dt)
		if not G.GAME.destroyed_cards then
			card.ability.extra.mult = 0
        else
            local _mult_add = 0
            for i=1, #G.GAME.destroyed_cards do
                local card_info = G.GAME.destroyed_cards[i]
                if card_info.base.value then
                    local _rank = base_to_number_rank(card_info.base.value)
                    if not _rank then
                        _mult_add = 0
                    else
                        _mult_add = _mult_add + _rank
                    end
                end
            end
            card.ability.extra.mult = math.floor(_mult_add / card.ability.extra.parts)
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}
