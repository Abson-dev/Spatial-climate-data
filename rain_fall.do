 
 
import delimited "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.csv", clear
 
drop v1
generate time2 = date(time, "YMD")
format %td time2
 
gen annee = year(time2)
gen mois = month(time2)
gen jour = day(time2)

gen ID = location  + "_" + string(mois) + "_" + string(jour)

order time2 annee mois jour ID location

save  "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.dta", replace
 
collapse (mean) rfh, by(ID) 

rename rfh rfh_avg_all_hema 
save  "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\lta.dta", replace

use "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.dta", clear
 
merge m:1 ID using "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\lta.dta"
drop  _merge

keep time time2 location rfh rfq rfh_avg_all_hema rfh_avg  rfh_avg_all_hema annee mois jour ID

//sort  location time

save  "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.dta", replace


////////////////////////////////////////////////
keep if annee >=1989 & annee<=2018
collapse (mean) rfh, by(ID) 

rename rfh rfh_avg_hema 
save  "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\lta.dta", replace

use "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.dta", clear
 
merge m:1 ID using "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\lta.dta"
drop  _merge

keep time time2 location rfh rfq rfh_avg_hema rfh_avg_all_hema rfh_avg 
 
sort location  time 

save  "C:\Users\AHema\OneDrive - CGIAR\Desktop\2024\WFP\Spatial climate data\sahel_rfh_20240618.dta", replace