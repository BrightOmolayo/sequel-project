Use [Workings];
Go
Select * from [Customer_Info$];

Select * from [dbo].[Account_Info$];

--Combining the two tables to one concise table
Select (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
from [Customer_Info$] c
join [Account_Info$] a on (a.CustomerId) = (c.CustomerId)
Group by (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
order by (c.CustomerId);

--To get the number of Customers who have a Credit card (They're also the active Members)
With Customer_Account_Info as ( Select TOP 100 PERCENT (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
from [Customer_Info$] c
join [Account_Info$] a on (a.CustomerId) = (c.CustomerId)
Group by (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
order by (c.CustomerId) )
Select *
from [Customer_Account_Info]
where HasCrCard = 'Yes'
order by (CustomerId);

--To get the number of Customers who have a Credit card and have exited the Organizations Services
With Customer_Account_Info as ( Select TOP 100 PERCENT (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
from [Customer_Info$] c
join [Account_Info$] a on (a.CustomerId) = (c.CustomerId)
Group by (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
order by (c.CustomerId) )
Select *
from [Customer_Account_Info]
where HasCrCard = 'Yes' and Exited = '1'
order by (CustomerId);

--Countries that use our products and the number of users per country
With Customer_Account_Info as ( Select TOP 100 PERCENT (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
from [Customer_Info$] c
join [Account_Info$] a on (a.CustomerId) = (c.CustomerId)
Group by (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
order by (c.CustomerId) )
Select Geography, count(Geography) as NumberOfUsers  
from [Customer_Account_Info]
group by Geography
order by (Geography);

--To get credit score of customers
With Customer_Account_Info as ( Select TOP 100 PERCENT (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
from [Customer_Info$] c
join [Account_Info$] a on (a.CustomerId) = (c.CustomerId)
Group by (c.CustomerId), (c.Surname), (c.CreditScore), (a.HasCrCard), (a.Tenure), (a.IsActiveMember), (a.Exited), (c.Geography), (c.Gender), (c.Age), (c.EstimatedSalary)
order by (c.CustomerId) )
select CustomerId, Surname, CreditScore, HasCrCard
from [Customer_Account_Info]
where CreditScore = '800-850' as Excellent
