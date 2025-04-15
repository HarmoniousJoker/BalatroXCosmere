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
            }
        },
        Edition={},
        Enhanced={
            m_csmr_pewter = {
                name = 'Pewter',
                text = {
                    'Always scores and {C:attention}Quadruples{}',
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
            }
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
                    'Retriggers all {C:attention}Lucky Cards{}'
		        }
            },
            j_csmr_dockson = {
                name = 'Dockson',
                text = {
                    'Earn {C:gold}$#1#{} per scored {C:attention}Preservation Card{},',
                    'destroyed after #2# rounds',
                    '{C:inactive}({C:attention}Preservation Cards{C:inactive}: A, 2, 4, and 8)'
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
                    'Played cards that are not scored have',
                    '{C:green}4 in 16{} chance of becoming',
                    '{C:attention}Steel Cards{}'
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
                    'each give {X:mult,C:white} X#1# {} Mult'
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
            }
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