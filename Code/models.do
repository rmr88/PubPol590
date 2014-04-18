************
*  Models  *
************

proselectdir
use clean_data.dta, clear
run Code\imputations.do 0 //the 0 argument suppresses the model comparisons run in this DO file. To run those, run the entire DO file

*** Binary Logit Models ***

*DV = Insured
logit insured pers_risky
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

logit insured pers_risky gen_health injury_past12
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table1.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

mi estimate, post: logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat add_* hh_income_copy race_hispanic
outreg2 using "Results\table1.xml", append 2aster eform

*DV = Don't want insurance (uninsured sample only)
logit noins_dont_want pers_risky
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male noins_no_offer noins_expensive noins_denied
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* noins_no_offer noins_expensive noins_denied ///
	car_accident_past12 gen_health diag_migraines diag_adhd
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* hh_income2006 race_hispanic noins_no_offer ///
	noins_expensive noins_denied
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table2.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')


*** Multinomial Logit Models ***

*DV = voluntary or non-voluntary uninsured, vs. baseline of insured
mlogit insur_cat pers_risky
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", replace 2aster eform e(r2_p) addstat(AIC, `aic')

mlogit insur_cat pers_risky gen_health injury_past12
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

mlogit insur_cat pers_risky gen_health injury_past12 rent_own i.education male add_* i.empstat //all riskiness coeffs different from each other
local aic = (2*e(rank)) - (2*e(ll))
outreg2 using "Results\table3.xml", append 2aster eform e(r2_p) addstat(AIC, `aic')

qui tab education, gen(edu_)
qui tab empstat, gen(emp_)
qui mlogit insur_cat pers_risky gen_health injury_past12 rent_own edu_1-edu_12 male add_* emp_2-emp_11
prgen pers_risky, x(gen_health = 1) rest(mean) gen(ins3l)
prgen pers_risky, rest(mean) gen(insur3)
prgen pers_risky, x(gen_health = 5) rest(mean) gen(ins3h)
outsheet insur3x insur3p1 insur3p2 insur3p3 ins3lp1 ins3lp2 ins3lp3 ins3hp1 ins3hp2 ins3hp3 if insur3x != . ///
	using "Results\probabilities.csv", comma replace //use this in R code for generation of publication figures

mi estimate, post: mlogit insur_cat pers_risky gen_health injury_past12 rent_own i.education male add_* hh_income2006 race_hispanic i.empstat
outreg2 using "Results\table3.xml", append 2aster eform


*** Predicted Probability Graphs ***

line insur3p1 insur3p2 insur3p3 insur3x, title("Predicted Probabilities") ytitle("Probability") xtitle(`""I like to take risks""') ///
	graphregion(color(white)) xlabel(1 "Str. Disag." 2 "Disagree" 3 "Neither" 4 "Agree" 5 "Str. Agr.") xscale(titlegap(3)) ///
	yscale(titlegap(3)) leg(lab(1 "Insured")) leg(lab(2 "Voluntary Uninsured")) leg(lab(3 "Non-voluntary Uninsured"))
graph export "Results\mlogit_results.png", height(800) replace

