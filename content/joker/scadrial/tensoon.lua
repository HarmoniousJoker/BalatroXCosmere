--TenSoon: Copies the ability of a random joker each round
SMODS.Joker {
	key = 'tensoon',
	atlas = 'joker',
	pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
	config ={ extra = { selectedJoker = nil, flag = false} },
	loc_vars = function(self,info_queue,card)
		if card.ability.extra.selectedJoker then
			return {vars = {localize({ type = "name_text", set = "Joker", key = card.ability.extra.selectedJoker.config.center.key })}}
		else
			return {vars = {'None'}}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_csmr_preserver'), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	calculate = function(self, card, context)
		if context.setting_blind or not card.ability.extra.flag then
			local jokerList = {}
			for _, v in ipairs(G.jokers.cards) do
				if v ~= card and v.ability and v.ability.name ~= 'TenSoon' and v.config and v.config.center and v.config.center.blueprint_compat then
					table.insert(jokerList, v)
				end
            end
			if #jokerList > 0 then
				card.ability.extra = card.ability.extra or {}
				card.ability.extra.selectedJoker = pseudorandom_element(jokerList, pseudoseed('tensoon'))
			else
				card.ability.extra = {}
			end
			card.ability.extra.flag = true
		end
		local copied = card.ability.extra and card.ability.extra.selectedJoker
		if copied and copied.calculate_joker then
			-- Prevent infinite recursion
			context.blueprint = (context.blueprint or 0) + 1
			return copied:calculate_joker(context)
		end
		if context.end_of_round then
			card.ability.extra.flag = false
		end
	end
}
