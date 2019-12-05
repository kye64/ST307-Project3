*Project 3
Kevin Ye
December 5, 2019;

*1.;
libname project3 "\\wolftech.ad.ncsu.edu\cos\stat\Redirect\kye\Desktop\Project 3";

*2.;
data project3.winequality;
	infile "\\wolftech.ad.ncsu.edu\cos\stat\Redirect\kye\Desktop\Project 3.\winequality.csv" dsd firstobs = 2;
	input type sugar freeSO2 totalSO2 density pH alcohol quality;
	if (type = 1) then color = "red";
	else color = "white";
	drop type;
run;
*3 ;
*a. The assumptions of normality does not hold for the paired data as their q-q plot shows obvious horizontal deviation from the projected line.;
*b. The p-value of the t test is 0.34 which suggests that we failed to reject our null hypothesis test of alpha = 0.05. We do not have enough evidence to suggest that the mean difference between totalSO2 and freeSO2 is greater than 85. ;
*c. We are 95% confident that the true mean difference between totalSO2 and freeSO2 is between the interval (44.6551,46.2177).;
proc ttest data = project3.winequality h0 = 85 alpha = 0.05 sides = U;
	paired  totalSO2 *freeSO2 ;
run;

*4.;
*a. The p-value of our two sample t-test is <0.0001 which means we reject our null hypothesis. We have enough envidence to suggest that the mean difference of quality between red wine and white wine is not equal to zero.
b. White wine is qualitatively better than red wine as the mean of white wine is greater than red wine. An examination of the quality histograms between the two wine types shows that white wine is skewed to the left more than red wine.; 
proc ttest data = project3.winequality h0 = 0 alpha = 0.05;
	class color;
	var quality;
run;

*5.;
*a. alcohol has the highest correlation coefficient with wine quality.;
proc corr data = project3.winequality;
	var sugar pH quality alcohol;
run;

*6;
*a. Adding sugar has an effect on the quality of wine because we reject the null hypothesis test that sugar has no effect with a p-value of 0.0029.
sugar has an negative effect on quality.
b. y = 5.855 -0.006787x.;
proc glm data = project3.winequality plots = all;
	model quality = sugar;
run;

*7.;
*a. The prediction interval for quality is (3.878,6.884) for a wine with the variable values: sugar = 2.5, freeSO2 = 17, totalSO2 = 42, density = 0.998, PH = 3.4, alcohol = 9.6.;
*b. The pH variable is not useful in the model as suggested by its p-value of 0.35.;
*Missihng Y Trick;
data temp;
input sugar freeSO2 totalSO2 density pH alcohol quality;
	datalines;
	2.5 17 42 0.998 3.4 9.6 .
;
*Appends to data set project3.winequality;
proc datasets;
	append base = project3.winequality data =temp;
run; 
proc glm data = project3.winequality plots = all;
	model quality = sugar freeSO2 totalSO2 density pH alcohol /cli;
run;
quit;
