# Biogas_silage_maize

Here it is presented the scripts that were used to calculate the likelihood of silage maize for biogas production.

The steps are the following:
1.- Import Biogas plants data. This dataset was previously processed, identifying biogas complex and filtering the biogas satellite plants.
Run Import_biogas_data.R
2.- Calculation of the catchment area
2.1.- Definition of the buffer through the radius 
Run Defining_buffer.R
Result is a polygon layer containing the buffers. This is processed to calculate the euclidean distance (formula (d) in article) in Arcgis. As a result
it is obtained 11 Raster layers which are imported in the next step.
2.2.- Reclassification and Poligonization of results step 2.1; Dissolve of features with equal score 
Run CA_Raster.R
2.3.- Intersect values of catchment area with silage maize plots
First, it is imported the silage maize plots from IACS layers. Therefore they were identified through their codes and organized according to their years.
Secondly,  
Run Intersect.R
