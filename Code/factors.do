*** Reverse-coding for Mini-IPIP Big 5 Variables ***

/*
This DO file is run by dataset.do. To run it manually, you must run the two commented lines below after generating clean_data.dta.

proselectdir
use clean_data.dta, clear

The mini-IPIP scale includes the following variables:
	pers_life_of_party (E)
	pers_sympathize(A)
	pers_chores_right_away(C)
	pers_mood_swings(N)
	pers_vivid_imagination(O)
	pers_dont_talk_much(E)
	pers_disinterest(A)
	pers_forget_return(C)
	pers_relaxed(N)
	pers_not_abstract(O)
	pers_socialize_freely(E)
	pers_feel_others_emotions(A)
	pers_like_order(C)
	pers_upset_easily(N)
	pers_abstract_hard(O)
	pers_keep_background(E)
	pers_no_interest_others(A)
	pers_make_mess_of_things(C)
	pers_seldom_blue(N)
	pers_lack_imagination(O)
*/

//ssc install revrs
revrs pers_dont_talk_much pers_disinterest pers_forget_return pers_relaxed pers_not_abstract pers_abstract_hard ///
	pers_keep_background pers_no_interest_others pers_make_mess_of_things pers_seldom_blue pers_lack_imagination, replace

gen add_extraversion = pers_life_of_party + pers_dont_talk_much + pers_socialize_freely + pers_keep_background
gen add_agreeable = pers_sympathize + pers_disinterest + pers_feel_others_emotions + pers_no_interest_others
gen add_conscientious = pers_chores_right_away + pers_forget_return + pers_like_order + pers_make_mess_of_things
gen add_openness = pers_vivid_imagination + pers_not_abstract + pers_abstract_hard + pers_lack_imagination
gen add_neuroticism = pers_mood_swings + pers_relaxed + pers_upset_easily + pers_seldom_blue

factor pers_life_of_party pers_sympathize pers_chores_right_away pers_mood_swings pers_vivid_imagination pers_dont_talk_much ///
	pers_disinterest pers_forget_return pers_relaxed pers_not_abstract pers_socialize_freely pers_feel_others_emotions ///
	pers_like_order pers_upset_easily pers_abstract_hard pers_keep_background pers_no_interest_others pers_make_mess_of_things ///
	pers_seldom_blue pers_lack_imagination, factor(5)
rotate, varimax
predict fac_agreeable fac_extraversion fac_neurotic fac_conscientious fac_openness

