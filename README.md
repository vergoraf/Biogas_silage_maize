# Biogas_silage_maize

Here it is presented the scripts that were used to calculate the likelihood of silage maize for biogas production.

![Screenshot](R_steps.png)
The steps are the following: <br />
1.- Calculation of the catchment area <br />
1.1.- Import Biogas plants data. This dataset was previously processed, identifying biogas complex and filtering the biogas satellite plants. <br />
Run Import_biogas_data.R <br />
1.2.- Definition of the buffer through the radius <br />
Run Defining_buffer.R <br />
Result is a polygon layer containing the buffers. This is processed to calculate the euclidean distance (formula (d) in article) in Arcgis. As a result
it is obtained 11 Raster layers which are imported in the next step. <br />
1.3.- Reclassification and Poligonization of results step 2.1; Dissolve of features with equal score <br />
Run CA_Raster.R <br />
1.4.- Intersect values of catchment area with silage maize plots <br />
Run Intersect.R <br />
First, it is imported the silage maize plots from IACS layers. Therefore they were identified through their codes and organized according to their years.
Secondly, it is imported the polygons froms step 2.2 and it is done the intersection. 
As a result, it is obtained the silage maize plots with the corresponding catchment area score. <br />
2.-Calculation of the persistency score. <br />
Run persistency.R <br />
3.- Calculation of the livestock score. <br />
Run livestock.R <br />
4.- Calculation of the Farm size score. <br />
Run Farm_size.R <br />
5.- Final Score  <br />
Run weighting_values.R <br />
How it looks the procedure internly:
![Screenshot](Intern_steps.png)
