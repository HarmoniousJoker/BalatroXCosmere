--Optional features
SMODS.optional_features = {
    cardareas = {
        unscored=true
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
  default_weight = 0.75,
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

--Function to alter Joker effects
local base_calculate_joker = Card.calculate_joker
function Card.calculate_joker(self,context)
    multiplier = G.GAME["LordRulerMultiplier"]
	local ret = base_calculate_joker(self, context)
	if G.GAME.round_resets.blind_choices.Boss == 'bl_csmr_lordruler' then
		if context.end_of_round then
            G.GAME["LordRulerMultiplier"] = 1
			if self.ability.name == 'Mail-In Rebate' then
				self.ability.extra = self.ability.base_extra
			end
			return ret
		end
		if self.ability.name == 'Blueprint' or self.ability.name == 'Brainstorm' and not context.end_of_round then
				return ret
		end

		if self.ability.name == 'Mail-In Rebate' then
				if not self.ability.base_extra then
						self.ability.base_extra = self.ability.extra
				end
				self.ability.extra = self.ability.base_extra * multiplier
				return ret
		end

		if not ret then return ret end

		-- Dollars
		if ret.dollars then ret.dollars = ret.dollars * multiplier end

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
end

--Function to load files easily
local mod_path = '' .. SMODS.current_mod.path
local function load_folder(folder)
    local files = NFS.getDirectoryItems(mod_path .. folder)
    for i, file in ipairs(files) do
        SMODS.load_file(folder .. '/' .. file)()
    end
end

--File loading
load_folder('src/joker/scadrial')
load_folder('src/tarot/scadrial')
load_folder('src/enhancement/scadrial')
load_folder('src/blind/scadrial')
