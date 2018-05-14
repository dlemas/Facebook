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
library(ggplot2)

# **************************************************************************** #
# ***************       BEACH Report 3-23-18 to 5-9-18 .xlsx                                              
# **************************************************************************** #      

# file parameters
n_max=10000
data.file.name="BEACH Report 3-23-18 to 5-9-18 .xlsx";data.file.name

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
newdata=rename(dat, reporting_starts = `Reporting Starts`, 
               reporting_ends=`Reporting Ends`, 
               ad_set_name='Ad Set Name', 
               ad_set_delivery='Ad Set Delivery', 
               results=`Results`, 
               result_indicator='Result Indicator', 
               reach=Reach,
               impressions=Impressions, 
               cost_per_results='Cost per Results', 
               ad_set_budget='Ad Set Budget',
               budget_type='Ad Set Budget Type', 
               amount_spent_USD='Amount Spent (USD)', 
               ends=Ends,
               starts=Starts,
               frequency=Frequency, 
               unique_link_clicks='Unique Link Clicks',
               button_clicks='Link Clicks');newdata; names(newdata)

# compute day of week
newdata$weekday=weekdays(as.Date(newdata$reporting_ends,'%Y-%m-%d',tz = "UTC"))

# select data
dat.days=newdata %>%
  select(weekday,unique_link_clicks,button_clicks,cost_per_results) %>%
  group_by(weekday) %>%
  summarize(click.m=mean(unique_link_clicks),
            button.m=mean(button_clicks),
            cost.m=mean(cost_per_results)) %>%
  mutate(weekday.c = factor(weekday, levels = c("Sunday","Monday","Tuesday","Wednesday",
                                                "Thursday","Friday","Saturday")))
# # plot: click.m 
# ggplot(dat.days, aes(x=factor(weekday.c), y=click.m))+geom_bar(stat="identity")
# 
# # plot: button.m 
# ggplot(dat.days, aes(x=factor(weekday.c), y=button.m))+geom_bar(stat="identity")
# 
# # plot: cost.m 
# ggplot(dat.days, aes(x=factor(weekday.c), y=cost.m))+geom_bar(stat="identity")
# 

# **************************************************************************** #
# ***************                Results by Time of Day                                             
# **************************************************************************** #

# read data
time.dat=read_xlsx(paste(data.dir,data.file.name,sep=""), sheet = "Results by Time of Day", range = NULL, col_names = TRUE,
                  col_types = NULL, na = "NA", trim_ws = TRUE, skip = 0, n_max = Inf,
                  guess_max = min(1000, n_max));time.dat

# data
dat=time.dat
names(dat)

# rename
newdata2=rename(dat, reporting_starts = `Reporting Starts`, 
               reporting_ends=`Reporting Ends`, 
               ad_set_name='Ad Set Name', 
               time_of_day=`Time of Day (Ad Account Time Zone)`,
               ad_set_delivery=`Ad Set Delivery`, 
               results=`Results`, 
               result_indicator='Result Indicator', 
               reach=Reach,
               impressions=Impressions, 
               cost_per_results='Cost per Results', 
               ad_set_budget='Ad Set Budget',
               budget_type='Ad Set Budget Type', 
               amount_spent_USD='Amount Spent (USD)', 
               ends=Ends,
               starts=Starts,
               frequency=Frequency, 
               unique_link_clicks='Unique Link Clicks',
               link_clicks='Link Clicks',
               button_clicks='Button Clicks');newdata2; names(newdata2)

# compute 24 hours in day
newdata2$hours=as.factor(seq_along(newdata2$time_of_day))
range(newdata2$hours)
names(newdata2)

# # plot: click.m 
# ggplot(newdata2, aes(x=factor(hours), y=results))+geom_bar(stat="identity")

# **************************************************************************** #
# ***************                Results by Age                                             
# **************************************************************************** #

# read data
age.dat=read_xlsx(paste(data.dir,data.file.name,sep=""), sheet = "Results by Age", range = NULL, col_names = TRUE,
                   col_types = NULL, na = "NA", trim_ws = TRUE, skip = 0, n_max = Inf,
                   guess_max = min(1000, n_max));age.dat