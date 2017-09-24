%The purpose of this script is to model various finance scenarios related to home buying to determine the most ideal course of action
%Meant to compare financial outcomes of buying a house at present time vs renting to save then purchasing home 
close all
clear all

%Input parameters (Set these) 

%Individual parameters (all dollar values as USD)
jointAnnualIncome = 155000; 
initialSavings = 50000; 
jointMonthlyIncome = jointAnnualIncome/12; 
additionalLivingCosts = 500; %Food, entertainment, gas, etc
incomeTaxes = .2; %Tax (will be used as a flat deduction from income)

%Home purchase parameters 
homeValue = 350000; %USD
interestRate = 3.5; %Percent annually 
yearsLoan = 15; %15 or 30 year loan
downPayment = initialSavings; %Assuming entire savings is used for a down payment
PrincipalMultiplier = 1; %Ratio of actual principal payment to required principal payment (must be a value greater than 1) 

%Renting parameters
monthlyRent = 1700; %Including utilities 
downPaymentPercent = 100; %Percent of downpayment to save prior to purchasing house 

%Home purchase scenario:
[interestVect,principalVect,savingsVect] = purchaseHome(homeValue,downPayment,yearsLoan,PrincipalMultiplier,interestRate,jointMonthlyIncome,incomeTaxes);
cumulativeInterest = cumsum(interestVect);
cumulativeSaved = cumsum(savingsVect); 
totalSaved = max(cumulativeSaved)
totalPaid_Interest = max(cumsum(interestVect)) 
totalPaid_Interest_taxAdjusted = totalPaid_Interest - totalSaved

%Rent then purchase scenario:
[rentPaid,monthsToSave] = rentHome(monthlyRent,additionalLivingCosts,downPaymentPercent,jointMonthlyIncome,homeValue,initialSavings,incomeTaxes);
downPayment_R = homeValue * downPaymentPercent;
[interestVect2,principalVect2] = purchaseHome(homeValue,downPayment_R,yearsLoan,PrincipalMultiplier,interestRate);
totalPaid_RentandInterest = rentPaid + max(cumsum(interestVect2)) %Total interest and rent paid (non equity accumulating value) prior to completely owning the house