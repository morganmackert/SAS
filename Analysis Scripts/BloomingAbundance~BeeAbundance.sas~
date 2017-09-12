*Modeling the influence of blooming forb coverage on total bee abundance;

*Year 1
*Load in the data;
proc import out = plantcoverage_year1
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/plants/PlantCoverage_Year1.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = plantcoverage_year1;
run;

*Poisson mixed effects model with average plant coverage as a covariate;
proc glimmix data = plantcoverage_year1 plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;
*The model fits with no problems in SAS! However, the residual plot doesn’t look great, and 
the value of Gener. Chi-Square / DF suggests that there is overdispersion.
*Try fitting a negative binomial model:

*Negative binomial mixed effects model with average plant coverage as a covariate -
*(this model is fit as a way of dealing with overdispersion);
proc glimmix data = plantcoverage_year1 plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl diff;
run;
*No more overdispersion and the residual plot looks great!;

*Let’s see what happens if we include the random effect for each observation in the model…;
proc glimmix data = plantcoverage_year1 plots = studentpanel;
      class Sampling_Day Site A;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site A;
      lsmeans Sampling_Day / cl;
run;
*The residual plot looks scary, so best to use the negative binomial model;

*************************************************************************************
*Year 2
*Load in the data;
proc import out = plantcoverage_year2
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/plants/PlantCoverage_Year2.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = plantcoverage_year2;
run;

*Negative binomial mixed effects model with average plant coverage as a covariate;
proc glimmix data = plantcoverage_year2 plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl diff;
run;
*Doesn't converge, bummer;
*Let's try the Poisson distribution again;

proc glimmix data = plantcoverage_year2 plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;
*Still crazy overdispersed;
*Try adding each observation as a random effect;
proc glimmix data = plantcoverage_year2 plots = studentpanel;
      class Sampling_Day Site A;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site A;
      lsmeans Sampling_Day / cl;
run;
*Residual plot is garbage;

*Let's try some log stuff
*log transform the “Total_Bees” variable, no need to add +1 because there are no zeroes;
data  plantcoverage_year2;
	set plantcoverage_year2;
	log_Total_Bees = log(Total_Bees);
run;

*Sort it by log_Total_Bees value;
proc sort data = plantcoverage_year2;
	by log_Total_Bees;
run;

*Print the data to make sure SAS included the new variable in correctly;
proc print data = plantcoverage_year2;
run;

*Mixed model with the log transformed bee numbers;
Proc Mixed Data = plantcoverage_year2 plots = studentpanel;
class Site Year Sampling_Day;
model log_Total_Bees = Average_Coverage|Sampling_Day|Year / s ddfm = sat; 
random Site Site*Sampling_Day;
run;

*************************************************************************************
*Year 3
*Load in the data;
proc import out = plantcoverage_year3
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/plants/PlantCoverage_Year3.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = plantcoverage_year3;
run;

*Negative binomial mixed effects model with average plant coverage as a covariate;
proc glimmix data = plantcoverage_year3 plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl diff;
run;

*****************************************************************************
*Years 1 and 2
*Load in the data;
proc import out = plantcoverage_years12
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/plants/PlantCoverage_Years12.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = plantcoverage_years12;
run;

*log transform the “Total_Bees” variable, no need to add +1 because there are no zeroes;
data  plantcoverage_years12;
	set plantcoverage_years12;
	log_Total_Bees = log(Total_Bees);
run;

*Sort it by log_Total_Bees value;
proc sort data = plantcoverage_years12;
	by log_Total_Bees;
run;
*Print the data to make sure SAS included the new variable in correctly;
proc print data = plantcoverage_years12;
run;

*Mixed model with the log transformed bee numbers;
Proc Mixed Data = plantcoverage_years12 plots = studentpanel;
class Site Year Sampling_Day;
model log_Total_Bees = Average_Coverage|Sampling_Day|Year / s ddfm = sat; 
random Site Site*Sampling_Day;
run;
*Converges, no overdispersion, and residual plot looks okay!;

*****************************************************************************
*Years 1, 2, and 3
*Load in the data;
proc import out = plantcoverage_years123
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/plants/PlantCoverage_Years123.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = plantcoverage_years123;
run;

*log+1 transform the “Total_Bees” variable (need the +1 in this case because there are zeroes in the data);
data  plantcoverage_years123;
	set plantcoverage_years123;
	log_Total_Bees = log(Total_Bees + 1);
run;

*Sort it by log_Total_Bees value;
proc sort data = plantcoverage_years123;
	by log_Total_Bees;
run;
*Print the data to make sure SAS included the new variable in correctly;
proc print data = plantcoverage_years123;
run;

*Mixed model with the log transformed bee numbers;
Proc Mixed Data = plantcoverage_years123 plots = studentpanel;
class Site Year Sampling_Day;
model log_Total_Bees = Average_Coverage|Sampling_Day|Year / s ddfm = sat; 
random Site Site*Sampling_Day;
run;
*Converges, no overdispersion, and residual plot looks okay!
