import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh-daily_20240703.csv", clear


generate time2 = date(time, "YMD")
format %td time2
 
gen annee = year(time2)
gen mois = month(time2)
gen jour = day(time2)

gen ddate = mdy(mois, jour, annee)
format ddate %td

gen ID = location + "_" + string(annee) + "_" + string(mois) 
gen fourdigits = real(substr(location, -4, 4))
//gen ddate = mdy(MONTH, DATE, YEAR)
//format ddate %td
//gen TEMP_DIFF= NORMAL_TEMP - MAX_TEMP
//tsset fourdigits time2
//tsspell , cond(TEMP_DIFF >= 3)
//egen length = max(_seq), by(DISTRICT_ID _spell)

// WM: your ID will be the same for all days within the same month/year/location!

// HA: Yes, I consider 

sort ID


*************************************************************

//               heavy rainfall

*************************************************************




// Step 1: Calculate the 75th percentile
_pctile rfh, nq(100) //r(r75) =  .1694881916046143    
scalar pct_75rfh = r(r75)  // Store the value of the 75th percentile in a scalar 

// WM: this is the 75th percentile for the entire G5 Sahel, meaning that, if WFP would have provided us with rainfall data of one country or the entire world, the results will be very different?? So, what would be the solution?

// HA: If we have the 75th percentile for a specific period/year/country/region we could consider each 75th percentile

// Step 2: Create a new categorical variable
by ID: gen category_variable = .
by ID: replace category_variable = 0 if rfh <= pct_75rfh
by ID: replace category_variable = 1 if rfh > pct_75rfh // Extreme rainfall categories (heavy>75 percentile): 

//tab category_variable

//-	Number of days with heavy rainfall in the last 30 days for any given date
egen number_heavy_days = total(category_variable == 1), by(ID)
tab number_heavy_days

// WM: so I guess this results in the same number of days for all dates within the same month, no? I think a "rolling" interval of 30d is required, no?  
// HA: 

//-	Longest consecutive number of days with heavy rainfall in the last 30 days

bysort ID : gen Longest = category_variable == 1 & (_n == 1 | category_variable[_n-1] == 0) 
by ID: replace Longest = Longest[_n-1] + 1 if category_variable == 1 & Longest == 0 
egen LongestConsDays = max(Longest), by(ID)
tab LongestConsDays

// WM: again, I guess this would result in the same longest sonsecutive number of days within the same month, no? Did you check?
// HA: 

//drop Longest


*************************************************************

//              Dry periods computation

*************************************************************



// Dry periods

by ID: gen dry_period = .
by ID: replace dry_period = 1 if rfh <= 2 // days with less than 2 mm precipitation 
by ID: replace dry_period = 0 if rfh > 2 

tab dry_period




// - Longest number of consecutive dry days
/*
Longest number of consecutive days with less than 2 mm precipitation in the last 30 days
*/

bysort ID : gen Longest_dry = dry_period == 1 & (_n == 1 | dry_period[_n-1] == 0) 
by ID: replace Longest_dry = Longest_dry[_n-1] + 1 if dry_period == 1 & Longest_dry == 0 
egen LongestConsDryDays = max(Longest_dry), by(ID)
tab LongestConsDryDays

// WM: (i) same issue with ID as mentioned above; (ii) I need to check these calculations more thoroughly (you could also consider the command "tsspell" I guess)
// HA: 


// - Days since last rain
/*
Number of consecutive days with less than 2 mm precipitation in the last 30 days
*/
egen ConsDryDays = total(dry_period == 1), by(ID)
tab ConsDryDays

// WM: (i) same issue with ID as mentioned above; (ii) I don't see how this calculation avoids considering dry days before a rainy day in the last 30 days?
// HA: 
tsset ID category_variable
gen run = .
by ID: replace run = cond(L.run == ., 1, L.run + 1)
by ID: egen maxrun = max(run)
tsspell ID