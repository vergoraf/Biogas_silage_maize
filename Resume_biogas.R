# Here can be done all the process at once in
# getting the values of the routes and their plotting

Resume_path <- "C://Users/faver/OneDrive - Humboldt-Universitaet zu Berlin, CMS/Master_thesis/Biogas"


source("Import_biogas_data.R")
source("Defining_buffer.R")
source("CA_Raster.R")
source("Intersect.R")
source("persistency.R")
source("livestock.R")
source("Farm_size.R")
source("weighting_values.R")



---------
source("Import_biogas_data.R")
source("Defining_buffer.R")
source("Intersect.R")
source("livestock.R")
source("persistency.R")
source("Farm_size.R")
source("weighting_values.R")

# setwd("C:/Users/faver/Seafile/Berlin/GIS/ERP/Data&Protokoll")
Path_3.1 <- "C:/Users/faver/Seafile/Berlin/GIS/ERP/Data&Protokoll"
# setwd("C:/Users/faver/Seafile/Berlin/GIS/ERP")
Path_3.2 <- "C:/Users/faver/Seafile/Berlin/GIS/ERP/"
# setwd("C:/Users/faver/Seafile/Berlin/GIS/ERP")
Path_3.3 <- "C:/Users/faver/Seafile/Berlin/GIS/ERP/"
# setwd("C:/Users/faver/Seafile/Berlin/GIS/ERP")
Path_3.4 <- "C:/Users/faver/Seafile/Berlin/GIS/ERP/"
source("r_scripts/master_erp_data.R")
setwd(Resume_path)

# setwd("C:/Users/faver/Seafile/Berlin/GIS/ERP/")
Path_4.1 <- "C:/Users/faver/Seafile/Berlin/GIS/ERP/"
source("r_scripts/master_erp_data_all_06s.R")
setwd(Resume_path)



