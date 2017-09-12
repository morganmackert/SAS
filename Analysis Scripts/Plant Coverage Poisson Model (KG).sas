** AES Statistical Consulting
** Client: Morgan Mackert
** SAS code for Poisson Mixed Model with plant coverage data;

* Load in the data;
proc import out = plantcoverage
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/PlantCoverage.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

data  plantcoverage_MMM;
	set plantcoverage_MMM;
	log_Total_Bees = log(Total_Bees + 1);
run;

proc sort data = plantcoverage;
	by Total_Bees;
run;

* Print the data to make sure it loaded in correctly;
proc print data = plantcoverage;
run;
   
    

* I've changed the the way all of these models calculate the degrees of freedom to the sattherwaite method,
* which is more trustworthy for models with random effects in them.;

* Poisson mixed effects model with average plant coverage as a covariate;
proc glimmix data = plantcoverage plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;

* The model fits with no problems in SAS! However, the residual plot does not look great, and
* the value of Gener. Chi-Square / DF suggests that there is overdispersion.;

* Negative binomial mixed effects model with average plant coverage as a covariate -
* this model is fit as a way of dealing with overdispersion;
proc glimmix data = plantcoverage plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl diff;
run;

* The residual plot looks much better!;

* I also wanted to see what would happen if I included the random effect for each observation in the model. The 
* residual plot does not look very good, so I think it is better to use the negative binomial model.;
proc glimmix data = plantcoverage plots = studentpanel;
      class Sampling_Day Site A;
      model Total_Bees = Average_Coverage|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site A;
      lsmeans Sampling_Day / cl;
run;

**********************************************************************************************
*Now let's try it with more years!!!

* Load in the data;
proc import out = plantcoverage_MMM
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/PlantCoverage_MMM.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

* Print the data to make sure it loaded in correctly;
proc print data = plantcoverage_MMM;
run;
    
* I've changed the the way all of these models calculate the degrees of freedom to the sattherwaite method,
* which is more trustworthy for models with random effects in them.;

* Poisson mixed effects model with average plant coverage as a covariate;
proc glimmix data = plantcoverage_MMM plots = studentpanel;
      class Sampling_Day Site Year;
      model Total_Bees = Average_Coverage|Sampling_Day|Year / solution link = log dist = poisson ddfm = satterthwaite;
      random Site Site*Sampling_Day;
      lsmeans Sampling_Day / cl;
run;

*Let's do a mixed model with log transformed bee numbers;
Proc Mixed Data = plantcoverage_MMM plots = studentpanel;
class Site Year Sampling_Day;
model log_Total_Bees = Average_Coverage|Sampling_Day|Year / s ddfm = sat; 
random Site Site*Sampling_Day;
run;

* The model fits with no problems in SAS! However, the residual plot does not look great, and
* the value of Gener. Chi-Square / DF suggests that there is overdispersion.;

* Negative binomial mixed effects model with average plant coverage as a covariate -
* this model is fit as a way of dealing with overdispersion;
proc glimmix data = plantcoverage_MMM plots = studentpanel;
      class Sampling_Day Site Year;
      model Total_Bees = Average_Coverage|Sampling_Day|Year / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site Site*Sampling_Day;
      lsmeans Sampling_Day / cl diff;
run;

*This model doesn't converge...;

*This model also doesn't converge :( ;
proc glimmix data = plantcoverage_MMM plots = studentpanel;
      class Sampling_Day Site A Year;
      model Total_Bees = Average_Coverage|Sampling_Day|Year / solution link = log dist = poisson ddfm = satterthwaite;
      random Site A Site*Sampling_Day;
      lsmeans Sampling_Day / cl;
run;

*Katherine: What should I do/try next?