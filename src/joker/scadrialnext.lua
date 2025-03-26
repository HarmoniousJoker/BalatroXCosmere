SMODS.Atlas {
	key = 'scadrial',
	path = 'scadrial.png',
	px = 71,
	py = 95
}

--Function to check if Aces, 2s, 4,s and 8s appear in played hand/discard
--These are Preservation cards
function Card:is_preservation(from_boss)
    if self.debuff and not from_boss then return end
    local id = self:get_id()
    if id == 14 or id == 2 or id == 4 or id == 8 then
        return true
    end
end

--Before scoring, each Preservation card has 4 in 16 chance of turning into a Glass card. 
SMODS.Joker {
	key = 'scdrl_lady',
	atlas = 'scadrial',
	pos = { x = 1, y = 0 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 4 } },
	loc_txt = {
		name = 'Lady Mistborn',
		text = {
			'Before scoring, each {C:attention}Preservation{} card has a',
			'{C:green}4 in 16{} chance of turning into a {C:attention}Glass{} card',
			'{C:inactive}({C:attention}Preservation{} {C:inactive}cards are A, 2, 4, and 8)'
		}
	},
	calculate = function(self, card, context)
		local preservation = {}
		if context.individual and context.cardarea == G.play then	
			for k, v in ipairs(context.scoring_hand) do
				if v:is_preservation() and not SMODS.has_enhancement(v, 'm_glass') then
					if pseudorandom('scdrl_lady') < G.GAME.probabilities.normal/card.ability.extra.odds then
						preservation[#preservation+1] = v
						v:set_ability(G.P_CENTERS.m_glass, nil, true)
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					}))
				end
			end
			if #preservation > 0 then 
				return {
					message = 'Glassed!',
					colour = G.C.CHIPS,
				}
			else
				return {
					message = localize('k_nope_ex'),
					colour = G.C.CHIPS,
				}
			end
		end
	end
}