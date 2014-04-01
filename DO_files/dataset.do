*** Creating the Dataset ***

proselectdir
//run dataset_raw.do
use raw_data.dta, clear
drop if PRISON4 == 1 //drop current (wave 4) prisoners
keep AID-PRISON4 H1GH39-H1GH46 H1RP* H1MO* H4HS* H4LM* H4PE* H4OD* H4GH* H4ID* S4-S7 H4ED1-H4ED3A H4EC* GSWGT4 GSWGT4_2 GSWGT134
//what about parents' education? can only find W1 question on that...

*Generate Age:
gen int_ym = (IYEAR4 - 1960)*12 + IMONTH4 - 1
gen birth_ym = (H4OD1Y - 1960)*12 + H4OD1M - 1
format int_ym birth_ym %tm
gen int age = (int_ym - birth_ym) / 12

*Rename Vars:
ren BIO_SEX4 gender
ren H4GH1 gen_health
ren H4GH2 missed_work_health
//Insurance, Access
ren H4HS1 insurance_status
ren H4HS2A noins_no_offer
ren H4HS2B noins_expensive
ren H4HS2C noins_dont_want
ren H4HS2D noins_denied
ren H4HS3 ins_num_mos12
ren H4HS4 needed_care
ren H4HS5 got_worse
ren H4HS6 usu_health_location
ren H4HS7 last_checkup
ren H4HS8 last12_dental
ren H4HS9 last12_psych
//Illnesses, Diseases, etc
ren H4ID1 limit_moderate
ren H4ID2 limit_stairs
ren H4ID3 limit_chronic
ren H4ID4 use_cane
ren H4ID5A diag_cancer
ren H4ID5B diag_hi_chol
ren H4ID5C diag_hi_bpressure
ren H4ID5D diag_diabetes
ren H4ID5E diag_hart_disease
ren H4ID5F diag_asthma
ren H4ID5G diag_migraines
ren H4ID5H diag_depression
ren H4ID5I diag_ptsd
ren H4ID5J diag_anxiety
ren H4ID5K diag_epilepsy
ren H4ID5L diag_adhd
ren H4ID5N diag_hepc
ren H4ID7 injury_past12
ren H4ID8 car_accident_past12
ren H4ID9A lastm_gum_disease
ren H4ID9B lastm_infection
ren H4ID9C lastm_injury
ren H4ID9D lastm_acute_illness
ren H4ID9E lastm_surgery
ren H4ID9F lastm_allergies
ren H4ID9G lastm_none
ren H4ID10A last2w_flu
ren H4ID10B last2w_fever
ren H4ID10C last2w_night_sweats
ren H4ID10D last2w_diarrhea
ren H4ID10E last2w_bloody_stool
ren H4ID10F last2w_polyuria
ren H4ID10G last2w_rash
ren H4ID10H last2w_none
ren H4ID11 last24h_aspirin
ren H4ID12 last24h_anti_inflam
ren H4ID13 blindness
ren H4ID14 corrective_lenses
ren H4ID15 eyesight_corrected
ren H4ID16 hearing_aid
ren H4ID17 hearing_unaided
ren H4ID18 stutter
ren H4ID19 stutter_severity
ren H4ID20 tinnitus
ren H4ID21 tinnitus_dur
ren H4ID22 tinnitus_freq
ren H4ID23 voice_problems
ren H4ID24 voice_prob_freq
ren H4ID25 voice_project
ren H4ID26 voice_prob_affect
//Education
ren H4ED1 hs_grad
ren H4ED2 education
ren H4ED3A recent_degree
//Labor
ren H4LM11 employed
ren H4LM14 unemp_status
//Economics
ren H4EC1 hh_income2006
ren H4EC2 p_income2006
ren H4EC3 p_income2006_guess
ren H4EC4 rent_own
ren H4EC5 mortgage_owed
ren H4EC6 mort_parents_help
ren H4EC7 hh_assets
ren H4EC8 other_debts
ren H4EC9 net_value
ren H4EC10 nopay_phone
ren H4EC11 nopay_mortgage
ren H4EC12 nopay_evicted
ren H4EC13 nopay_utility
ren H4EC14 nopay_util_off
ren H4EC15 worried_food
ren H4EC16 hh_welfare_before18
ren H4EC17 hh_welfare_before18_how_much
ren H4EC18 hh_welfare
ren H4EC19 class_ladder
//Personality Battery
ren H4PE1 pers_life_of_party
ren H4PE2 pers_sympathize
ren H4PE3 pers_chores_right_away
ren H4PE4 pers_mood_swings
ren H4PE5 pers_vivid_imagination
ren H4PE6 pers_worry
ren H4PE7 pers_optimistic
ren H4PE8 pers_angry_easily
ren H4PE9 pers_dont_talk_much
ren H4PE10 pers_disinterest
ren H4PE11 pers_forget_return
ren H4PE12 pers_relaxed
ren H4PE13 pers_not_abstract
ren H4PE14 pers_not_bothered
ren H4PE15 pers_expect_not_my_way
ren H4PE16 pers_rarely_irritated
ren H4PE17 pers_socialize_freely
ren H4PE18 pers_feel_others_emotions
ren H4PE19 pers_like_order
ren H4PE20 pers_upset_easily
ren H4PE21 pers_abstract_hard
ren H4PE22 pers_stressed_easily
ren H4PE23 pers_expect_good
ren H4PE24 pers_lose_temper
ren H4PE25 pers_keep_background
ren H4PE26 pers_no_interest_others
ren H4PE27 pers_make_mess_of_things
ren H4PE28 pers_seldom_blue
ren H4PE29 pers_lack_imagination
ren H4PE30 pers_no_worry_past
ren H4PE31 pers_rarely_expect_good
ren H4PE32 pers_keep_cool
ren H4PE33 pers_avoid_problems
ren H4PE34 pers_rely_on_gut
ren H4PE35 pers_risky
ren H4PE36 pers_no_thought_future
ren H4PE37 pers_cant_change
ren H4PE38 pers_others_set_limits
ren H4PE39 pers_interference
ren H4PE40 pers_low_control
ren H4PE41 pers_problems_unsolvable
//Wave 1 Behaviors
ren H1GH39 helmet_bike
ren H1GH40 motorcycle_ride_freq
ren H1GH41 motorcycle_helmet_freq
ren H1GH42 seatbelt_freq
ren H1GH43 alchohol_freq
ren H1GH44 chance_of_aids
ren H1GH45 friends_w_stds
ren H1GH46 chance_of_stds
//Wave 1 Risk Attitudes
ren H1RP1 pregnant_now_bad
ren H1RP2 pregnant_not_bad
ren H1RP3 suffer_from_aids
ren H1RP4 protection_hassle
ren H1RP5 risk_preg_noprotect
ren H1RP6 risk_aids_noprotect
//Wave 1 Riskiness
ren H1MO1 sex_respect
ren H1MO2 sex_partner_respect
ren H1MO3 sex_guilty
ren H1MO4 sex_upset_mom
ren H1MO5 sex_pleasure
ren H1MO6 sex_relaxing
ren H1MO7 sex_more_attention
ren H1MO8 sex_less_lonely
ren H1MO9 preg_embarass_fam
ren H1MO10 preg_embarass_self
ren H1MO11 preg_quit_school
ren H1MO12 preg_marry
ren H1MO13 preg_grow_up_fast
ren H1MO14 preg_hard_decision
//Race
ren S4 race_hispanic
ren S5 hisp_background
ren S6A race_white
ren S6B race_black
ren S6C race_asian
ren S6D race_native
ren S6E race_other
ren S7 asian_background
//Weights
ren GSWGT4 wt_longit
ren GSWGT4_2 wt_cross
ren GSWGT134 wt_longit_untrimmed

//Recodes and Labels
//Gender dummy
recode gender (2=0), gen(male)
label define MALE 0 "Female" 1 "Male"
label values male MALE
//Insured dummy
recode insurance_status (1=0) (2/11 = 1), gen(insured)
//Category variable for means comparisons
recode insured (0 = 3) (1 = 1), gen(means_cat)
replace means_cat = 2 if noins_dont_want == 1
label define CATS 1 "Insured" 2 "Voluntary Uninsured" 3 "Non-voluntary Uninsured"
label values means_cat CATS
//Employment Categories
gen empstat = unemp_stat + 1
replace empstat = 1 if employed == 1
label define EMPSTAT 1 "Employed" 2 "Only temporarily laid off" 3 "Maternity/ paternity leave" 4 "Sick leave/ temporarily disabled" ///
	5 "Permanently disabled" 6 "Unemployed, looking for work" 7 "Unemployed, not looking" 8 "Student" 9 "Keeping house" 10 "Retired" ///
	11 "Other"
label values empstat EMPSTAT
//Reverse codes for health and risk propensity
revrs pers_risky gen_health
ren pers_risky pers_risky_original
ren gen_health gen_health_original
ren revpers_risky pers_risky
ren revgen_health gen_health

//Sort Vars:
order AID wt_* insurance_status noins_no_offer noins_expensive noins_dont_want noins_denied ins_num_mos12 pers_*, first
order IMONTH4 IDAY4 IYEAR4 MACNO4 INTID4 VERSION4 BREAK_Q PRYEAR4 PRETEST4 PRISON4 H4*, last
order age race_* hs_grad education recent_degree hh_income2006 p_income2006 p_income2006_guess rent_own hh_assets other_debts ///
	net_value, after(gender)

//Big 5 Factors:
run DO_files\factors.do

save clean_data.dta, replace

