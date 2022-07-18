--queries to display data
Select * from card_holder;
Select * from credit_card;
Select * from merchant;
Select * from merchant_category;
Select * from transaction;

--create a VIEW from tables 'card_holder' and 'transaction' counting total number of transactions per cardholder
CREATE VIEW cardholder_transaction AS
Select a.name, count(amount) as num_transactions, sum(amount)as total_amount
from card_holder a
INNER JOIN credit_card b ON a.id = b.cardholder_id
INNER JOIN transaction c ON b.card = c.card
group by a.name
order by a.name;

--display view of 'cardholder_transaction'
select * from cardholder_transaction

-- Create a VIEW by joining all the 5 tables and counting transactions less than $2
CREATE VIEW fraud_transactions AS
Select a.name as cardholder_name, b.card, c.amount, d.name as merchant_name, e.name as merchant_category, count(c.amount) as num_transactions
from card_holder a
INNER JOIN credit_card b ON a.id = b.cardholder_id
INNER JOIN transaction c ON b.card = c.card
INNER JOIN merchant d ON c.id_merchant = d.id
INNER JOIN merchant_category e ON d.id_merchant_category = e.id
group by a.name, b.card, c.amount, d.name, e.name
having c.amount < 2
order by a.name;

--display view of 'fraud_transactions'
select * from fraud_transactions

-- Query 'fraud_transactions' VIEW to count the suspicious transactions by merchant_category
SELECT cardholder_name, merchant_category, count(num_transactions)
FROM fraud_transactions
group by cardholder_name,merchant_category;

--Create a VIEW from the table transaction to list the top 100 transactions beween 7 am and 9 am
CREATE VIEW Top100_transactions AS
Select id, CAST(date as TIME),amount
from transaction
where CAST(date as TIME) BETWEEN '07:00:00' AND '09:00:00'
order by amount desc
LIMIT 100;

--display view of 'Top 100 transactions' between 7am-9am
SELECT * FROM Top100_transactions;

-- Create a VIEW from table 'transaction' to list the top 100 transactions during rest of the day
CREATE VIEW Top100_transactions_2 AS
Select id, CAST(date as TIME),amount
from transaction
where CAST(date as TIME) NOT BETWEEN '07:00:00' AND '09:00:00'
order by amount desc
LIMIT 100;

--display view of 'Top 100 transactions' NOT between 7am-9am
SELECT * FROM Top100_transactions_2;

-- What are the top 5 merchants prone to being hacked using small transactions?-------might be wrong

CREATE VIEW Top5_merchants AS
Select a.name, b.amount, count(*) as num_transactions
from merchant a
JOIN transaction b ON a.id = b.id_merchant
group by a.name, b.amount
having b.amount < 2
order by b.amount asc
;


--display Top5_merchants most prone to being hacked
Select name, sum(amount)
from Top5_merchants
group by name
order by sum(amount) asc
LIMIT 5;
