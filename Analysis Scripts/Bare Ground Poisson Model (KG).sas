** AES Statistical Consulting
** Client: Morgan Mackert
** SAS code for Poisson Mixed Model with bareground data;

*Read in data
*Not sure if this code works, but I'm leaving it in just in case it does;

FILENAME REFFILE 'C:/Users/Morgan/Documents/ISU/Project/SAS/bareground_data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=csv
	OUT=bareground;
	GETNAMES=yes;
	
RUN;

*Load in the data
*Katherine: Can you explain what "datarow = 2" does?;

proc import out = bareground
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/bareground_data.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

* Print the data to make sure it loaded in correctly;
proc print data = bareground;
run;

* Again, I've changed the the way all of these models calculate the degrees of freedom to the sattherwaite method,
* which is more trustworthy for models with random effects in them.;

* Poisson mixed effects model with average bare ground as a covariate
*Katherine: Can you explain the nomenclature of SAS? What does | mean?;

proc glimmix data = bareground plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;

* The value of Gener. Chi-Square / DF suggests that there is overdispersion.
*Katherine: Where is the line drawn for overdisperal/non-overdispersal?
* Let's try fitting a negative binomial model;

* Negative binomial mixed effects model with average bare ground as a covariate;
proc glimmix data = bareground plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;

* This model does not converge. Instead, let's try fitting a model with a random effect
* for each individual observation (like we did in R).;

* Poisson mixed effects model with average bare ground as a covariate and a random effect
* for each observation;
proc glimmix data = bareground plots = studentpanel;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site Sample;
      lsmeans Sampling_Day / cl;
run;

* This model does not have a great looking residual plot. 

* This model tries including site as a fixed effect and fits the interaction between site and average_bareground,
* but the residuals do not look very good.;
proc glimmix data = bareground plots = studentpanel;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround Sampling_Day Site Site*Average_BareGround / solution link=log dist = poisson ddfm=satterthwaite;
      random Sample;
      nloptions maxiter = 100;
      lsmeans Sampling_Day/ cl;
run;

* This model takes out the observations with an average_bareground greater than 30 to see if that makes the residual plot better. 
* It also includes a random intercept and random slope to see if that helps. However, the residual plot still does not look good.;
proc glimmix data = bareground plots = studentpanel;
      class Sampling_Day Site Sample;
      where Average_BareGround < 30;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link=log dist = poisson ddfm=satterthwaite;
      random Intercept Average_BareGround / Subject = Site type = un;
      random Sample;
      nloptions maxiter = 100;
      lsmeans Sampling_Day/ cl;
run;

* This model tries to fit the model using a different type of estimation process. However, the residual plot still does not look good.;
proc glimmix data = bareground plots = studentpanel method = LAPLACE;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link=log dist = poisson;
      random intercept sample / subject = site;
      lsmeans Sampling_Day/ cl;
run;

* From fitting all of these models and not finding a good fitting model, it seems that average ground percentage 
* is not a good predictor of the total number of bees.



*Let's try this again with three years of data;
FILENAME REFFILE 'C:/Users/Morgan/Documents/ISU/Project/SAS/bareground_data_MMM.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=csv
	OUT=bareground_MMM;
	GETNAMES=yes;
	
RUN;

* Load in the data;
proc import out = bareground_MMM
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/bareground_data_MMM.csv'
			dbms = csv
			replace;
	getnames = yes;
	datarow = 2;
run;

* Print the data to make sure it loaded in correctly;
proc print data = bareground_MMM;
run;

**Run all of the same models
* Poisson mixed effects model with average bare ground as a covariate;
proc glimmix data = bareground_MMM plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;

*Still overdispersed
* Let's try fitting a negative binomial model;

* Negative binomial mixed effects model with average bare ground as a covariate;
proc glimmix data = bareground_MMM plots = studentpanel;
      class Sampling_Day Site;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = negbinomial ddfm = satterthwaite;
      random Site;
      lsmeans Sampling_Day / cl;
run;

*Still doesn't converge

* Poisson mixed effects model with average bare ground as a covariate and a random effect
* for each observation;
proc glimmix data = bareground_MMM plots = studentpanel;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link = log dist = poisson ddfm = satterthwaite;
      random Site Sample;
      lsmeans Sampling_Day / cl;
run;

*Scary residual plot;

* This model tries including site as a fixed effect and fits the interaction between site and average_bareground,
* but the residuals do not look very good.;
proc glimmix data = bareground_MMM plots = studentpanel;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround Sampling_Day Site Site*Average_BareGround / solution link=log dist = poisson ddfm=satterthwaite;
      random Sample;
      nloptions maxiter = 100;
      lsmeans Sampling_Day/ cl;
run;
*More scary residual plots

* This model takes out the observations with an average_bareground greater than 30 to see if that makes the residual plot better. 
* It also includes a random intercept and random slope to see if that helps. However, the residual plot still does not look good.;
proc glimmix data = bareground_MMM plots = studentpanel;
      class Sampling_Day Site Sample;
      where Average_BareGround < 30;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link=log dist = poisson ddfm=satterthwaite;
      random Intercept Average_BareGround / Subject = Site type = un;
      random Sample;
      nloptions maxiter = 100;
      lsmeans Sampling_Day/ cl;
run;

* This model tries to fit the model using a different type of estimation process. However, the residual plot still does not look good.;
proc glimmix data = bareground_MMM plots = studentpanel method = LAPLACE;
      class Sampling_Day Site Sample;
      model Total_Bees = Average_BareGround|Sampling_Day / solution link=log dist = poisson;
      random intercept sample / subject = site;
      lsmeans Sampling_Day/ cl;
run;

* From fitting all of these models and not finding a good fitting model, it seems that average ground percentage 
* is not a good predictor of the total number of bees.