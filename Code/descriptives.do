******************
*  Descriptives  *
******************

proselectdir
use clean_data.dta, clear
run Code\mat2txt.do
run Code\tabmatrix.do


*** Dependent Variables ***

*Insurance Status, Detailed
label define H4HS1MOD 1 "Uninsured" 2 "Employer-sponsored" 3 "Union" 4 "School" 5 "Spouse's plan" 6 "Parents' plan" ///
	7 "Active duty military" 8 "Private insurance" 9 "Medicaid" 10 "Indian Health Service" 11 "Don't know"
label values insurance_status H4HS1MOD
tabmatrix insurance_status, matrix(stats)
mat2txt, matrix(stats) saving(Descriptives\tab_dv_a.csv) rows(12) cols(2) replace
label values insurance_status H4HS1

*Reasons for not having insurance
foreach x in dont_want denied expensive no_offer {
	qui sum noins_`x'
	local sum`x' = r(sum)
	local n`x' = r(N)
	local perc`x' = r(sum) / r(N)
}
matrix define stats = (`sumdont_want', `percdont_want', `ndont_want' \ ///
	`sumexpensive', `percexpensive', `nexpensive' \ ///
	`sumdenied', `percdenied', `ndenied' \ ///
	`sumno_offer', `percno_offer', `nno_offer')
matrix colnames stats = Frequency Percent N
matrix rownames stats = "Don't Want/ Need" Expensive Denied "No Offer"
mat2txt, matrix(stats) saving(Descriptives\tab_dv_b.csv) rows(4) cols(3) replace

*Insurance status, 3 category
tabmatrix insur_cat, matrix(stats)
mat2txt, matrix(stats) saving(Descriptives\tab_dv_c.csv) rows(4) cols(2) replace


*** Main IV Descriptives ***

*Risk Propensity
tabstat pers_risky, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured" Isd In "Voluntarily Uninsured" Vsd Vn "Non-voluntarily Uninsured" Usd Un "Overall" Osd On
mat2txt, matrix(stats) saving(Descriptives\tab_risky.csv) rows(1) cols(12) replace

*General Health
tabstat gen_health, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured" Isd In "Voluntarily Uninsured" Vsd Vn "Non-voluntarily Uninsured" Usd Un "Overall" Osd On
mat2txt, matrix(stats) saving(Descriptives\tab_health.csv) rows(1) cols(12) replace

*Injury in Past 12 Months
tabstat injury_past12, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured" Isd In "Voluntarily Uninsured" Vsd Vn "Non-voluntarily Uninsured" Usd Un "Overall" Osd On
mat2txt, matrix(stats) saving(Descriptives\tab_injury.csv) rows(1) cols(12) replace

*Demographics Descriptives
qui tab hh_income2006, gen(inc)
tabstat male race_* rent_own inc1-inc12, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured" Isd In "Voluntarily Uninsured" Vsd Vn "Non-voluntarily Uninsured" Usd Un "Overall" Osd On
mat2txt, matrix(stats) saving(Descriptives\tab_demog.csv) rows(20) cols(12) replace


*** Supplementary Statistics ***

*Additive Objective Health Index
egen health_index = rowtotal(diag_* lastm_gum_disease-lastm_allergies last2w_flu-last2w_rash)
tabstat health_index, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured mean" sd N "Voluntarily uninsured mean" sd N "Non-voluntarily uninsured mean" sd N "Overall mean" sd N
mat2txt, matrix(stats) saving(Descriptives\supplemental\additive_index.csv) rows(19) cols(12) replace

*Health
tabstat ins_num_mos12 diag_* limit_* use_cane, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured mean" sd N "Voluntarily uninsured mean" sd N "Non-voluntarily uninsured mean" sd N "Overall mean" sd N
mat2txt, matrix(stats) saving(Descriptives\supplemental\supplementary_stats.csv) rows(18) cols(12) replace

*Demographics
qui tab education, gen(educ)
qui tab hh_assets, gen(assets)
qui tab other_debts, gen(debts)
qui tab net_value, gen(net)
tabstat male age race_* educ1-net3 rent_own, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured mean" sd N "Voluntarily uninsured mean" sd N "Non-voluntarily uninsured mean" sd N "Overall mean" sd N
mat2txt, matrix(stats) saving(Descriptives\supplemental\supplementary_stats.csv) rows(54) cols(12) append

*Personality
tabstat add_* fac_*, by(insur_cat) statistics(mean sd n) save
matrix define stats = r(Stat1)' , r(Stat2)' , r(Stat3)' , r(StatTotal)'
matrix colnames stats = "Insured mean" sd N "Voluntarily uninsured mean" sd N "Non-voluntarily uninsured mean" sd N "Overall mean" sd N
mat2txt, matrix(stats) saving(Descriptives\supplemental\supplementary_stats.csv) rows(10) cols(12) append
