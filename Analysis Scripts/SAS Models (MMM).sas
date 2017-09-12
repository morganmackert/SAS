*Total Abundance;
FILENAME REFFILE 'C:/Users/Morgan/Documents/ISU/Project/Previous Data/Data Files/New_Bees_Format_3.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=BEES;
	GETNAMES=YES;
RUN;

Proc Mixed Data = Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalAbundance = PlantDiversity Year / s ddfm = sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust = Tukey;
run;

*Total Species Richness;
proc mixed data = Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalSpeciesRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Inverse Simpson's Diversity;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model InvSimpDiv = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Total Genus Richness;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalGenusRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Total Family Richness;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalFamilyRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Non-Target Abundance;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model Non_Target = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Target Abundance;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model Target = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*******************************************************************************************
Now with another year!;

*Load the data;
proc import out = bees_MMM
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Combined full dataset condensed.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded correctly;
proc print data = bees_MMM;
run;

*Abundance - don't use this model! Use Katherine's;
Proc Mixed Data = Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalAbundance = PlantDiversity Year / s ddfm = sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust = Tukey;
run;

*Total Species Richness;
*Katherine: How to get this information without having to tabulate it manually?;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalSpeciesRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Inverse Simpson's Diversity;
*Is there a way to calculate this index for a group of data rather than doing it individually?;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model InvSimpDiv = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Total Genus Richness;
*Same question as with Total Species Richness;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalGenusRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Total Family Richness;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model TotalFamilyRichness = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Non-Target Abundance;
*How to write this model with plant diversity as a continuous variable?;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model Non_Target = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;

*Target Abundance;
*Same question as with Non-Target Abundance;
proc mixed data=Bees;
class Site PlantDiversity (ref='1') Year (ref='1');
model Target = PlantDiversity Year / s ddfm=sat; 
random Site;
repeated Year;
lsmeans PlantDiversity / diff adjust=Tukey;
run;