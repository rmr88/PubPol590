*** Missing Data Check ***

if ("`1'" == "") {
	local 1 = 1
}
if (`1' != 0) {
	proselectdir
	use clean_data.dta, clear
}
/* To download the commands used below to check missingness, run the following three lines:
ssc install mdesc
ssc install mvpatterns
ssc install misschk
*/


*** Missingness in Dependent Variables ***

mdesc insured insurance_status insur_cat
mvpatterns insured insurance_status insur_cat
misschk insured insurance_status insur_cat
mdesc noins_* if insured == 0
mvpatterns noins_* if insured == 0
misschk noins_* if insured == 0

*** Missingness in Independent Variables ***

mdesc pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic
mvpatterns pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic
misschk pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic

misschk pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic noins_* if insured == 0


*** Imputations ***

*Setup
recode hh_income2006 (.d=.) (.r=.), gen(hh_income_copy)

mi set wide
mi misstable sum insured pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic
mi misstable nested insured pers_risky gen_health injury_past12 rent_own education male empstat add_* hh_income2006 race_hispanic
mi register imputed hh_income_copy
mi describe

*Income
//pwcorr hh_income2006 race_white-race_asian H4LM1-H4LM7 H4LM10 H4LM12 H4LM15Y-H4LM27 H4LM30 limit_moderate education age rent_own, sig
mi impute ologit hh_income_copy = race_white-race_asian i.H4LM12 H4LM16Y i.H4LM17 i.H4LM22 i.H4LM24 i.H4LM27 ///
	limit_moderate i.education age rent_own, add(10) replace force rseed(23116993) augment


*** Model Comparisons ***

if ("`1'" == "") {
	local 1 = 1
}
if (`1' != 0) {
	preserve
	recode hh_income2006 (.d=13) (.r=14)

	logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat add_* hh_income_copy race_hispanic
	outreg2 using "Results\imputations\impcomp1.xml", replace 2aster eform ctitle("DV=Uninsured, Missing")
	logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat add_* i.hh_income2006 race_hispanic
	outreg2 using "Results\imputations\impcomp1.xml", append 2aster eform ctitle("DV=Uninsured, Dummies")
	mi estimate, post: logit insured pers_risky gen_health injury_past12 rent_own i.education male i.empstat add_* hh_income_copy race_hispanic
	outreg2 using "Results\imputations\impcomp1.xml", append 2aster eform ctitle("DV=Uninsured, Imputed")

	logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* hh_income_copy race_hispanic noins_no_offer ///
		noins_expensive noins_denied
	outreg2 using "Results\imputations\impcomp2.xml", replace 2aster eform ctitle("DV=Voluntary, Missing")
	logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* i.hh_income2006 race_hispanic noins_no_offer ///
		noins_expensive noins_denied
	outreg2 using "Results\imputations\impcomp2.xml", append 2aster eform ctitle("DV=Voluntary, Dummies")
	mi estimate, post: logit noins_dont_want pers_risky gen_health injury_past12 i.empstat rent_own i.education male add_* hh_income_copy ///
		race_hispanic noins_no_offer noins_expensive noins_denied
	outreg2 using "Results\imputations\impcomp2.xml", append 2aster eform ctitle("DV=Voluntary, Imputed")

	mlogit insur_cat pers_risky gen_health injury_past12 rent_own i.education male add_* hh_income_copy race_hispanic i.empstat
	outreg2 using "Results\imputations\impcomp3.xml", replace 2aster eform ctitle("MLogit, Missing")
	mlogit insur_cat pers_risky gen_health injury_past12 rent_own i.education male add_* hh_income2006 race_hispanic i.empstat
	outreg2 using "Results\imputations\impcomp3.xml", append 2aster eform ctitle("MLogit, Dummies")
	mi estimate, post: mlogit insur_cat pers_risky gen_health injury_past12 rent_own i.education male add_* hh_income_copy race_hispanic i.empstat
	outreg2 using "Results\imputations\impcomp3.xml", append 2aster eform ctitle("MLogit, Imputed")

	restore
}

