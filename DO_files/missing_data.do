*** Missing Data ***

/* Missing Value Codes:
. = legitimate skip/ no response (usually coded as 7). This includes those who were in Wave 1 but not Wave 4.
.r = refused (usually 6)
.d = don't know (usually 8)
.n = not applicable (usually 9) or not asked on pretest (usually 5)

No missing data for BIO_SEX4 or H4GH1

This code was modified from the ICPSR supplemental DO files for 21600-0001 and 21600-0023
*/

*Wave 4 (code from ICPSR supplemental DO file)
replace H4OD3 = . if (H4OD3 == 97)
replace H4OD5 = . if (H4OD5 == 7)
replace H4OD6Y = . if (H4OD6Y == 9997)
replace H4OD6Y = .d if (H4OD6Y == 9998)
replace H4OD7 = . if (H4OD7 == 7)
replace H4OD7 = .d if (H4OD7 == 8)

replace H4GH2 = . if (H4GH2 == 7)
replace H4GH2 = .d if (H4GH2 == 8)
replace H4GH3M = .r if (H4GH3M == 96)
replace H4GH3M = . if (H4GH3M == 97)
replace H4GH3M = .d if (H4GH3M == 98)
replace H4GH3D = .r if (H4GH3D == 96)
replace H4GH3D = . if (H4GH3D == 97)
replace H4GH3Y = . if (H4GH3Y == 9997)
replace H4GH3Y = .d if (H4GH3Y == 9998)
replace H4GH4A = . if (H4GH4A == 997)
replace H4GH4A = .d if (H4GH4A == 998)
replace H4GH4B = .r if (H4GH4B == 6)
replace H4GH4B = . if (H4GH4B == 7)
replace H4GH4B = .d if (H4GH4B == 8)
replace H4GH5F = .d if (H4GH5F == 98)
replace H4GH5I = .d if (H4GH5I == 98)
replace H4GH6 = .r if (H4GH6 == 996)
replace H4GH6 = .d if (H4GH6 == 998)
replace H4GH7 = .r if (H4GH7 == 6)
replace H4GH7 = .d if (H4GH7 == 8)
replace H4GH8 = .r if (H4GH8 == 996)
replace H4GH8 = .d if (H4GH8 == 998)
replace H4GH9 = .d if (H4GH9 == 998)
replace H4GH10 = .r if (H4GH10 == 996)
replace H4GH10 = .d if (H4GH10 == 998)
replace H4GH11H = .r if (H4GH11H == 96)
replace H4GH11H = .d if (H4GH11H == 98)
replace H4GH11M = .r if (H4GH11M == 96)
replace H4GH11M = .d if (H4GH11M == 98)
replace H4GH11T = .r if (H4GH11T == 6)
replace H4GH11T = .d if (H4GH11T == 8)
replace H4GH12 = .d if (H4GH12 == 8)
replace H4GH13H = .r if (H4GH13H == 96)
replace H4GH13H = . if (H4GH13H == 97)
replace H4GH13H = .d if (H4GH13H == 98)
replace H4GH13M = .r if (H4GH13M == 96)
replace H4GH13M = . if (H4GH13M == 97)
replace H4GH13M = .d if (H4GH13M == 98)
replace H4GH13T = .r if (H4GH13T == 6)
replace H4GH13T = . if (H4GH13T == 7)
replace H4GH13T = .d if (H4GH13T == 8)

replace H4HS1 = .d if (H4HS1 == 98)
replace H4HS2A = . if (H4HS2A == 7)
replace H4HS2B = . if (H4HS2B == 7)
replace H4HS2B = .d if (H4HS2B == 8)
replace H4HS2C = . if (H4HS2C == 7)
replace H4HS2C = .d if (H4HS2C == 8)
replace H4HS2D = .n if (H4HS2D == 5)
replace H4HS2D = . if (H4HS2D == 7)
replace H4HS2D = .d if (H4HS2D == 8)
replace H4HS3 = .d if (H4HS3 == 98)
replace H4HS4 = .d if (H4HS4 == 8)
replace H4HS5 = . if (H4HS5 == 7)
replace H4HS5 = .d if (H4HS5 == 8)
replace H4HS6 = .d if (H4HS6 == 98)
replace H4HS7 = .d if (H4HS7 == 98)
replace H4HS9 = .d if (H4HS9 == 8)

replace H4ID1 = .d if (H4ID1 == 8)
replace H4ID2 = . if (H4ID2 == 7)
replace H4ID2 = .d if (H4ID2 == 8)
replace H4ID3 = . if (H4ID3 == 7)
replace H4ID3 = .d if (H4ID3 == 8)
replace H4ID4 = .n if (H4ID4 == 5)
replace H4ID5B = .r if (H4ID5B == 6)
replace H4ID5B = .d if (H4ID5B == 8)
replace H4ID5C = .r if (H4ID5C == 6)
replace H4ID5C = .d if (H4ID5C == 8)
replace H4ID5D = .r if (H4ID5D == 6)
replace H4ID5E = .r if (H4ID5E == 6)
replace H4ID5F = .r if (H4ID5F == 6)
replace H4ID5G = .r if (H4ID5G == 6)
replace H4ID5H = .r if (H4ID5H == 6)
replace H4ID5I = .r if (H4ID5I == 6)
replace H4ID5J = .r if (H4ID5J == 6)
replace H4ID5K = .r if (H4ID5K == 6)
replace H4ID5L = .r if (H4ID5L == 6)
replace H4ID5N = .n if (H4ID5N == 5)
replace H4ID5N = .r if (H4ID5N == 6)
replace H4ID11 = .d if (H4ID11 == 8)
replace H4ID12 = .d if (H4ID12 == 8)
replace H4ID14 = .r if (H4ID14 == 6)
replace H4ID14 = . if (H4ID14 == 7)
replace H4ID15 = .r if (H4ID15 == 6)
replace H4ID15 = . if (H4ID15 == 7)
replace H4ID15 = .d if (H4ID15 == 8)
replace H4ID19 = . if (H4ID19 == 7)
replace H4ID20 = .d if (H4ID20 == 8)
replace H4ID21 = . if (H4ID21 == 97)
replace H4ID21 = .d if (H4ID21 == 98)
replace H4ID22 = . if (H4ID22 == 7)
replace H4ID23 = .d if (H4ID23 == 8)
replace H4ID24 = . if (H4ID24 == 97)
replace H4ID24 = .d if (H4ID24 == 98)
replace H4ID25 = . if (H4ID25 == 97)
replace H4ID25 = .d if (H4ID25 == 98)
replace H4ID26 = . if (H4ID26 == 97)
replace H4ID26 = .d if (H4ID26 == 98)

replace H4ED1 = .d if (H4ED1 == 8)
replace H4ED2 = .d if (H4ED2 == 98)
replace H4ED3A = . if (H4ED3A == 97)
replace H4ED3A = .d if (H4ED3A == 98)

replace H4EC1 = .r if (H4EC1 == 96)
replace H4EC1 = .d if (H4EC1 == 98)
replace H4EC2 = .r if (H4EC2 == 9999996)
replace H4EC2 = .d if (H4EC2 == 9999998)
replace H4EC3 = .r if (H4EC3 == 96)
replace H4EC3 = . if (H4EC3 == 97)
replace H4EC3 = .d if (H4EC3 == 98)
replace H4EC4 = .r if (H4EC4 == 6)
replace H4EC4 = .d if (H4EC4 == 8)
replace H4EC5 = .r if (H4EC5 == 9999996)
replace H4EC5 = . if H4EC5 == 9999997
replace H4EC5 = .d if (H4EC5 == 9999998)
replace H4EC6 = .r if (H4EC6 == 6)
replace H4EC6 = .d if (H4EC6 == 8)
replace H4EC7 = .r if (H4EC7 == 96)
replace H4EC7 = .d if (H4EC7 == 98)
replace H4EC8 = .r if (H4EC8 == 96)
replace H4EC8 = .d if (H4EC8 == 98)
replace H4EC9 = .r if (H4EC9 == 6)
replace H4EC9 = .d if (H4EC9 == 8)
replace H4EC10 = .r if (H4EC10 == 6)
replace H4EC10 = .d if (H4EC10 == 8)
replace H4EC11 = .r if (H4EC11 == 6)
replace H4EC11 = .d if (H4EC11 == 8)
replace H4EC12 = .r if (H4EC12 == 6)
replace H4EC12 = .d if (H4EC12 == 8)
replace H4EC13 = .r if (H4EC13 == 6)
replace H4EC13 = .d if (H4EC13 == 8)
replace H4EC14 = .r if (H4EC14 == 6)
replace H4EC14 = .d if (H4EC14 == 8)
replace H4EC15 = .r if (H4EC15 == 6)
replace H4EC15 = .d if (H4EC15 == 8)
replace H4EC16 = .r if (H4EC16 == 6)
replace H4EC16 = . if (H4EC16 == 7)
replace H4EC16 = .d if (H4EC16 == 8)
replace H4EC17 = . if (H4EC17 == 97)
replace H4EC17 = .d if (H4EC17 == 98)
replace H4EC18 = .r if (H4EC18 == 6)
replace H4EC18 = .d if (H4EC18 == 8)
replace H4EC19 = .r if (H4EC19 == 96)
replace H4EC19 = .d if (H4EC19 == 98)

replace H4PE1 = .r if (H4PE1 == 6)
replace H4PE1 = .d if (H4PE1 == 8)
replace H4PE2 = .r if (H4PE2 == 6)
replace H4PE2 = .d if (H4PE2 == 8)
replace H4PE3 = .r if (H4PE3 == 6)
replace H4PE3 = .d if (H4PE3 == 8)
replace H4PE4 = .r if (H4PE4 == 6)
replace H4PE4 = .d if (H4PE4 == 8)
replace H4PE5 = .r if (H4PE5 == 6)
replace H4PE5 = .d if (H4PE5 == 8)
replace H4PE6 = .r if (H4PE6 == 6)
replace H4PE6 = .d if (H4PE6 == 8)
replace H4PE7 = .r if (H4PE7 == 6)
replace H4PE7 = .d if (H4PE7 == 8)
replace H4PE8 = .r if (H4PE8 == 6)
replace H4PE8 = .d if (H4PE8 == 8)
replace H4PE9 = .r if (H4PE9 == 6)
replace H4PE9 = .d if (H4PE9 == 8)
replace H4PE10 = .r if (H4PE10 == 6)
replace H4PE10 = .d if (H4PE10 == 8)
replace H4PE11 = .r if (H4PE11 == 6)
replace H4PE11 = .d if (H4PE11 == 8)
replace H4PE12 = .r if (H4PE12 == 6)
replace H4PE12 = .d if (H4PE12 == 8)
replace H4PE13 = .r if (H4PE13 == 6)
replace H4PE13 = .d if (H4PE13 == 8)
replace H4PE14 = .r if (H4PE14 == 6)
replace H4PE14 = .d if (H4PE14 == 8)
replace H4PE15 = .r if (H4PE15 == 6)
replace H4PE15 = .d if (H4PE15 == 8)
replace H4PE16 = .r if (H4PE16 == 6)
replace H4PE16 = .d if (H4PE16 == 8)
replace H4PE17 = .r if (H4PE17 == 6)
replace H4PE17 = .d if (H4PE17 == 8)
replace H4PE18 = .r if (H4PE18 == 6)
replace H4PE18 = .d if (H4PE18 == 8)
replace H4PE19 = .r if (H4PE19 == 6)
replace H4PE19 = .d if (H4PE19 == 8)
replace H4PE20 = .r if (H4PE20 == 6)
replace H4PE20 = .d if (H4PE20 == 8)
replace H4PE21 = .r if (H4PE21 == 6)
replace H4PE21 = .d if (H4PE21 == 8)
replace H4PE22 = .r if (H4PE22 == 6)
replace H4PE22 = .d if (H4PE22 == 8)
replace H4PE23 = .r if (H4PE23 == 6)
replace H4PE23 = .d if (H4PE23 == 8)
replace H4PE24 = .r if (H4PE24 == 6)
replace H4PE24 = .d if (H4PE24 == 8)
replace H4PE25 = .r if (H4PE25 == 6)
replace H4PE25 = .d if (H4PE25 == 8)
replace H4PE26 = .r if (H4PE26 == 6)
replace H4PE26 = .d if (H4PE26 == 8)
replace H4PE27 = .r if (H4PE27 == 6)
replace H4PE27 = .d if (H4PE27 == 8)
replace H4PE28 = .r if (H4PE28 == 6)
replace H4PE28 = .d if (H4PE28 == 8)
replace H4PE29 = .r if (H4PE29 == 6)
replace H4PE29 = .d if (H4PE29 == 8)
replace H4PE30 = .r if (H4PE30 == 6)
replace H4PE30 = .d if (H4PE30 == 8)
replace H4PE31 = .r if (H4PE31 == 6)
replace H4PE31 = .d if (H4PE31 == 8)
replace H4PE32 = .r if (H4PE32 == 6)
replace H4PE32 = .d if (H4PE32 == 8)
replace H4PE33 = .r if (H4PE33 == 6)
replace H4PE33 = .d if (H4PE33 == 8)
replace H4PE34 = .r if (H4PE34 == 6)
replace H4PE34 = .d if (H4PE34 == 8)
replace H4PE35 = .r if (H4PE35 == 6)
replace H4PE35 = .d if (H4PE35 == 8)
replace H4PE36 = .r if (H4PE36 == 6)
replace H4PE36 = .d if (H4PE36 == 8)
replace H4PE37 = .r if (H4PE37 == 6)
replace H4PE37 = .d if (H4PE37 == 8)
replace H4PE38 = .r if (H4PE38 == 6)
replace H4PE38 = .d if (H4PE38 == 8)
replace H4PE39 = .r if (H4PE39 == 6)
replace H4PE39 = .d if (H4PE39 == 8)
replace H4PE40 = .r if (H4PE40 == 6)
replace H4PE40 = .d if (H4PE40 == 8)
replace H4PE41 = .r if (H4PE41 == 6)
replace H4PE41 = .d if (H4PE41 == 8)

*Wave 1 (code from ICPSR supplemental DO file)
replace H1GH39 = .r if (H1GH39 == 6)
replace H1GH39 = .d if (H1GH39 == 8)
replace H1GH40 = .r if (H1GH40 == 6)
replace H1GH40 = .d if (H1GH40 == 8)
replace H1GH41 = .r if (H1GH41 == 6)
replace H1GH41 = . if (H1GH41 == 7)
replace H1GH41 = .d if (H1GH41 == 8)
replace H1GH42 = .r if (H1GH42 == 6)
replace H1GH42 = .d if (H1GH42 == 8)
replace H1GH43 = .r if (H1GH43 == 6)
replace H1GH43 = .d if (H1GH43 == 8)
replace H1GH43 = .n if (H1GH43 == 9)
replace H1GH44 = .r if (H1GH44 == 6)
replace H1GH44 = .d if (H1GH44 == 8)
replace H1GH46 = .r if (H1GH46 == 6)
replace H1GH46 = .d if (H1GH46 == 8)
replace H1GH46 = .n if (H1GH46 == 9)

foreach var of varlist H1RP* H1MO* {
	replace `var' = .r if (`var' == 6)
	replace `var' = . if (`var' == 7)
	replace `var' = .d if (`var' == 8)
	replace `var' = .n if (`var' == 9)
}

replace S4 = .d if S4 == 98
replace S5 = . if S5 == 97 //be sure to keep track of the multiple response category (coded 99)
replace S5 = .d if S5 == 98
replace S7 = . if S7 == 97 //be sure to keep track of the multiple response category (coded 99)

