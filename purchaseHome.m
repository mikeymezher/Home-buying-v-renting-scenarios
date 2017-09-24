%Simulate the purchase of a home, return a vector of interest and principal payments made monthly given the input parameters
function [interestPaid,principalPaid,taxDollarsSaved] = purchaseHome(homeValue,downPayment,yearsLoan,PrincipalMultiplier,interestRate,monthlyIncome,incomeTaxes,maxPayments,otherExpenses)
%Home purchase scenario: 

%Calculate base parameters
totalPayments = yearsLoan * 12; 
totalLoan = homeValue - downPayment;
remainderLoan = totalLoan; 
c = interestRate/(12*100);
monthlyPayments = (totalLoan*(c*((1 + c)^totalPayments)))/(((1 + c)^totalPayments) - 1);
hypPaid = 0; %Hypothesized principal payment (used to determine interest function)
interestVect = zeros(1,1); LoanVect = zeros(1,1); hypPayVect = zeros(1,1); PayVect = zeros(1,1);interestVect_real = zeros(1,1); LoanVect_real = zeros(1,1); savingsVect = zeros(1,1); 

%Calculating hypothetical principal and interest payments 
while remainderLoan>0
  interestPayment = (remainderLoan - hypPaid)*(interestRate/(12*100));
  hypPaid = monthlyPayments-interestPayment;
  remainderLoan = remainderLoan - hypPaid ;
  interestVect = horzcat(interestVect,interestPayment); LoanVect = horzcat(LoanVect,remainderLoan); hypPayVect = horzcat(hypPayVect,hypPaid); 
endwhile
%Calculating actual principal and interest payments (interest payments remain constant, but are effected as a threshold (once principal is paid off, interest payments cease))
remainderLoan_real = totalLoan; remainderLoan = totalLoan;
hypPaid_real = 0; 
while remainderLoan_real>0
  interestPayment_real = (remainderLoan - hypPaid_real)*(interestRate/(12*100));
  hypPaid_real = monthlyPayments-interestPayment_real;
  actualPaid = hypPaid_real*PrincipalMultiplier;
  if maxPayments == 1
    actualPaid = (monthlyIncome*(1-incomeTaxes)) - (interestPayment_real + otherExpenses); 
  endif
  remainderLoan_real = remainderLoan_real - actualPaid ; remainderLoan = remainderLoan - hypPaid_real; 
  interestVect_real = horzcat(interestVect_real,interestPayment_real); LoanVect_real = horzcat(LoanVect_real,remainderLoan_real); PayVect = horzcat(PayVect,actualPaid); 
  %Accounting for money saved due to tax deductions on interest payments
  initTaxesPaid = monthlyIncome * incomeTaxes; 
  taxableIncome = monthlyIncome - interestPayment_real;
  taxesPaid = taxableIncome * incomeTaxes; 
  savings = initTaxesPaid - taxesPaid; 
  savingsVect = horzcat(savingsVect,savings); %Savings attributed to tax deductions on interest payments 
  endwhile

figure();
timeVectHyp = 0:1:size(hypPayVect,2)-1;
timeVectReal = 0:1:size(PayVect,2)-1; 
hold on; 
plot(timeVectHyp,hypPayVect,'r');
plot(timeVectHyp,interestVect,'b');
title('Principal vs Interest Payments (Hypothesized)'); xlabel('Month'); ylabel('Payment (USD)'); legend('Principal','Interest');
figure(); hold on ; 
plot(timeVectReal,PayVect,'r');
plot(timeVectReal,interestVect_real,'b');
title('Principal vs Interest Payments (Actual)'); xlabel('Month'); ylabel('Payment (USD)'); legend('Principal','Interest'); 

interestPaid = interestVect_real; principalPaid = PayVect; taxDollarsSaved = savingsVect; 

return