--Optional features
SMODS.optional_features = {
    quantum_enhancements = true,
    cardareas = {
        unscored=true,
        discard = true,
        deck = true
    }
}

--Atlases
SMODS.Atlas{
    key = 'modicon',
    path = 'modicon.png',
    px = 34,
    py = 34
}

SMODS.Atlas {
	key = 'scadrial_joker',
	path = 'scadrial_joker.png',
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = 'scadrial_enhancement',
	path = 'scadrial_enhancement.png',
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = 'nalthis_enhancement',
	path = 'nalthis_enhancement.png',
	px = 71,
	py = 95
}

--Placeholder Atlases
SMODS.Atlas {
    key = 'joker',
    path = 'temp_joker.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'tarot',
    path = 'temp_tarot.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'spectral',
    path = 'temp_spectral.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'tarot',
    path = 'temp_tarot.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'voucher',
    path = 'temp_voucher.png',
    px = 71,
    py = 95
}

--Custom Rarities
G.C.CSMR_PRESERVERS = HEX('000000')
SMODS.Rarity{
  key = 'preserver',
  badge_colour = G.C.CSMR_PRESERVERS,
  default_weight = 0.25,
  pools = {['Joker'] = true},
}

--Extra tabs in Mod Menu
SMODS.current_mod.extra_tabs = function()
    local scale = 0.5
    return {
        label = 'Credits',
        tab_definition_function = function()
        return {
            n = G.UIT.ROOT,
            config = {
            align = 'cm',
            padding = 0.05,
            colour = G.C.CLEAR,
            },
            nodes = {
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = 'cm'
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = 'Programming: HarmoniousJoker',
                    shadow = false,
                    scale = scale,
                    colour = G.C.YELLOW
                    }
                }
                }
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = 'cm'
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = 'Art: Aakankshy, Hollow',
                    shadow = false,
                    scale = scale,
                    colour = G.C.GREEN
                    }
                },
                }
            },
            }
        }
        end
    }
end

--Functions
--Function to check if Aces, 2s, 4,s and 8s appear in played hand/discard
function Card:is_preservation()
    local id = self:get_id()
    if id == 14 or id == 2 or id == 4 or id == 8 then
        return true
    end
end

--Function to modify right card with left card's properties
function modify_card(left, right)
    local right = right or Card(left.T.x, left.T.y, G.CARD_W*(card_scale or 1), G.CARD_H*(card_scale or 1), G.P_CARDS.empty, G.P_CENTERS.c_base, {playing_card = playing_card})
    right:set_ability(left.config.center)
    right.ability.type = left.ability.type
    if not strip_edition then 
        right:set_edition(left.edition or {}, nil, true)
    end
    check_for_unlock({type = 'have_edition'})
    right:set_seal(left.seal, true)
    if left.params then
        right.params = left.params
        right.params.playing_card = playing_card
    end
    right.debuff = left.debuff
    right.pinned = left.pinned
    return right
end

--Function to alter Scoring Joker effects
local base_calculate_joker = Card.calculate_joker
function Card.calculate_joker(self,context)
	local ret = base_calculate_joker(self, context)
    if context.joker_main then
        if self.force_trigger then
            self.force_trigger = false
            if self.ability.t_chips > 0 then
                return {
                    message = localize{type='variable',key='a_chips',vars={self.ability.t_chips}},
                    chip_mod = self.ability.t_chips
                }
            end
            if self.ability.t_mult > 0 then
                return {
                    message = localize{type='variable',key='a_mult',vars={self.ability.t_mult}},
                    mult_mod = self.ability.t_mult
                }
            end
            if self.ability.Xmult > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.x_mult}},
                    colour = G.C.RED,
                    Xmult_mod = self.ability.x_mult
                }
            end
        end
    end

	if G.GAME.blind:get_type() == 'Boss' and G.GAME.round_resets.blind_choices.Boss == 'bl_csmr_lordruler' then
        multiplier = G.GAME['LordRulerMultiplier']
		if context.end_of_round then
            G.GAME['LordRulerMultiplier'] = 1
			return ret
		end
		if self.ability.name == 'Blueprint' or self.ability.name == 'Brainstorm' and not context.end_of_round then
				return ret
		end

		if not ret then return ret end

		-- Mult
		if ret.Xmult_mod then ret.Xmult_mod = ret.Xmult_mod * multiplier end
		if ret.mult_mod then ret.mult_mod = ret.mult_mod * multiplier end
		if ret.x_mult then ret.x_mult = ret.x_mult * multiplier end
		if ret.h_mult then ret.h_mult = ret.h_mult * multiplier end
		if ret.mult then ret.mult = ret.mult * multiplier end

		-- Chips
		if ret.chip_mod then ret.chip_mod = ret.chip_mod * multiplier end
		if ret.chips then ret.chips = ret.chips * multiplier end
		return ret
    end

    if G.GAME.blind:get_type() == 'Boss' and G.GAME.round_resets.blind_choices.Boss == 'bl_csmr_denth' then
        multiplier = self.ability.multiplier or 1
        if not ret then return ret end

        -- Mult
        if ret.Xmult_mod then ret.Xmult_mod = ret.Xmult_mod * multiplier end
        if ret.mult_mod then ret.mult_mod = ret.mult_mod * multiplier end
        if ret.x_mult then ret.x_mult = ret.x_mult * multiplier end
        if ret.h_mult then ret.h_mult = ret.h_mult * multiplier end
        if ret.mult then ret.mult = ret.mult * multiplier end

        -- Chips
        if ret.chip_mod then ret.chip_mod = ret.chip_mod * multiplier end
        if ret.chips then ret.chips = ret.chips * multiplier end
        self.ability.multiplier = 1
        return ret
    end
    return ret
end

--Function to store card information
function card_information(other, playing_card)
    local scale = 1
    local card_snapshot = {}
    card_snapshot.T = { x = other.T.x, y = other.T.y }
    card_snapshot.width = G.CARD_W * scale
    card_snapshot.height = G.CARD_H * scale
    card_snapshot.playing_card = playing_card
    card_snapshot.base = other.config.card
    card_snapshot.center = other.config.center
    card_snapshot.ability = {}
    card_snapshot.ability.type = other.ability.type
    for k, v in pairs(other.ability) do
        if type(v) == 'table' then 
            card_snapshot.ability[k] = copy_table(v)
        else
            card_snapshot.ability[k] = v
        end
    end
    card_snapshot.edition = other.edition or {}
    check_for_unlock({type = 'have_edition'})
    card_snapshot.seal = other.seal
    if other.params then
        card_snapshot.params = copy_table(other.params)
        card_snapshot.params.playing_card = playing_card
    end
    card_snapshot.pinned = other.pinned
    return card_snapshot
end

--Function to capture destroyed cards' information
local function capture_destroyed_card(context)
    if G.STAGE == G.STAGES.RUN and context.remove_playing_cards then
        for k, v in ipairs(context.removed) do
            local info = card_information(v, nil, G.playing_card)
            if not G.GAME.destroyed_cards then
                G.GAME.destroyed_cards = {}
            end
            table.insert(G.GAME.destroyed_cards, info)
        end
    end
end
local base_calculate_context = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    capture_destroyed_card(context)
    return base_calculate_context(context, return_table)
end

-- Convert the 'value' (rank) into its one-character equivalent (e.g. 'Ace' -> 'A', '2' -> '2')
function base_to_letter_rank(base_rank)
    -- Map of face names to their one-letter equivalents
    local rank_letter = {
        ['Ace']   = 'A',
        ['Jack']  = 'J',
        ['Queen'] = 'Q',
        ['King']  = 'K',
    }
    return rank_letter[base_rank] or base_rank
end

-- Convert the 'value' (rank) into its one-character equivalent (e.g. 'Ace' -> 1, '2' -> 2)
function base_to_number_rank(base_rank)
    -- Map of face names to their one-letter equivalents
    local rank_letter = {
        ['Ace']   = 1,
        ['Jack']  = 10,
        ['Queen'] = 10,
        ['King']  = 10,
    }
    return tonumber(rank_letter[base_rank]) or tonumber(base_rank)
end

-- Convert the 'suit' into its first letter (e.g. 'Diamonds' -> 'D', 'Spades' -> 'S')
function base_to_suit(base_suit)
    if not base_suit or base_suit == '' then
        return ''
    end
    return base_suit:sub(1, 1)
end

--Function to modify Poker Hand
local base_modify_hand = Blind.modify_hand
function Blind:modify_hand(cards, poker_hands, text, mult, hand_chips)
    local mult, hand_chips, modded = base_modify_hand(self, cards, poker_hands, text, mult, hand_chips)

    if G.GAME.new_poker_hand then

        G.GAME.hands[G.GAME.old_poker_hand].played = G.GAME.hands[G.GAME.old_poker_hand].played - 1
        G.GAME.hands[G.GAME.old_poker_hand].played_this_round = G.GAME.hands[G.GAME.old_poker_hand].played_this_round - 1

        G.GAME.hands[G.GAME.new_poker_hand].played = G.GAME.hands[G.GAME.new_poker_hand].played + 1
        G.GAME.hands[G.GAME.new_poker_hand].played_this_round = G.GAME.hands[G.GAME.new_poker_hand].played_this_round + 1

        G.GAME.last_hand_played = G.GAME.new_poker_hand
        set_hand_usage(G.GAME.new_poker_hand)
        G.GAME.hands[G.GAME.new_poker_hand].visible = true

        if self.name == 'The Eye' then

            if self.hands[G.GAME.old_poker_hand] then
                self.hands[G.GAME.old_poker_hand] = false
            end
            self.hands[G.GAME.new_poker_hand] = true

        elseif self.name == 'The Mouth' then

            self.only_hand = G.GAME.new_poker_hand

        end

        mult = G.GAME.hands[G.GAME.new_poker_hand].mult
        hand_chips = G.GAME.hands[G.GAME.new_poker_hand].chips
        modded = false

        G.GAME.new_poker_hand = false

    end

    return mult, hand_chips, modded
end

--Function to transform a card
function transform_card(old_card, center, edition)
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
            old_card:flip()
            return true
        end,
    }))
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
            if center then
                old_card:set_ability(G.P_CENTERS[center])
            end
            if edition then
                old_card:set_edition(edition)
            end
            play_sound("card1")
            old_card:juice_up(0.3, 0.3)
            return true
        end,
    }))
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
            old_card:flip()
            return true
        end,
    }))
end

--Function to load files from folder
local mod_path = '' .. SMODS.current_mod.path
local function load_folder(folder)
    local files = NFS.getDirectoryItems(mod_path .. folder)
    for i, file in ipairs(files) do
        SMODS.load_file(folder .. '/' .. file)()
    end
end

--File loading
--Scadrial
load_folder('src/joker/scadrial')
load_folder('src/tarot/scadrial')
load_folder('src/enhancement/scadrial')
load_folder('src/blind/scadrial')

--Nalthis
load_folder('src/joker/nalthis')
load_folder('src/tarot/nalthis')
load_folder('src/enhancement/nalthis')
load_folder('src/blind/nalthis')
