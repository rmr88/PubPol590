*** Descriptives ***

proselectdir
use raw_data.dta, clear
//run "DO_files\mat2txt.do"
//run "DO_files\tabmatrix.do"

gen no_ins = H4HS1 == 1
replace no_ins = . if H4HS1 > 10
//tab H4HS1 no_ins, missing //looks good.
fre no_ins

*DV: Insurance status, reasons for not having insurance
fre H4HS1 H4HS2* //H4HS2C is the one I care most about, but the others may also be independent variables
fre H4HS1 H4HS2* using "Descriptives\DV freqs.txt", replace
fre H4HS2* if H4HS1 == 1 using "descriptives\DV freqs.txt", append
hist H4HS1 if H4HS1 < 12, discrete freq
graph export "Descriptives\hist ins status.png", replace
foreach dv of varlist H4HS2* {
	hist `dv', discrete note("Full sample") freq
	graph export "Descriptives\hist `dv'.png", replace
	hist `dv' if `dv' < 2 & H4HS1 == 1, discrete note("Uninsured only") freq
	graph export "Descriptives\hist `dv' unins.png", replace
}

gen noins_dont_want = H4HS2C == 1
replace noins_dont_want = . if H4HS2C > 1
tab H4HS2C noins_dont_want, missing

gen noins_no_offer = H4HS2A == 1
replace noins_no_offer = . if H4HS2A > 1
tab H4HS2C noins_no_offer, missing

gen noins_expensive = H4HS2B == 1
replace noins_expensive = . if H4HS2B > 1
tab H4HS2B noins_expensive, missing

gen noins_denied = H4HS2D == 1
replace noins_denied = . if H4HS2D > 1
tab H4HS2D noins_denied, missing

fre noins_*
pwcorr noins_*, sig //no meaningful correlations for noins_dont_want, though all are negative and some are significant.
	//only meaningful correlation is between expensive and not offered.

*IVs
fre H4PE33-H4PE36 H4PE40 H1GH39-H1GH44 H1GH46
fre H4PE33-H4PE36 H4PE40 H1GH39-H1GH44 H1GH46 using "Descriptives\IV freqs.txt", replace
fre H4PE33-H4PE36 H4PE40 H1GH39-H1GH44 H1GH46 if H4HS1 == 1 using "DEscriptives\IV freqs.txt", append
foreach iv of varlist H4PE33-H4PE36 H4PE40 H1GH39-H1GH44 H1GH46 {
	hist `iv', discrete note("full sample") freq
	graph export "Descriptives\hist `iv'.png", replace
	hist `iv' if H4HS1 == 1, discrete note("Uninsured only") freq
	graph export "Descriptives\hist `iv' unins.png", replace
}

