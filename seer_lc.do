
* this code is to collect lung cancers from SEER and classify histologic subtype

use "/Users/keithsigel/Dropbox/seer18crt_combined.dta"


keep if inlist(PRIMSITE, "C340","C341","C342","C343","C348","C349")
* hist1 -- 1 = adenocarcinoma, 2 = squamous cell, 3 = small cell

destring HISTO3V, replace

gen hist1=1 if inlist(HISTO3V, 8140, 8250, 8251, 8260, 8480, 8481, 8570, 8572)
replace hist1=1 if inlist(HISTO3V, 8323, 8550, 8560)
replace hist1=2 if inlist(HISTO3V, 8570, 8050, 8052)
replace hist1=2 if HISTO3V>= 8070 & HISTO3V<=8075
replace hist1=3 if inlist(HISTO3V, 8012, 8031)
replace hist1=4 if inlist(HISTO3V, 8041, 8042, 8043, 8044, 8045)

* code death
gen death=1 if STAT_REC=="1"
replace death=0 if death==.

*for only squamous + adenocarcinomas
keep if hist1==1 | hist1==2

destring SRV_TIME_MON, replace

*survival in years
gen surv_year= SRV_TIME_MON/12
