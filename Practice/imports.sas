PROC IMPORT OUT= MYLIB.BeeIDs 
            DATAFILE= "C:\Users\Morgan\Documents\ISU\Project\Data\Bees\2
016\2016 Bee IDs.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="List$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
