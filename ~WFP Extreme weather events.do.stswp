import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh-daily_20240703.csv", clear


generate time2 = date(time, "YMD")
format %td time2
 
gen annee = year(time2)
gen mois = month(time2)
gen jour = day(time2)

//gen tmp_time = time2
//format %td tmp_time

//gen ddate = mdy(mois, jour, annee)
//format ddate %td

//gen ID = location + "_" + string(annee) + "_" + string(mois) 
gen location_last_num = real(substr(location, -4, 4))

gen adm0_code = substr(location, 1, 2)

*************************************************************

//              Dry periods computation

*************************************************************
// Dry periods

gen dry_period = .
replace dry_period = 1 if rfh < 2 // days with less than 2 mm precipitation 
preserve
// Save

******************************************************************************


// Burkina Faso

*****************************************************************************
keep if adm0_code == "BF"

_pctile rfh, nq(100)  
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 
gen p75 = r(r75)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
//replace category_variable = 0 if rfh <= pct_75rfh
replace heavy = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
//egen num = sum(_end), by(location_last_num _spell)


order location rfh time2 p75 heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end

*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < 2)

egen length_dry = max(_seq), by(location_last_num _spell)



rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\BF_extreme_weather_events.dta",replace

restore

******************************************************************************


// Chad

*****************************************************************************
preserve

keep if adm0_code == "TD"

_pctile rfh, nq(100)  
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 
gen p75 = r(r75)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
//replace category_variable = 0 if rfh <= pct_75rfh
replace heavy = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
//egen num = sum(_end), by(location_last_num _spell)


order location rfh time2 p75 heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end

*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < 2)

egen length_dry = max(_seq), by(location_last_num _spell)



rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\Chad_extreme_weather_events.dta",replace

restore

******************************************************************************


// Niger

*****************************************************************************

preserve

keep if adm0_code == "NE"

_pctile rfh, nq(100)  
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 
gen p75 = r(r75)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
//replace category_variable = 0 if rfh <= pct_75rfh
replace heavy = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
//egen num = sum(_end), by(location_last_num _spell)


order location rfh time2 p75 heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end

*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < 2)

egen length_dry = max(_seq), by(location_last_num _spell)



rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\Niger_extreme_weather_events.dta",replace

restore


******************************************************************************


// Mali

*****************************************************************************

preserve

keep if adm0_code == "ML"

_pctile rfh, nq(100)  
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 
gen p75 = r(r75)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
//replace category_variable = 0 if rfh <= pct_75rfh
replace heavy = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
//egen num = sum(_end), by(location_last_num _spell)


order location rfh time2 p75 heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end

*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < 2)

egen length_dry = max(_seq), by(location_last_num _spell)



rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\Mali_extreme_weather_events.dta",replace

restore

******************************************************************************


// Mauritania

*****************************************************************************

preserve

keep if adm0_code == "MR"

_pctile rfh, nq(100)  
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 
gen p75 = r(r75)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
//replace category_variable = 0 if rfh <= pct_75rfh
replace heavy = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
//egen num = sum(_end), by(location_last_num _spell)


order location rfh time2 p75 heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end

*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < 2)

egen length_dry = max(_seq), by(location_last_num _spell)



rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy dry_period dry_seq dry_spell dry_end length_dry
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\Mauritania_extreme_weather_events.dta",replace

restore