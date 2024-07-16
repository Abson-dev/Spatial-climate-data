
import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.csv", varnames(1) clear

rename  admin2pcod location

save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.dta", replace


import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh-daily_20240703.csv", clear

merge m:1 location using "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\G5_Sahel_admin2Name.dta"
drop _m

generate time2 = date(time, "YMD")
format %td time2
 
/* 
gen annee = year(time2)
gen mois = month(time2)
gen jour = day(time2)

//gen tmp_time = time2
//format %td tmp_time

//gen ddate = mdy(mois, jour, annee)
//format ddate %td

*/

tab location

encode location, generate(location2)
tab location2


*************************************************************

//              Dry periods computation

*************************************************************
// Dry periods

gen dry_threshold = 2 // days with less than 2 mm precipitation 
gen dry_period = (rfh < dry_threshold)
replace dry_period = . if dry_period == 0


/*
. tab dry_period,m

 dry_period |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |  3,767,674       85.00       85.00
          . |    664,799       15.00      100.00
------------+-----------------------------------
      Total |  4,432,473      100.00


*/

*************************************************************

//               heavy rainfall

*************************************************************
gen heavy_treshold = 20 // Extreme rainfall categories (heavy>20 mm): 
gen heavy = (rfh > heavy_treshold)
//replace heavy = . if heavy == 0

/*
 tab  heavy,m

      heavy |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |     40,757        0.92        0.92
          . |  4,391,716       99.08      100.00
------------+-----------------------------------
      Total |  4,432,473      100.00


. tab adm0_code heavy,m

           |         heavy
 adm0_code |         1          . |     Total
-----------+----------------------+----------
        BF |    13,323    701,592 |   714,915 
        ML |     8,983    785,367 |   794,350 
        MR |     1,418    745,271 |   746,689 
        NE |     5,878  1,058,551 | 1,064,429 
        TD |    11,155  1,100,935 | 1,112,090 
-----------+----------------------+----------
     Total |    40,757  4,391,716 | 4,432,473 
	  
	  
	  
 */

sort location2 time2


tsset location2 time2
//tsset location_last_num time2,monthly
//tsset location2 time2,delta(30 days)

*************************************************************

//               heavy rainfall

*************************************************************


tsspell , cond(rfh > heavy_treshold)
egen length_heavy = max(_seq), by(location2 _spell)
gen n_heavy_sequence = .
replace n_heavy_sequence = _end if length_heavy !=1
//egen num = sum(_end), by(location_last_num _spell)


order location2 rfh time2  heavy _seq _spell _end length_heavy 
rename _seq heavy_seq
rename _spell heavy_spell
rename  _end heavy_end


*ssc install rangestat
rangestat (sum) n_heavy_sequence, interval(time2 -29 -1)  by(location2)
rangestat (max) heavy_seq, interval(time2 -29 -1)  by(location2)
replace heavy_seq_max = 30 if heavy_seq_max > 30 
replace heavy_seq_max = . if n_heavy_sequence_sum == .
*************************************************************

//              Dry periods computation

*************************************************************
tsspell , cond(rfh < dry_threshold) // & rfh < dry_threshold 

replace _spell = . if _spell == 0
replace _seq = . if _seq == 0
replace _end = . if _end == 0

replace _seq = 30 if _seq > 30

replace _seq = . if dry_period == .

rename _seq dry_seq
rename _spell dry_spell
rename  _end dry_end
egen dry_length = max(dry_seq), by(location2 dry_spell)
gen dry_end_true = .
replace dry_end_true = dry_end if dry_length !=1

drop dry_length

rangestat (count) dry_spell, interval(time2 -30 -1)  by(location2)


rangestat (max) dry_seq, interval(time2 -30 -1)  by(location2)
rangestat (sum) dry_end_true, interval(time2 -30 -1)  by(location2)

drop dry_seq_max

drop dry_seq_max
egen dry_length = max(dry_seq), by(location2 dry_spell)


rangestat (sum) dry_end_true, interval(time2 -29 -1)  by(location2)
rangestat (max) dry_seq, interval(time2 -29 -1)  by(location2)
replace dry_seq_max = 30 if dry_seq_max > 30 
replace dry_seq_max = . if n_dry_sequence_sum == .





ssc install rangestat
rangestat (sum) n_dry_sequence, interval(time2 -29 -1)  by(location2)
rangestat (max) dry_seq, interval(time2 -29 -1)  by(location2)
replace dry_seq_max = 30 if dry_seq_max > 30 
replace dry_seq_max = . if n_dry_sequence_sum == .



order location location2 admin2name rfh time2  heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence dry_period dry_seq dry_spell dry_end length_dry n_dry_sequence 

//drop *_end *_seq *_spell
drop length_heavy length_dry dry_threshold heavy_treshold

drop time location2

order  location admin2name time2 rfh heavy heavy_seq heavy_spell heavy_end length_heavy n_heavy_sequence n_heavy_sequence_sum heavy_seq_max dry_period  dry_seq dry_spell dry_end length_dry n_dry_sequence n_dry_sequence_sum dry_seq_max


rename n_heavy_sequence_sum
rename heavy_seq_max

rename n_dry_sequence_sum
rename dry_seq_max

save "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\WF_extreme_weather_events.dta",replace

