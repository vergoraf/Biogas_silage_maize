# Biogas_silage_maize

Here it is presented the scripts that were used to calculate the likelihood of silage maize for biogas production.

The steps are the following:
1.- Calculation of the catchment area
1.1.- Import Biogas plants data. This dataset was previously processed, identifying biogas complex and filtering the biogas satellite plants.
Run Import_biogas_data.R
1.2.- Definition of the buffer through the radius 
Run Defining_buffer.R
Result is a polygon layer containing the buffers. This is processed to calculate the euclidean distance (formula (d) in article) in Arcgis. As a result
it is obtained 11 Raster layers which are imported in the next step.
1.3.- Reclassification and Poligonization of results step 2.1; Dissolve of features with equal score 
Run CA_Raster.R
1.4.- Intersect values of catchment area with silage maize plots
Run Intersect.R
First, it is imported the silage maize plots from IACS layers. Therefore they were identified through their codes and organized according to their years.
Secondly, it is imported the polygons froms step 2.2 and it is done the intersection. 
As a result, it is obtained the silage maize plots with the corresponding catchment area score.
2.-Calculation of the persistency score.
Run persistency.R
3.- Calculation of the livestock score.
Run livestock.R
4.- Calculation of the Farm size score.
Run Farm_size.R
5.- Final Score 
Run weighting_values.R
