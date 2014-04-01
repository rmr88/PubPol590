*** Means Comparisons ***

proselectdir
use clean_data.dta, clear

*Health
tabstat gen_health ins_num_mos12 diag_* limit_* use_cane, by(means_cat) statistics(mean sd n)
bys means_cat: sum gen_health
sum gen_health

*Demographics
qui tab education, gen(educ)
qui tab hh_income2006, gen(inc)
qui tab hh_assets, gen(assets)
qui tab other_debts, gen(debts)
qui tab net_value, gen(net)
tabstat male age race_* educ1-net3 rent_own, by(means_cat) statistics(mean)

*Personality
tabstat add_* fac_*, by(means_cat) statistics(mean)

/*
Demographics
	income/ SES (which measures?)
	education
	gender
	race
	age (may not be very useful)
	childhood welfare
Personality types
	Big 5 factors
	personality profiles (based on lit review)
Medical profiles
	diagnoses
	general health
	limitations
	cane use
	Insurance over past 12 months

foreach x of varlist noins_no_offer noins_expensive noins_denied {
	di "`x'"
	tab noins_dont_want `x'
}
*/



