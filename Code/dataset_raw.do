*** Raw Dataset ***

proselectdir

use "ICPSR_downloads\DS0023\21600-0023-Data.dta", clear //W4 survey data
merge 1:1 AID using "ICPSR_downloads\DS0001\21600-0001-Data.dta", nogen keep(3) //W1 survey data
merge 1:1 AID using "ICPSR_downloads\DS0019\21600-0019-Data.dta", nogen keep(3) //W1 contextual data
merge 1:1 AID using "ICPSR_downloads\DS0029\21600-0029-Data.dta", nogen keep(3) //W4 grand sample weights

quietly compress
run "Code\missing_data.do"
//handles missing data for the variables to be used in clean dataset; see this DO file for missing value code usage

save raw_data.dta, replace
