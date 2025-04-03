SMODS.Enhancement{
    key = "pewterdrag",
    atlas = "scadrial_enhancement",
    pos = {x = 0, y = 0},
    discovered = true,
    always_scores = true,
    config = { extra = { xchips = 4, uses = 4, uses_left = 4, triggers = 0 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips,
                card.ability.extra.uses,
                card.ability.extra.uses_left
            }
        }
	end,
    overrides_base_rank = false,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            card.ability.extra.uses_left = card.ability.extra.uses_left - 1
            card.base.nominal = card.base.nominal * card.ability.extra.xchips
        end
        if context.destroy_card and card.ability.extra.uses_left <= 0 and context.cardarea ~= G.hand then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve({G.C.BLACK, G.C.RED, G.C.RED}, true, 5)
                    return true
                end,
                blocking = true
            }))
            return {
                message = 'Dragged!',
                remove = true
            }
        end
    end
}
