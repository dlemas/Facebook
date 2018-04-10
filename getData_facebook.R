##-------------- 
# **************************************************************************** #
# ***************                Project Overview              *************** #
# **************************************************************************** #

# Author:      Dominick Lemas 
# Date:        April 09, 2018 
# IRB:
# Description: Import facebook data for BEACH study  
# Data: C:\Users\Dominick\Dropbox (UFL)\02_Projects\BEACH_STUDY\01_Recruitment\facebook

# **************************************************************************** #
# ***************                Directory Variables           *************** #
# **************************************************************************** #

# Computer
# location="djlemas";location
# location="Dominick";location

# Directory Locations
work.dir=paste("C:\\Users\\",location,"\\Dropbox (UFL)\\02_Projects\\BEACH_STUDY\\01_Recruitment\\facebook\\data\\",sep="");work.dir
data.dir=paste("C:\\Users\\",location,"\\Dropbox (UFL)\\02_Projects\\BEACH_STUDY\\01_Recruitment\\facebook\\data\\",sep="");data.dir
out.dir=paste("C:\\Users\\",location,"\\Dropbox (UFL)\\02_Projects\\BEACH_STUDY\\01_Recruitment\\facebook\\table\\",sep="");out.dir

# Set Working Directory
setwd(work.dir)
list.files()

# **************************************************************************** #
# ***************                Library                       *************** #
# **************************************************************************** #

library(readxl)
library(data.table)
library(tidyr)
library(dplyr)

# **************************************************************************** #
# ***************       BEACH Report 3-23-18 to 3-29-18.xlsx                                              
# **************************************************************************** #      

# file parameters
n_max=10000
data.file.name="BEACH Report 3-23-18 to 3-29-18.xlsx";data.file.name

# **************************************************************************** #
# ***************                Results by Day of Week                                              
# **************************************************************************** #

# read data
day.dat=read_xlsx(paste(data.dir,data.file.name,sep=""), sheet = "Results by Day of Week", range = NULL, col_names = TRUE,
                   col_types = NULL, na = "NA", trim_ws = TRUE, skip = 0, n_max = Inf,
                   guess_max = min(1000, n_max));day.dat
# data
dat=day.dat
names(dat)

# rename
newdata=rename(dat, reporting_starts = `Reporting Starts`, reporting_ends=`Reporting Ends`, ad_set_name='Ad Set Name', 
               delivery=Delivery, results=`Results`, result_indicator=`Result Indicator`, reach=Reach,
               impressions=Impressions, cost_per_results='Cost per Results', budget=Budget,
               budget_type='Budget Type', amount_spent_USD='Amount Spent (USD)', ends=Ends,
               ends_1=Ends__1, starts=Starts, frequency=Frequency, unique_link_clicks='Unique Link Clicks',
               button_clicks='Button Clicks');newdata; names(newdata)

# compute day of week
newdata %>% 
  weekdays(as.Date(reporting_ends,'%Y-%m-%d',tz = "UTC"))


