#1.- to call libraries
library(sf)#to use sf data
library(lubridate) # to modify time data
library(dplyr)# to select and modify columns
library(GISTools)
library(raster)# to manage raster data
library(rgeos)
library(tmap)

#2.- loading data
load(file = "rda/b_pl_years.rda")
#3.-order data
b_pl_years$cat<-ordered(b_pl_years$cat,
                        levels = c("2008","2009","2010","2011","2012",
                                   "2013","2014","2015","2016","2017","2018"))# to keep order of the years
#4.- Calculating Yield in Tonnes
q<-(b_pl_years$kw_el*8000*0.5929)/367.785
q12<-(b_pl_years$kw_el*8000*0.5688)/367.785
b_pl_years$Q<-ifelse(b_pl_years$cat<2012,q,q12)

#5.-Yearly Substrate Availability & Yield values 
A<- c(0.04,0.05,0.06,0.07)# Maize Availibility. 0-1 Proportion
Y<- c(31.59,33.11,28.57,38.75,36.26,30.68,36.94,28.98,32.41,38.54,21.42)#Yield Silage maize tonnes/ha
b_pl_years$A<-ifelse(b_pl_years$cat==2008,A[1],
                     ifelse(b_pl_years$cat %in% c(2009,2010),A[2],
                            ifelse(b_pl_years$cat %in% c(2011,2012,2013,2014,2015,2016),A[3],A[4])))
b_pl_years$Y<-ifelse(b_pl_years$cat==2008,Y[1],
                     ifelse(b_pl_years$cat ==2009,Y[2],
                            ifelse(b_pl_years$cat ==2010,Y[3],
                                   ifelse(b_pl_years$cat==2011,Y[4],
                                          ifelse(b_pl_years$cat==2012,Y[5],
                                                 ifelse(b_pl_years$cat==2013,Y[6],
                                                        ifelse(b_pl_years$cat==2014,Y[7],
                                                               ifelse(b_pl_years$cat==2015,Y[8],
                                                                      ifelse(b_pl_years$cat==2016,Y[9],
                                                                             ifelse(b_pl_years$cat==2017,Y[10],Y[11]))))))))))


#6.-Calculating radius 
t<-1270 #tortuosity factor by km
b_pl_years$r<- sqrt(b_pl_years$Q/(100*pi*b_pl_years$A*b_pl_years$Y))*t#radius column
r<- sqrt(b_pl_years$Q/(100*pi*b_pl_years$A*b_pl_years$Y))*t

#7.-Export data
#export the points which have to be represented as shp
st_write(b_pl_years,ds="Spatial_Data/b_pl_years.shp",layer="b_pl_years.shp",
         driver="ESRI Shapefile",delete_layer=T)

#8.-classifying data through temporal range
years<-list("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018")

#9.-creating buffers list
buffer<-b_pl_years%>%
  st_buffer(dist=r,joinStyle="ROUND",endCapStyle= "ROUND")
buffer.list<-list()

for (i in 1:length(years)){
  buffer.list[[i]]<-as.data.frame(st_union(buffer%>%filter(cat==years[[i]])))
  buffer.list[[i]]$cat<-1
  buffer.list[[i]]<-st_as_sf(buffer.list[[i]])
}

#10.- as r data
save(buffer.list, file = "rda/buffer_list.rda")

#11.- to check data through viewer
tmap_mode('view') 
tm_shape(buffer.list[[2]]) +
  tm_polygons(col="green")
#tm_shape(buffer.list[[2]]) +
#  tm_polygons(col="blue",alpha=0.5)
tmap_mode('plot')#to close viewer
