function [total, interest] = loanCalc2(loans,capfreq,today,capdate,payment1,payment2)
todaynum = datenum(today);
capdate = datenum(capdate);
totalbal = 0;
startingbal = 0;
%% Deferment period
workdate = todaynum;
month = 365/12;
loannames = fieldnames(loans);
pay = [5 8 6 7 1 2 3 4];
paycount = 1;
leftoverpay = 0;
n = 0;
for i = 1:8;
    loans.(loannames{i}).workingbal = loans.(loannames{i}).bal;
    startingbal = startingbal+loans.(loannames{i}).bal;
end
while workdate < capdate
    paytemp = payment1;
    for i = 1:8
        apy = loans.(loannames{pay(i)}).apy;
        p0 = min(loans.(loannames{pay(i)}).prinstart,...
            loans.(loannames{pay(i)}).workingbal);
        interest = dailyInterest(p0,apy,month);
        bal = loans.(loannames{pay(i)}).workingbal + interest;
        if pay(paycount) == pay(i) && bal > 0
            bal = bal - paytemp;
            if bal <= 0
                paytemp = -bal;
                bal = 0;
                paycount = paycount + 1;
            end
        end
        loans.(loannames{pay(i)}).workingbal = bal;
    end
    workdate = workdate + month;
    n = n+1;
end

for i = 1:8
    disp(['Loan ' num2str(i) ' ' num2str(loans.(loannames{i}).workingbal)...
        ' ' num2str(loans.(loannames{i}).workingbal-...
        loans.(loannames{i}).bal)])
    totalbal = totalbal+loans.(loannames{i}).workingbal;
end

totalpayment = n.*payment1;
disp('Deferment Period')
disp(['Starting Balance: ' num2str(startingbal)])
disp(['Total Balance: ' num2str(totalbal)])
disp(['Total Paid: ' num2str(totalpayment)])
disp(['Net : ' num2str(totalbal+totalpayment)])
%% Repayment Period



disp('Repayment Period')

