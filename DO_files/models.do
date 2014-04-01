************
*  Models  *
************

proselectdir
use clean_data.dta, clear


*** Binary Logit Models ***

*DV = Insured
logit insured pers_risky
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

logit insured pers_risky gen_health injury_past12
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat add_* hh_income2006 race_hispanic //these last two have lots of missing values; use MI?
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
//this one is the best model by all measures (PCC, pseudo-R2, AIC)
outreg2 using "Results\table1.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')
qui tab education, gen(edu_)
qui tab empstat, gen(emp_)
gen sample = e(sample)
qui logit insured pers_risky gen_health injury_past12 rent_own edu_1-edu_10 edu_12 edu_13 male emp_2 emp_3 emp_5-emp_9 emp_11 add_* hh_income2006 race_hispanic //if sample == 1
drop sample
prgen pers_risky, rest(mean) gen(insur_)

*DV = Don't want insurance (uninsured sample only)
logit noins_dont_want pers_risky
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male noins_no_offer noins_expensive noins_denied
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* noins_no_offer noins_expensive noins_denied ///
	car_accident_past12 gen_health diag_migraines diag_adhd
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* hh_income2006 race_hispanic noins_no_offer ///
	noins_expensive noins_denied //these last two have lots of missing values; use MI?
estat class
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')


*** Multinomial Logit Models ***

*DV = voluntary or non-voluntary uninsured, vs. baseline of insured
mlogit means_cat pers_risky
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

mlogit means_cat pers_risky gen_health injury_past12
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

mlogit means_cat pers_risky gen_health injury_past12 rent_own i.education male add_* i.empstat
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')
qui mlogit means_cat pers_risky gen_health injury_past12 rent_own edu_1-edu_12 male add_* emp_2-emp_11
prgen pers_risky, rest(mean) gen(insur3_)

mlogit means_cat pers_risky gen_health injury_past12 rent_own i.education male add_* hh_income2006 race_hispanic i.empstat //these last two have lots of missing values; use MI?
estat ic
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')


*** Predicted Probability Graphs ***

line insur_p1 insur_x, title("Predicted Prob. of Being Insured") ytitle("Probability") xtitle(`""I like to take risks""') ///
	graphregion(color(white)) xlabel(1 "Str. Disag." 2 "Disagree" 3 "Neither" 4 "Agree" 5 "Str. Agr.", alternate) xscale(titlegap(5)) ///
	yscale(titlegap(5)) name(first, replace)
line insur3_p1 insur3_p2 insur3_p3 insur3_x, title("Predicted Probabilities") ytitle("Probability") xtitle(`""I like to take risks""') ///
	graphregion(color(white)) xlabel(1 "Str. Disag." 2 "Disagree" 3 "Neither" 4 "Agree" 5 "Str. Agr.") xscale(titlegap(3)) ///
	yscale(titlegap(3)) leg(lab(1 "Insured")) leg(lab(2 "Voluntary Uninsured")) leg(lab(3 "Non-voluntary Uninsured"))
graph export "Results\mlogit_results.png", height(800) replace
line insur3_p1 insur3_p2 insur3_p3 insur3_x, title("Predicted Probabilities") ytitle("Probability") xtitle(`""I like to take risks""') ///
	graphregion(color(white)) xlabel(1 "Str. Disag." 2 "Disagree" 3 "Neither" 4 "Agree" 5 "Str. Agr.") xscale(titlegap(5)) ///
	yscale(titlegap(5)) leg(lab(1 "Insured")) leg(lab(2 "Voluntary Uninsured")) leg(lab(3 "Non-voluntary Uninsured")) leg(rows(3)) ///
	name(second, replace)
graph combine first second
graph export "Results\predicted_probabilities.png", height(800) replace

