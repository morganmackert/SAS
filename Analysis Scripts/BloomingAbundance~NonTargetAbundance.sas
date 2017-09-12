*Modeling the influence of blooming forb coverage on non-target abundance;

*Year 1
*Load in the data;
proc import out = nontarget_year1
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/full/Condensed_Year1.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = nontarget_year1;
run;

*Mixed effects model;
proc glimmix data = nontarget_year1 plots = studentpanel;
      class Site;
      model NonTarget = PercentCover / dist = poisson s ddfm = sat;
      random Site;
run;

*************************************************************************************
*Year 2
*Load in the data;
proc import out = nontarget_year2
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/full/Condensed_Year2.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = nontarget_year2;
run;

*Mixed effects model;
proc glimmix data = nontarget_year2 plots = studentpanel;
      class Site;
      model NonTarget = PercentCover / dist = poisson s ddfm = sat;
      random Site;
run;

*************************************************************************************
*Year 3
*Load in the data;
proc import out = nontarget_year3
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/full/Condensed_Year3.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = nontarget_year3;
run;

*Mixed effects model;
proc glimmix data = nontarget_year3 plots = studentpanel;
      class Site;
      model NonTarget = PercentCover / dist = poisson s ddfm = sat;
      random Site;
run;

*************************************************************************************
*Years 1 and 2
*Load in the data;
proc import out = nontarget_years12
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/full/Condensed_Years12.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = nontarget_years12;
run;

*Species richness mixed effects model;
proc glimmix data = nontarget_years12 plots = studentpanel;
      class Site Year;
      model NonTarget = PercentCover|Year / dist = poisson s ddfm = sat;
      random Site;
run;

*************************************************************************************
*Years 1, 2, and 3
*Load in the data;
proc import out = nontarget_years123
			datafile = 'C:/Users/Morgan/Documents/ISU/Project/SAS/Data Files/full/Condensed_Years123.xlsx'
			dbms = xlsx
			replace;
	getnames = yes;
	datarow = 2;
run;

*Print the data to make sure it loaded okay;
proc print data = nontarget_years123;
run;

*Species richness mixed effects model;
proc glimmix data = nontarget_years123 plots = studentpanel;
      class Site Year;
      model NonTarget = PercentCover|Year / dist = poisson s ddfm = sat;
      random Site;
run;
