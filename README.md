# Transaction Fraud DetectionAnalysis (SQL)

## Project Overview
This project analyzes online payment transactions to identify patterns and indicators of fraudulent activity. Using SQL, the dataset was explored through data cleaning, anomaly detection, and exploratory analysis to uncover suspicious transaction behaviors.

The analysis focuses on understanding fraud patterns related to transaction types, transaction amounts, and account balance inconsistencies.

---

## Dataset
The dataset contains transaction-level information for online payments.

This project uses the **Online Payments Fraud Detection Dataset** available on Kaggle.

Dataset Link:  
https://www.kaggle.com/datasets/rupakroy/online-payments-fraud-detection-dataset

The dataset contains transaction-level data for online payments, including:

Due to GitHub file size limitations, the dataset is not uploaded to this repository. 
You can download it directly from Kaggle using the link above.

Key columns include:

- step – unit of time (1 step = 1 hour)
- type – type of transaction (TRANSFER, CASH_OUT, PAYMENT, etc.)
- amount – transaction amount
- nameOrig – customer initiating the transaction
- oldbalanceOrg – balance before transaction
- newbalanceOrig – balance after transaction
- nameDest – recipient of the transaction
- oldbalanceDest – recipient balance before transaction
- newbalanceDest – recipient balance after transaction
- isFraud – fraud indicator (1 = fraud, 0 = non-fraud)
- isFlaggedFraud – system flagged fraud indicator

Dataset Source: Kaggle

---

## Tools Used
- SQL
- MySQL Workbench
- Data Cleaning
- Exploratory Data Analysis

---

## Project Steps

### 1. Data Cleaning
- Created staging table for analysis
- Checked balance inconsistencies
- Identified abnormal transaction patterns

### 2. Exploratory Data Analysis
Analyzed:

- Fraud vs Non-Fraud distribution
- Fraud by transaction type
- Fraud transaction amounts
- Balance anomalies
- Suspicious destination accounts

---

## Key Findings

### Fraud Distribution
A small portion of transactions are fraudulent, indicating strong class imbalance in the dataset.

### Fraud Transaction Types
Fraud transactions occur almost exclusively in:

- TRANSFER
- CASH_OUT

These transaction types represent the main channels used for fraudulent activity.

### Fraud Transaction Amounts
Fraud transactions typically involve **large transaction amounts**, with the average fraud amount exceeding **500,000**.

### Destination Account Anomaly
Approximately **44.7% of fraud transactions** involve destination accounts where both:

- oldbalanceDest = 0
- newbalanceDest = 0

This suggests fraudsters may use temporary or intermediary accounts to transfer funds.

### Suspicious Transaction Pattern
Several fraud transactions involve accounts with unusual balance behaviors, indicating possible system manipulation or incomplete balance tracking.

---

