return {
    descriptions = {
        Back={},
        Blind={
            bl_csmr_lordruler = {
                name = 'Lord Ruler',
                text = {
                    'Weakens Scoring Jokers by 25%',
                    'for each hand played',
                }
            },
            bl_csmr_denth = {
                name = 'Denth',
                text = {
                    'Before scoring, randomly make a',
                    'Joker give the opposite effect',
                    'if it is Scoring'
                }
            },
        },
        Edition={},
        Enhanced={
            m_csmr_pewter = {
                name = 'Pewter',
                text = {
                    'Always scores and {C:attention}Doubles{}',
                    'chips, starting with base chips,',
                    'destroyed after {C:attention}4{} uses',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)',
                    '{C:inactive}(Uses left: {C:attention}#3#{C:inactive})'
                }
            },
            m_csmr_atium = {
                name = 'Atium',
                text = {
                    'Gives {C:attention}1 / #1#{} of sum of all',
                    'base chips of remaining cards in deck',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)'
                }
            },
            m_csmr_heightened = {
                name = 'Heightened',
                text = {
                    'Card cannot be {C:attention}Debuffed',
                }
            },
        },
        Joker={
            j_csmr_kelsier = {
                name = 'Kelsier',
                text = {
                    'This Joker gains {C:chips}+#1#{} Chips,',
                    'if {C:attention}3{} or more {C:attention}Face Cards{}',
                    'are discarded at the same time',
                    '{C:inactive}(Currently {C:blue}+#2#{C:inactive} Chips)'
                }
            },
            j_csmr_vin = {
                name = 'Vin',
		        text = {
                    'Retriggers all {C:attention}Lucky Cards{},',
                    'transforms into {C:attention}Lady Mistborn{}',
                    'after {C:attention}#1#{} rounds',
                    '{C:inactive}(Rounds left: {C:attention}#2#{C:inactive})',
		        }
            },
            j_csmr_ladymistborn = {
                name = 'Lady Mistborn',
                text = {
                    'Preservation cards, before scoring,',
                    'have a {C:green}4 in 16{} chance of turning',
                    'into a {C:attention}Glass Card{}'
                }
		    },
            j_csmr_dockson = {
                name = 'Dockson',
                text = {
                    'Earn {C:gold}$#1#{} per scored {C:attention}Preservation Card{},',
                    'destroyed after {C:attention}#2#{} rounds',
                    '{C:inactive}(Rounds left: {C:attention}#3#{C:inactive})',
                    '{C:inactive}({C:attention}Preservation Cards{C:inactive}: A, 2, 4, and 8)',
                }
            },
            j_csmr_lestibournes = {
                name = 'Lestibournes',
                text = {
                    'Upgrade Poker Hand',
                    'every #1#th time it is played'
                }
            },
            j_csmr_elend = {
                name = 'Elend',
                text = {
                    '{C:green}4 in 16{} chance of gaining {C:mult}+#2#{} Mult',
                    'when a {C:attention}Face Card{} is scored',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
                }
            },
            j_csmr_marsh = {
                name = 'Marsh',
                text = {
                    'One unscored card has a',
                    '{C:green}4 in 16{} chance of becoming',
                    'a {C:attention}Steel Card{}'
                }
            },
            j_csmr_tindwyl = {
                name = 'Tindwyl',
                text = {
                    'Played {C:attention}Preservation Cards{}, when scored,',
                    'have a {C:green}2 in 16{} chance of becoming a',
                    '{C:attention}King{} or {C:attention}Queen{}',
                    '{C:inactive}(This will not change the poker hand)',
                    '{C:inactive}({C:attention}Preservation Cards{C:inactive}: A, 2, 4, and 8)'
                }
            },
            j_csmr_sazed = {
                name = 'Sazed',
                text = {
                    '{C:green}Preserver{} Jokers',
                    'each give {X:mult,C:white}X#1#{} Mult'
                }
            },
            j_csmr_hammond = {
                name = 'Hammond',
                text = {
                    'Gives {C:mult}+#1#{} Mult for',
                    'each {C:attention}Pewter Card',
                    'in your {C:attention}Full Deck',
                    '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)'
                },
            },
            j_csmr_cladent = {
                name = 'Cladent',
                text = {
                    '{C:green}#1# in 16{} chance of disabling',
                    '{C:attention}Boss Blind{}.',
                    'Chances are doubled each time',
                    '{C:attention}Boss Blind{} is not disabled',
                    '{C:inactive}(Resets after disabling {C:attention}Boss Blind{C:inactive})',
                },
            },
            j_csmr_edgard = {
                name = 'Edgard',
                text = {
                    'Sell this Joker to immediately gain 75%',
                    'of required chips for this Blind'
                },
            },
            j_csmr_tensoon = {
                name = 'TenSoon',
                text = {
                    'This Joker gains {C:mult}+#1#{} Mult when',
                    '#3# or more {C:attention}Enhanced Cards{} are scored',
                    '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)'
                }
            },
            j_csmr_godking = {
                name = 'God King',
                text = {
                    'Turns any played {C:attention}Straight{}, {C:attention}Full House{},',
                    'or {C:attention}Five of a Kind{} into its',
                    '{C:attention}Flush Variant{} and converts all',
                    'scored cards into {C:attention}Wild Cards'
                }
            },
            j_csmr_lightsong = {
                name = 'Lightsong',
                text = {
                    'Gives Mult equal to',
                    'half of the sum of the total ranks',
                    'of all {C:attention}Destroyed Cards',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
                }
            },
            j_csmr_nightblood = {
                name = 'Nightblood',
                text = {
                    'Before scoring, debuff a played card randomly',
                    'and gain {X:mult,C:white}X#1#{} Mult',
                    'debuffed cards reset at end of Ante',
                    'or when Joker is sold',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
                }
            },
            j_csmr_vasher = {
                name = 'Vasher',
                text = {
                    'Makes the first played card {C:attention}Polychrome{} and {C:attention}Heightened{},',
                    '{C:green}1 in 2{} chance of being destroyed after scoring,',
                    'gains {C:mult}+#1#{} Mult per destroyed card',
                    '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)'
                }
            },
            j_csmr_siri = {
                name = 'Siri',
                text = {
                    'Each played {C:attention}Heightened Card{}, before scoring,',
                    'has a {C:green}1 in 5{} chance of making',
                    'cards around it {C:attention}Heightened'
                }
            },
        },
        Other={},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={
            c_csmr_spike={
                name = 'Spike',
                text = {
                    'Select {C:attention}2{} cards,',
                    'apply the modifications of the {C:attention}Left Card{}',
                    'on the {C:attention}Right Card{}, destroy the {C:attention}Left Card{}',
                    '{C:inactive}(Drag to rearrange)',
                },
            },
            c_csmr_thug = {
                name = 'Thug',
                text = {
                    'Enhances {C:attention}#1#{}',
                    'selected cards to',
                    '{C:attention}Pewter Cards',
                },
            },
            c_csmr_seer = {
                name = 'Seer',
                text = {
                    'Enhances {C:attention}#1#{}',
                    'selected cards to',
                    '{C:attention}Atium Cards',
                },
            },
            c_csmr_kandra = {
                name = 'Kandra',
                text = {
                    'Create {C:attention}#1#{} copies of the last destroyed card',
                    'with a random enhancement and a random seal',
                },
            },
            c_csmr_breath = {
                name = 'Breath',
                text = {
                    'Enhances {C:attention}#1#{}',
                    'selected cards to',
                    '{C:attention}Heightened Cards',
                },
            },
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_csmr_preserver = {'Preserver'},
            k_csmr_inactive = {'Inactive'},
            k_csmr_copy = {'Copied!'}
        },
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}