SMODS.Atlas {
	key = 'scadrial',
	path = 'scadrial.png',
	px = 71,
	py = 95
}
  
SMODS.Atlas{
    key = 'modicon',
    path = 'modicon.png',
    px = 34,
    py = 34
}

G.C.CSMR_PRESERVERS = HEX('000000')
SMODS.Rarity{
  key = 'preserver',
  badge_colour = G.C.CSMR_PRESERVERS,
  default_weight = 0.75,
  pools = {['Joker'] = true},
}

SMODS.optional_features = {
    cardareas = {
        unscored=true
    }
}

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
                    text = 'Art: Aakankshy',
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

--Function to check if Aces, 2s, 4,s and 8s appear in played hand/discard
function Card:is_preservation()
    local id = self:get_id()
    if id == 14 or id == 2 or id == 4 or id == 8 then
        return true
    end
end

local mod_path = '' .. SMODS.current_mod.path
local function load_folder(folder)
    local files = NFS.getDirectoryItems(mod_path .. folder)
    for i, file in ipairs(files) do
        SMODS.load_file(folder .. '/' .. file)()
    end
end

load_folder('src/joker')
