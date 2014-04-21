*** Statistics for Paper, by Page ***

proselectdir
use clean_data.dta, clear

cap log close
log using Descriptives\page_stats.smcl, replace

*Page 9: Correlations of Big 5 and risk propensity
pwcorr pers_risky add_*, sig

*Page 13: Adidtive health index descriptives
egen health_index = rowtotal(diag_* lastm_gum_disease-lastm_allergies last2w_flu-last2w_rash)
sum health_index
bys insur_cat: sum health_index
pwcorr health_index gen_health, sig

*Page 14: SES, Race, and Gender
tabstat rent_own, by(insur_cat)
tab insur_cat noins_expensive, row nofreq
tab insur_cat race_hispanic, row nofreq
tab insur_cat male, row nofreq

*Page 17: Power analysis
//ssc install powerlog
qui logit noins_dont_want pers_risky
sum pers_risky if insured == 0
local mean = r(mean)
local onedev = r(mean) + r(sd)
prvalue, x(pers_risky=`mean') rest(mean)
local atmean = r(p1)
prvalue, x(pers_risky=`onedev') rest(mean)
local atonedev = r(p1)
powerlog, p1(`atmean') p2(`atonedev') alpha(0.05)


log close
