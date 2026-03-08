use ords;
##check raw data
select * from payment;
create table payment_staaging like  payment;
 insert payment_staaging select * from payment;
 select * from payment_staaging;
 
 SELECT *
FROM payment_staaging
WHERE step IS NULL
   OR type IS NULL
   OR amount IS NULL
   OR nameOrig IS NULL
   OR nameDest IS NULL;
 -/*
 INSIGHT
 No critical missing values were found in key transaction fields such as transaction type, amount, sender 
 account, or receiver account, indicating the dataset is structurally complete for further analysis.*/
   
SELECT *
FROM payment_staaging
WHERE amount < 0;

/*Insight:
No negative transaction amounts were detected, confirming that transaction values follow expected financial constraints
*/

SELECT step, type, amount, nameOrig, nameDest, COUNT(*)
FROM payment_staaging
GROUP BY step, type, amount, nameOrig, nameDest
HAVING COUNT(*) > 1;
/*
Insight:
Duplicate transaction records were evaluated to ensure transaction uniqueness. No significant duplication patterns were detected.
*/
SELECT *
FROM payment_staaging
WHERE oldbalanceDest - amount <> newbalanceDest
LIMIT 10;
/*
Insight:
A small subset of transactions with balance inconsistencies were identified as fraudulent, 
suggesting that balance anomalies may act as a potential fraud indicator.
*/

SELECT isFraud, COUNT(*)
FROM payment_staaging
WHERE oldbalanceOrg - amount <> newbalanceOrig
GROUP BY isFraud;
/*
A total of 30,051 transactions exhibited balance inconsistencies where oldbalanceOrg - amount ≠ newbalanceOrig. However, 
only 5 of these transactions were labeled as fraudulent, indicating that balance anomalies occur frequently but are not 
sufficient alone to detect fraud.
*/


SELECT type, COUNT(*)
FROM payment_staaging
WHERE oldbalanceOrg - amount <> newbalanceOrig
GROUP BY type;
/*
Insight:
Fraudulent transactions occur predominantly in TRANSFER and CASH_OUT 
transaction types, while PAYMENT, DEBIT, and CASH_IN transactions show little to no fraud activity.
*/

select  type,count(*) AS fraud_count
from payment_staaging where isFraud=1
group by type;
/*
Analysis of fraudulent transactions revealed that all fraud cases occur within TRANSFER and CASH_OUT operations.
 This indicates that fraudsters typically transfer funds to intermediary accounts before withdrawing them, 
 highlighting these transaction types as high-risk channels.
 */

SELECT 
    CASE 
        WHEN amount < 1000 THEN 'Low'
        WHEN amount BETWEEN 1000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS amount_range,
    COUNT(*) AS fraud_count
FROM payment_staaging
WHERE isFraud = 1
GROUP BY amount_range;
/*
Fraudulent transactions are highly concentrated in high-value transfers and cash-out operations. 
Over 89% of fraud cases occur in transactions exceeding 10,000 units, indicating that fraudsters 
prioritize large-value transfers to maximize potential gains.
*/

SELECT 
    AVG(amount) AS avg_fraud_amount,
    MAX(amount) AS largest_fraud_transaction,
    MIN(amount) AS smallest_fraud_transaction
FROM payment_staaging
WHERE isFraud = 1;
/*
Fraudulent transactions in the dataset are characterized by significantly higher transaction amounts. The average fraud transaction value exceeds 541K, 
with the largest recorded fraud reaching 10 million. This suggests that fraudsters tend to target high-value transactions to maximize financial gain.
*/

SELECT COUNT(*) AS suspicious_transactions
FROM payment_staaging
WHERE isFraud = 1
AND oldbalanceDest = 0
AND newbalanceDest = 0;
/*
Out of 94 total fraud transactions, 42 transactions involve destination accounts with zero balances 
both before and after the transaction, suggesting that fraudsters frequently use temporary or intermediary
 accounts to facilitate fraudulent transfers.
 */

SELECT COUNT(*) AS total_fraud
FROM payment_staaging
WHERE isFraud = 1;

SELECT 
SUM(CASE WHEN oldbalanceDest = 0 AND newbalanceDest = 0 THEN 1 ELSE 0 END) AS suspicious,
COUNT(*) AS total_fraud,
SUM(CASE WHEN oldbalanceDest = 0 AND newbalanceDest = 0 THEN 1 ELSE 0 END) / COUNT(*) AS proportion
FROM payment_staaging
WHERE isFraud = 1;
/*
Approximately 44.7% of fraudulent transactions (42 out of 94) involve destination accounts where both 
the previous and new balances remain zero. This pattern suggests that fraudsters may be using temporary
 or intermediary accounts that do not maintain normal balance records, indicating a potential weakness 
 in transaction monitoring systems.
 */

SELECT *
FROM payment_staaging
WHERE isFraud = 1
AND oldbalanceOrg = 0;

SELECT 
    type,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(SUM(isFraud) / COUNT(*) * 100, 2) AS fraud_rate_percent
FROM payment_staaging
GROUP BY type
ORDER BY fraud_rate_percent DESC;

SELECT 
    nameOrig,
    COUNT(*) AS fraud_transactions,
    SUM(amount) AS total_fraud_amount
FROM payment_staaging
WHERE isFraud = 1
GROUP BY nameOrig
ORDER BY fraud_transactions DESC;

SELECT 
    step,
    COUNT(*) AS fraud_transactions
FROM payment_staaging
WHERE isFraud = 1
GROUP BY step
ORDER BY step;

SELECT *
FROM payment_staaging
WHERE oldbalanceOrg = 0
AND amount > 0
LIMIT 20;
/*
Several transactions show cases where the originating account balance is recorded as zero while 
still initiating payments. This suggests potential inconsistencies in balance tracking or system 
logging errors, which may obscure fraudulent activity or reflect limitations in the dataset.
*/