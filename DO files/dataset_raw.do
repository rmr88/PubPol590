*Raw Dataset

use "C:\Users\Robbie\Documents\add health parent study\wave 4 data\ICPSR_21600\DS0023\21600-0023-Data.dta", clear //W4 survey data
merge 1:1 AID using "C:\Users\Robbie\Documents\add health parent study\wave 1 data\ICPSR_21600\DS0001\21600-0001-Data.dta", nogen keep(3) //W1 survey data
merge 1:1 AID using "C:\Users\Robbie\Documents\add health parent study\wave 1 data\ICPSR_21600\DS0019\21600-0019-Data.dta", nogen keep(3) //W1 contextual data
merge 1:1 AID using "C:\Users\Robbie\Documents\add health parent study\wave 4 data\ICPSR_21600\DS0029\21600-0029-Data.dta", nogen keep(3) //W4 grand sample weights

quietly compress

save "C:\Users\Robbie\Documents\PubPol 590 local\raw_data.dta", replace
