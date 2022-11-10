*1a;

data calp_crime;
	infile '/home/u62368731/sasuser.v94/Homework/CP Crime Scrape 09232022.txt' missover
	firstobs = 2;
	input date :mmddyy10. time :TIME5. location & 22-71 incident & 87-200;
run;
*The date and time for the crime incident in row 1025 of my sas data set is 22864 for the date and 80040 for the time.
The location of this incident is Off Campus - Taqueria Express;

*1bi;

proc freq data = calp_crime;
	tables location;
run;

*1bii;
*The Cal Poly Police Department is the most prevalent location in the calp_crime data set;

*1biii;
*The location stored at the first observation when sorting by location is Zone2 West Of California Blvd.
This is the same as the very bottom value for location of my proc freq output;

*1biv;
*The incidents that took place at the Cal Poly Police Department are lost property, alarm, fraud, citizen assist, larcency-theft, 
follow-ups, and patrol activity.;


*2a;
data addr_easy;
	infile '/home/u62368731/sasuser.v94/Homework/Addresses Easier.txt';
	input name & $ 1-17 street & $ 21-44 cityZip & $ 48-73 phone & $ 77-91;
run;

proc print data = addr_easy;
run;

*2b;
data addr_text;
	infile '/home/u62368731/sasuser.v94/Homework/Addresses Easier.txt';
	input name & $ 1-17 street & $ 21-44 cityZip & $ 48-73;
run;

proc print data = addr_text;
run;
*This data set is harder to read in because the end of the line for each observation does not stop at the same column 
as with the previous data set. This data set has the cityZip variable end at different columns for each observation.;

*2c;

data addr_diff;
	infile '/home/u62368731/sasuser.v94/Homework/Addresses Difficult.txt'
	obs = 15;
	input name & $ 1-17 
	/ street & $ 1-24 
	/ cityZip & $ 1-26;
run;

proc print data = addr_diff;
run;


*3;
 
data test; 
  input x; 
  datalines; 
1
2
3
4 
5 
6 
7 
8 
9 
10 
  ; 
run; 

*4;

data test1; 
 input x 5.1; 
 datalines; 
124.2 
132.8 
; 
run; 

data test2; 
 input x 5.; 
 datalines; 
124.2 
132.8 
; 
run; 

data test3; 
 input x; 
 datalines; 
124.2 
132.8 
; 
run; 

data test4; 
 input x 5.1; 
 datalines; 
1242 
1328 
; 
run;
*From these data tests, I learned that numbers with decimal values do not need to be read in with a w.d informat.
They can still be read in using a normal numeric variable type, such as x.;

*HW 2B;
*1a;

data cannaCntrl;
	infile '/home/u62368731/sasuser.v94/Homework/Cannabis Control License Search 080819.csv'
	firstobs = 4 DLM = ',' DSD;
	input License :$20. Type :$60. Owner :$100. Contact :$200. Structure :$30. Address :$80. Status :$11. 
	Issue_date :ANYDTDTE12. Exp_date :ANYDTDTE12. Activities :$150. Use :$10.;
run;


*1b;

proc freq data = canncntrl;
	tables Type Status Use;
run;
*9.71% of cannibis licenses have type "Cannabis-Retailer License";
*42.43% of cannibis licenses are "Active";
*132 records have a missing value for Use;


*2a;

data candies;
	infile '/home/u62368731/sasuser.v94/Homework/candy-data.csv'
	firstobs = 2 DLM = ',';
	input name :$30. chocolate fruity caramel peanutyalmondy nougat crispedricewafer hard 
	bar pluribus sugarpercent pricepercent winpercent;
run;

*2b;

proc freq data = candies;
	tables chocolate;
run;
*43.53% of the candy in this data set is chocolatey;

proc means data = candies;
	var chocolate;
run;
*The proc means table for chocolate gives a value of 0.4353 for candy that is chocolatey, confirming the above percentage from the proc freq table;

*2c;

proc print data = candies label;
	var name winpercent;
	label name = 'Candy Name' 
		winpercent = 'Win Percent';
run;


*3a;

data cpCrimes;
	infile '/home/u62368731/sasuser.v94/Homework/CP Crime Scrape 20220927.csv'
	DLM = ',' DSD firstobs = 2;
	input time_of_occurence :ANYDTDTE15. location :$30. disposition :$30. incident :$80.;
run;

*3b;
*The 50th record SAS date is 22913. The actual date is 9/25/2022;

*3c;

proc freq data = cpCrimes;
	tables disposition;
run;
*The number of arrests made in the 1,320 total incidents is 1;

*3d;

libname sasloc3 '/home/u62368731/sasuser.v94/lectures/Permanent SAS Datasets'; 
data sasloc3.cpCrimes;
	infile '/home/u62368731/sasuser.v94/Homework/CP Crime Scrape 20220927.csv'
	DLM = ',' DSD firstobs = 2;
	input time_of_occurence :ANYDTDTE15. location :$30. disposition :$30. incident :$80.;
run;

*3e;

proc import datafile = '/home/u62368731/sasuser.v94/Homework/CP Crime Scrape 20220927.xlsx'
OUT = cpCrimes2
	DBMS = XLSX REPLACE;
run;
*The main difference between this data set and the one created in part 3a, is that the proc import statement reads the date and time of occurence as the exact date and time
shown in the data file, rather than the number of days since January 1st, 1960.;


*4a;

data mhic;
	infile '/home/u62368731/sasuser.v94/Homework/ACS 2019 HH Income.csv'
	DLM = ',' DSD firstobs = 5;
	input ID :$15. location :$40. tot_households moe_tot_households median_income moe_med_income mean_income moe_mean_income;
run;

*4b;

data mhic;
	infile '/home/u62368731/sasuser.v94/Homework/ACS 2019 HH Income.csv'
	DLM = ',' DSD firstobs = 5;
	input ID :$15. location :$40. tot_households moe_tot_households median_income moe_med_income mean_income moe_mean_income;
	median_income_lower = median_income - moe_med_income;
	median_income_upper = median_income + moe_med_income;
run;
*?;

*4c;

proc means data = mhic;
	var median_income mean_income;
run;


*Average median household income for all counties in the US is $64,960.26. Average mean household income for all counties in the US is $85,696.25.
The average mean income is larger because the mean may be affected by outliers in the data, while the median is not. Most likely, the data is skewed 
to the right, causing a higher mean, but a lower median;

*4d;
*The county with the highest median income is Loudoun County, Virginia. The county with the lowest median income is Apache County, Arizona;
