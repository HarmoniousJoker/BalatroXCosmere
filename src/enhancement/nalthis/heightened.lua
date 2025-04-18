--Heightened: Card cannot be debuffed
SMODS.Enhancement{
    key = "heightened",
    atlas = "scadrial_enhancement", -- to be changed
    pos = {x = 0, y = 0},
    discovered = true,
    always_scores = false,
    overrides_base_rank = false,
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            if G.STAGE == G.STAGES.RUN then
                if card.debuff then
                    card:set_debuff(false)
                end
            end
        end
    end,
}
