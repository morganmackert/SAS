   /*************************************/
   /* read a data set and subset        */
   /*************************************/
data canada;
   set mylib.productsales;
   if country='CANADA';
run;

   /*************************************/
   /* read a data set, subset,  and     */
   /* create new variables              */
   /*************************************/
data canada2;
   set mylib.productsales;
   if country='CANADA';
   Total_Variance=actual-predict;
   Forecast=actual*1.15;
run;
   /*************************************/
   /* read a subset using direct access */
   /*************************************/
data product_sample;
   do obsnum=1 to 100 by 2;
      set mylib.productsales point=obsnum;
      if _error_ then abort;
      output;
   end;
   stop;
run;
