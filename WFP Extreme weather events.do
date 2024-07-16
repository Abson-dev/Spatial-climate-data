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
 
gen p75 = r(r75)
gen p90 = r(r90)
gen p95 = r(r95)

*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
replace heavy = 1 if rfh > p75 // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
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
gen n_dry_sequence = .
replace n_dry_sequence = _end if length_dry !=1


rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95


ssc install rangestat
rangestat (sum) n_dry_sequence, interval(time2 -30 -1)  by(location_last_num)
rangestat (max) length_dry, interval(time2 -30 -1)  by(location_last_num)
// by(id)
*Lags consider only full windows (defined by lower limit of interval)
replace sum_x=. if date<=3
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)

//keep in 1/200


bysort location_last_num time2 : gen sum30days = sum(n_heavy_sequence[_n-29])
drop sum
g sum30days = .

keep in 1/1000
g i1 = 1 if  time2[1]>=time2 & (time2[1]-time2) <= 30
forval n = 1/`=_N' {
       cap drop i`n'
       g i`n' = 1 if  time2[`n']>=time2 & (time2[`n']-time2) <= 30
       egen sum30days`n' = total(n_heavy_sequence) if i`n'==1
       replace sum30days = sum30days`n' if mi(n_heavy_sequence)
       drop  i`n'
       drop sum30days`n'
       }
drop sum30days
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\BF_extreme_weather_events.dta",replace

restore

******************************************************************************


// Chad

*****************************************************************************
preserve

keep if adm0_code == "TD"

_pctile rfh, nq(100)  
 
gen p75 = r(r75)
gen p90 = r(r90)
gen p95 = r(r95)


*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
replace heavy = 1 if rfh > p75 // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
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
gen n_dry_sequence = .
replace n_dry_sequence = _end if length_dry !=1


rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
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
 
gen p75 = r(r75)
gen p90 = r(r90)
gen p95 = r(r95)



*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
replace heavy = 1 if rfh > p75 // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
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
gen n_dry_sequence = .
replace n_dry_sequence = _end if length_dry !=1


rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
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
 
gen p75 = r(r75)
gen p90 = r(r90)
gen p95 = r(r95)



*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
replace heavy = 1 if rfh > p75 // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
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
gen n_dry_sequence = .
replace n_dry_sequence = _end if length_dry !=1


rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
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
 
gen p75 = r(r75)
gen p90 = r(r90)
gen p95 = r(r95)



*************************************************************

//               heavy rainfall

*************************************************************


gen heavy = .
replace heavy = 1 if rfh > p75 // Extreme rainfall categories (heavy>75 percentile): 

tsset location_last_num time2
//tsset location_last_num time2,monthly
//tsset location_last_num time2,delta(30 days)

tsspell , cond(rfh > p75)
egen length_heavy = max(_seq), by(location_last_num _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
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
gen n_dry_sequence = .
replace n_dry_sequence = _end if length_dry !=1


rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end

order location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
keep location location_last_num rfh time2 p75 heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence p90 p95
//keep if _spell>0

//list time2 rfh length num if _spell, sepby(_spell)
save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\Mauritania_extreme_weather_events.dta",replace

restore