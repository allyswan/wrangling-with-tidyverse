#############################
#Ally Swan
#9/4/25
#############################

library(readxl)
library(tidyverse)

#1. Import sttstj_all_sites and inspect the data set.  What is the data structure and the data type of each field?
site <- read_xlsx("data/sttstj_all_sites.xlsx", sheet = "locations")

#^^use tab to find path name

glimpse(site)
# This data is tabular and has rows and columns. The columns lat, long, year are numeric doubles, while the colums hab and yr_site are characters.

#2. How many samples are in the data set? 
nrow(site)
#There are 2505 samples in the data set.

#3. How many unique habitat types are there?  What are the names of each habitat?
site$hab
unique(site$hab)
#PVMT, AGRF, PTRF, SCR, BDRK, HARD
site %>% distinct(hab)

#4. How many sites are there in the "PVMT" habitat type?
PVMT <- site %>%
  count(hab)
print(PVMT)

site %>% filter(hab == "PVMT") %>% nrow()
#571 sites

#5. How many sites are there in the "PVMT" or "AGRF" habitat types?
site %>% filter(hab == "PVMT"| hab == "AGRF") %>% nrow()
#OR = whether the column has pvmt and agrf
#1538
myHabs <- c("PVMT", "AGRF")
site %>% filter(hab %in% myHabs) %>% nrow()

#6. How many sites are there in all the habitat types EXCEPT “PVMT”?
site %>%
  filter(hab != "PVMT") %>% nrow()
#1934

#7. Show the first 5 records (rows) of…
  #all sites sampled in “AGRF” or “SCR"s
head(site)
  site %>%
      filter(hab == "AGRF"| hab == "SCR") %>%
  #only show the “yr_site” and “hab” column
    select(yr_site,hab) %>% head()
  
#8. What is the northern most site sampled in the “BDRK” habitat?
site %>%
    filter(hab == "BDRK") %>%
    arrange(desc(lat))
#2019_5450  

#9. What is the western most site sampled in either “AGRF” or “PTRF” habitat?
site %>%
    filter (hab == "AGRF"| hab == "PTRF") %>%
    arrange(lon)
#2015_9758

#10. How many years were surveyed in the data set?
unique (site$year)
#16
site %>% distinct(year)

#11. What is the eastern most site sample in the “AGRF” habitat in 2004?
site %>% 
  filter (hab == "AGRF" & year == "2004") %>% 
  arrange(desc(lon))
#2004_1821
