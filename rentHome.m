%Simulate renting a home until enough money has been saved for a purchase. Return the amount paid in rent and the amount of time needed to save 
%the desired downpayment amount given the parameters
function [amountPaid,monthsRequired] = rentHome(monthlyRent,additionalLivingCosts,downPaymentPercent,jointMonthlyIncome,homeValue,initialSavings,incomeTaxes)
dP_dollarAmnt = (downPaymentPercent/100)*homeValue;
totalSaved = initialSavings; 
savedMonthly = (jointMonthlyIncome*(1-incomeTaxes)) - (monthlyRent + additionalLivingCosts);
spentOnRent = 0;
while totalSaved < dP_dollarAmnt
  totalSaved = totalSaved + savedMonthly; 
  spentOnRent = spentOnRent + monthlyRent;
endwhile
amountPaid = spentOnRent; monthsRequired = spentOnRent/monthlyRent;