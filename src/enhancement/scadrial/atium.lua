--Atium: Gives 1/8th of the sum of all base chips of remaining cards in deck, rounded down.
SMODS.Enhancement{
    key = "atium",
    atlas = "scadrial_enhancement",
    pos = {x = 0, y = 0}, -- To be updated
    discovered = true,
    always_scores = true,
    overrides_base_rank = false,
    config = { extra = { deck_cards = 0, deck_chips = 0, part = 8, updated = false } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.part,
                card.ability.extra.deck_chips
            }
        }
	end,
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            if card.ability.extra.updated == false then
                card.ability.extra.deck_chips = 0
                for k, v in pairs(G.deck.cards) do
                    card.ability.extra.deck_chips = card.ability.extra.deck_chips + math.floor(v.base.nominal / card.ability.extra.part)
                end
                card.ability.extra.updated = true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.deck_chips
            }
        end
        if #G.deck.cards ~= card.ability.extra.deck_cards then
            card.ability.extra.deck_cards = #G.deck.cards
            card.ability.extra.updated = false
        end
    end
}
