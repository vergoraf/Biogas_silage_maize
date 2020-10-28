#+eval=FALSE
##Import biogas data
#previously was joined tables EKS with LfU through equal Biogasanlagen ID and saved 
#1.- to call libraries
library(sf)#to use sf data, import and export shp files
library(tmap)#to render data as plot or view
#library(tidyverse)#to extract csv data
library(readxl)
#2.- Import Biogas data
#locale(encoding = "ISO-8859-1"),
biogas <- read_xls("Tables/biogas_list.xls", 
                    col_names = TRUE, col_types=NULL)

#3.- to convert data to sf using coordinates from biogas data and establishing
#projection
#projecting it to ETRS89 / UTM zone 33N
biogas_c<-st_as_sf(x=biogas,coords=c("Ostwert","Nordwrt"),
                        crs = 32633,remove = F)
b_pl_years<-biogas_c%>%st_transform(32633)
rm(biogas_c,biogas)
#it is used the date betrieb from the unofficial database. It looks updated in compare to 
#from LfU
#as r data
save(b_pl_years, file = "rda/b_pl_years.rda")
#6.- to check data through viewer
tmap_mode('view') 
tm_shape(biogas_pl_years) +
  tm_dots(size=0.02,col="green")
tmap_mode('plot')#to close viewer
