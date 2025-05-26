--Pewter: Always scores and Doubles chips, starting with base chips, destroyed after 4 uses
SMODS.Enhancement{
    key = "pewter",
    atlas = "scadrial_enhancement",
    pos = {x = 0, y = 0},
    discovered = true,
    always_scores = true,
    overrides_base_rank = false,
    config = { extra = { xchips = 2, uses = 0, uses_left = 4, chips = 0, updated = false } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips,
                card.ability.extra.chips,
                card.ability.extra.uses_left
            }
        }
	end,
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            if card.ability.extra.updated == false then
                card.ability.extra.chips = card.base.nominal * (card.ability.extra.xchips ^ card.ability.extra.uses)
                card.ability.extra.updated = true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.final_scoring_step and context.cardarea == G.play then
            card.ability.extra.uses_left = card.ability.extra.uses_left - 1
            card.ability.extra.uses = card.ability.extra.uses + 1
            card.ability.extra.updated = false
        end
        if context.destroy_card and card.ability.extra.uses_left == 0 and context.destroy_card == card and context.cardarea ~= G.hand then
            return {
                message = 'Dragged!',
                remove = true
            }
        end
    end
}
