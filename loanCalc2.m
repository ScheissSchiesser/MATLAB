function [total, interest] = loanCalc2(loans,today,capdate,payment1,payment2,payorder)
todaynum = datenum(today);
capdate = datenum(capdate);
totalbal = 0;
startingbal = 0;
%% Deferment period
workdate = todaynum;
month = 365.25/12;
loannames = fieldnames(loans);
pay = payorder;
paycount = 1;
n = 0;
for i = 1:8;
    loans.(loannames{i}).workingbal = loans.(loannames{i}).bal;
    startingbal = startingbal+loans.(loannames{i}).bal;
end

% Pay only 1 loan account based on loan order
while workdate < capdate
    paytemp = payment1;
    for i = 1:8
        if loans.(loannames{pay(i)}).sub == 0
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
    end
    workdate = workdate + month;
    n = n+1;
end

for i = 1:8
%     disp(['Loan ' num2str(i) ' ' num2str(loans.(loannames{i}).workingbal)...
%         ' ' num2str(loans.(loannames{i}).workingbal-...
%         loans.(loannames{i}).bal)])
    totalbal = totalbal+loans.(loannames{i}).workingbal;
end

totalpayment = n.*payment1;
temptotal = 0;
% for i = 1:8
%     temptotal = temptotal + (loans.(loannames{i}).workingbal-...
%         loans.(loannames{i}).prinstart);
%     loans.(loannames{i}).workingbal = loans.(loannames{i}).prinstart;
%     totalpayment = temptotal;
% end
disp('Deferment Period')
disp(['Starting Balance: ' num2str(startingbal)])
disp(['Total Balance: ' num2str(totalbal)])
disp(['Total Paid: ' num2str(totalpayment)])
disp(['Net : ' num2str(totalbal+totalpayment)])
%% Repayment Period
paycount = 1;
n = 0;

while totalbal > 0;
    paytemp = payment2;
    totalbal = 0;
%     Pay All interest
    for i = 1:8
        apy = loans.(loannames{pay(i)}).apy;
        bal = loans.(loannames{pay(i)}).workingbal;
        interest = dailyInterest(bal,apy,month);
        paytemp = paytemp - interest;
    end
    
%     Use leftover money for paying down principal based on order
    for i = 1:8
        name = loannames{pay(i)};
        bal = loans.(name).workingbal;
        if bal == 0 && pay(paycount) == pay(i);
            paycount = paycount + 1;
        end
        if pay(paycount) == pay(i) && bal > 0
            bal = bal - paytemp;
            if bal <= 0
                paytemp = -bal;
                bal = 0;
                paycount = paycount + 1;
            end
        end
        loans.(loannames{pay(i)}).workingbal = bal;
        totalbal = totalbal+bal;
    end
    workdate = workdate + month;
    n = n+1;
end
findate = datestr(workdate-month);
totalpayment =totalpayment + n.*payment2;
total = totalpayment;
disp('Repayment Period')
disp(['Time of repayment: ' num2str((workdate-month-capdate)./365.25,3)])
disp(findate)
disp(['Total Paid ' num2str(totalpayment)])

