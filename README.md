# Finance Chartbook 
This repo provides a starting point to build your own PDF chartbook of the financial economy. 

## Quick Use 

#### Clone repo 
```
git clone https://github.com/slee981/FinanceChartbook.git
cd FinanceChartbook
```

#### Setup your FRED API key 
1. Go to https://research.stlouisfed.org/useraccount/apikeys. 
2. Create account and request key. 
3. Change the file name from `./utils/config_template.R` to `./utils/config.R` and paste your new FRED API key into the variable. 

#### Knit
Open file `./Chartbook.Rmd` in RStudio and knit. 