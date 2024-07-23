

*****************************************************


// This is for Heavy periods computation, because it takes more times to compute all

****************************************************



import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.csv", varnames(1) clear

rename  admin2pcod location

save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.dta", replace


import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh-daily_20240703.csv", clear

merge m:1 location using "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.dta"
drop _m

generate time2 = date(time, "YMD")
format %td time2
 
 
//gen annee = year(time2)
//gen mois = month(time2)
//gen jour = day(time2)

//gen YM = string(annee) + "_" + string(mois) 
/*
//gen tmp_time = time2
//format %td tmp_time

//gen ddate = mdy(mois, jour, annee)
//format ddate %td

*/

//tab location

encode location, generate(location2)
//tab location2

//keep if admin2name == "Kadiogo"

keep if admin2name == "Ville de Niamey"
//sort annee mois

gen seq = _n


*************************************************************

//              Heavy periods computation

*************************************************************
// Heavy periods

gen heavy_threshold = 20 // days with more than 20 mm precipitation (19.6 mm/d, West Africa)
gen heavy_period = (rfh > heavy_threshold)
replace heavy_period = . if heavy_period == 0


sort location2 time2


tsset location2 time2

//keep in 1/300

gen heavy_length = .
gen Number_cons_heavydays = .

***********************************

//keep in 1/500

levelsof seq if seq <= 30 & seq > 2, local(val)
foreach x of local val {
	local debut = 1
	local fin = `x' - 1
	
	tsspell in `debut' / `fin', cond(rfh > heavy_threshold) 
	rename _seq _seq`x'
	rename _spell _spell`x'
	rename  _end _end`x'
	******
	egen max_seq`x' = max(_seq`x') in `debut'/`x'
	replace heavy_length = max_seq`x'  if seq == `x' //& max_seq`x'!=1
	******
	//gen _end`x' = .
	replace _end`x' = 0 if heavy_period[_n]== 1 & heavy_period[_n-1]==. & heavy_period[_n+1]==. in `debut'/`x'
	egen sum_end`x' = sum(_end`x') in `debut'/`x'
	replace Number_cons_heavydays = sum_end`x'  if seq == `x'
	drop max_seq`x' _seq`x' _spell`x' _end`x' sum_end`x' 

}

***********************************

levelsof seq if seq > 30, local(val)
foreach x of local val {
	local debut = `x'-30
	local fin = `x'-1
	//disp `y'
	
	tsspell in `debut' / `fin', cond(rfh > heavy_threshold) 
	rename _seq _seq`x'
	rename _spell _spell`x'
	rename  _end _end`x'
	******
	egen max_seq`x' = max(_seq`x') in `debut'/`x'
	replace heavy_length = max_seq`x'  if seq == `x'
	******
	//gen _end`x' = .
	replace _end`x' = 0 if heavy_period[_n]== 1 & heavy_period[_n-1]==. & heavy_period[_n+1]==. in `debut'/`x'
	egen sum_end`x' = sum(_end`x') in `debut'/`x'
	replace Number_cons_heavydays = sum_end`x'  if seq == `x'
	drop max_seq`x' _seq`x' _spell`x' _end`x' sum_end`x' 

}



//save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\BFA_Kadiogo_heavy.dta", replace 
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\NER_Niamey_heavy.dta", replace 