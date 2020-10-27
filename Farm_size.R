#+eval=FALSE
##Farm Size
# 1.-to call Libraries
library(dplyr)#to aggregate data
library(foreign)# to read dbf data

#2.-to import size data
years<-list("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018")
setwd("Spatial_Data/InVeKoS/")
plots.list <- list()
for( i in 1:length(years)){
  plots.list[[i]]<-read.dbf(paste0("Inv_KPD_",years[[i]],"_C.dbf"), as.is = FALSE)#import data dbf
  plots.list[[i]]<-plots.list[[i]][,c("K_ART","BNR_ZD","Area_H")]#select only the necessary data
  plots.list[[i]]$AYEAR<-as.integer(years[[i]])#to recognize and check the year data
}

#3.-to establish working path and save data as back up
setwd("../..")
save(plots.list,file = "rda/plots.list.rda")
#load("rda/plots.list.rda") #just if it is necessary,
#not to rerun the previous script.

#4.-To create aggregate
size_farms<-list()
size_farms_aggr<-list()
#to give the score of size farms
breaks_values<- c(350,600,1250,1550)
scores_values<-c(0,25,50,75,100)
for (i in 1:length(plots.list)) {
  size_farms[[i]]<-plots.list[[i]]
  size_farms_aggr[[i]]<- aggregate(x=size_farms[[i]]["Area_H"],
                                   by=size_farms[[i]]["BNR_ZD"],
                                   FUN=sum)
  size_farms_aggr[[i]]$cat_size<-ifelse(size_farms_aggr[[i]]$Area_H>=breaks_values[1] & size_farms_aggr[[i]]$Area_H<breaks_values[2],scores_values[2],
                                        ifelse(size_farms_aggr[[i]]$Area_H>=breaks_values[2] & size_farms_aggr[[i]]$Area_H<breaks_values[3],scores_values[3],
                                               ifelse(size_farms_aggr[[i]]$Area_H>=breaks_values[3] & size_farms_aggr[[i]]$Area_H<breaks_values[4],scores_values[4],
                                                      ifelse(size_farms_aggr[[i]]$Area_H<breaks_values[1],scores_values[1],scores_values[5]))))
  size_farms_aggr[[i]]<-size_farms_aggr[[i]][,c("BNR_ZD","cat_size")]#select just The ID_owners and cat size
}

a<-size_farms_aggr[[2]]
#to save data
save(size_farms_aggr,file = "rda/size_farms_aggr.rda")
#load("rda/size_farms_aggr.rda") #just if it is necessary,
#not to rerun the previous script.

#5.-to import silage maize data and joining the cat_size to the silage maize selected
load("rda/silage_maize_cat.rda")
for (i in 1:length(silage_maize_cat)){
  silage_maize_cat[[i]]<-left_join(silage_maize_cat[[i]],size_farms_aggr[[i]],by="BNR_ZD")
}
#saving join data
save(silage_maize_cat,file = "rda/silage_maize_cat.rda")

