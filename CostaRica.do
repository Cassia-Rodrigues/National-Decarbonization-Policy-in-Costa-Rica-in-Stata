*ECON 676

clear all

log using NDP_stata.smcl


use "output_file.dta",clear


des
**# Macro indicators
rename seriesname year

*GDP per Capita over the years
line gdppercapitac~s year, xtitle("Year") title("GDP per Capita (Constant) over the years")xline(2019)

*Population growth (expected)
sc pop* year, xtitle("Year") title("Population growth (expected)")xline(2019)

*Poverty headcount ratio: Uptick in poverty post 2019
line povertyheadcountratioat550aday20 year, xtitle("Year") ytitle("Poverty Headcount Ratio") title("Poverty Headcount Ratio over the years")xline(2019)

*Unemployment over the years
line unemployment* year, xtitle("Year") ytitle("Unemployment, total (% of total labor force)") title("Unemployment over the years")xline(2019)

*Renaming the columns
rename co2emissionsbysectormtco2eqbuild co2building
rename co2emissionsbysectormtco2eqbunke co2fuel
rename co2emissionsbysectormtco2eqelect co2electricity
rename co2emissionsbysectormtco2eqenerg co2energy
rename co2emissionsbysectormtco2eqmanuf co2manufacture
rename co2emissionsbysectormtco2eqother co2other

*Graph showing the CO2 emissions across sectors: Energy consumes the most
graph bar co2building co2electricity co2energy co2fuel co2manufacture co2other, title("CO2 emissions across sectors")

*CO2 emissions per dollar of manufacture
line co2emissionsperdollarofmanufactu year, xtitle("Year") ytitle("CO2 emissions per dollar") title("CO2 emissions per dollar of manufacture") xline(2019)

*SEM MODEL
sem (co2emissionsperdollarofmanufactu -> gdppercapitaconstantcurrentus, ) (year -> co2emissionsperdollarofmanufactu, ), method(mlmv) nocapslatent


log close
