Payment Fraud Detection Analysis (SQL + Python + Machine Learning)
Project Overview

This project analyzes financial transaction data to identify patterns associated with fraudulent activities. The analysis combines SQL investigation, exploratory data analysis, statistical testing, and machine learning to uncover fraud patterns and build predictive models for fraud detection.

The objective of the project is to:

Understand how fraudulent transactions behave

Identify high-risk transaction patterns

Apply statistical methods to validate fraud indicators

Develop machine learning models for fraud detection

Provide business recommendations for fraud prevention

Dataset Information

This project uses the Online Payments Fraud Detection Dataset available on Kaggle.

Dataset Link
https://www.kaggle.com/datasets/rupakroy/online-payments-fraud-detection-dataset

Due to GitHub file size limitations, the dataset is not uploaded to this repository. You can download it directly from the Kaggle link above.

Dataset characteristics:

Total records: 6,362,620

Total features: 11

Key columns include:

Column	Description
step	Unit of time (1 step = 1 hour)
type	Transaction type
amount	Transaction amount
nameOrig	Origin account
oldbalanceOrg	Origin balance before transaction
newbalanceOrig	Origin balance after transaction
nameDest	Destination account
oldbalanceDest	Destination balance before transaction
newbalanceDest	Destination balance after transaction
isFraud	Fraud indicator (1 = fraud, 0 = legitimate)
isFlaggedFraud	System flagged fraud indicator
Tools and Technologies

The analysis was performed using:

SQL (MySQL Workbench)

Python

Pandas

NumPy

Seaborn

Matplotlib

Scikit-learn

Tableau

Project Workflow

The project follows a structured analytical workflow.

1. Data Exploration

Initial exploration was performed to understand:

dataset size

transaction distribution

fraud proportion

transaction type frequency

Key observation:

Fraud transactions represent only 0.13% of total transactions, indicating severe class imbalance.

2. SQL Analysis

SQL was used to perform detailed exploratory analysis and identify suspicious transaction patterns.

Data Cleaning

Created a staging table for safe analysis

Checked for balance inconsistencies

Identified abnormal transaction records

SQL Analysis Included

Fraud vs non-fraud transaction distribution

Fraud by transaction type

Transaction amount investigation

Account balance anomalies

Suspicious transaction detection

3. Exploratory Data Analysis (Python)

Python visualizations were used to explore fraud patterns.

Visualizations created:

Fraud rate by transaction type

Transaction amount distributions

Fraud vs legitimate transaction comparison

Boxplots of transaction amounts

Fraud distribution charts

Key observation:

Fraud is concentrated primarily in:

TRANSFER transactions

CASH_OUT transactions

Other transaction types show minimal fraud activity.

4. Statistical Analysis

Statistical hypothesis tests were conducted to validate fraud patterns.

T-Test

Objective:
Test whether fraud transactions have significantly different transaction amounts compared to legitimate transactions.

Hypotheses:

H0: Fraud and normal transactions have the same mean transaction amount
H1: Fraud transactions have a different mean transaction amount

Result:

T-statistic ≈ 194

p-value ≈ 0

Conclusion:

Fraud transactions have significantly higher average transaction values.

Chi-Square Test

Objective:
Test whether fraud occurrence depends on transaction type.

Hypotheses:

H0: Fraud occurrence is independent of transaction type
H1: Fraud depends on transaction type

Result:

Chi-square statistic ≈ 22082

p-value ≈ 0

Conclusion:

Fraud occurrence strongly depends on transaction type.

5. Machine Learning Model

A Logistic Regression model was built to predict fraudulent transactions.

Model Evaluation

Evaluation metrics included:

Classification Report

Confusion Matrix

ROC Curve

Feature Importance Analysis

Model performance:

AUC Score ≈ 0.988

Excellent ability to distinguish fraud from legitimate transactions

Moderate recall for fraud detection due to dataset imbalance

Key Insights
1. Fraud is Extremely Rare

Fraudulent transactions represent only 0.13% of the dataset, creating a highly imbalanced classification problem.

2. Fraud is Concentrated in Specific Transaction Types

Fraud occurs primarily in:

TRANSFER transactions

CASH_OUT transactions

These represent the main channels used by fraudsters.

3. Fraud Transactions Involve Larger Amounts

Fraud transactions have significantly higher average amounts compared to legitimate transactions.

Statistical testing confirms this difference is significant.

4. Fraud is Strongly Linked to Transaction Type

The chi-square test confirms that fraud occurrence depends on transaction type.

Certain transaction categories carry significantly higher fraud risk.

5. Balance Anomalies Are Common in Fraud Transactions

Many fraud cases involve suspicious balance behavior such as:

abnormal balance changes

accounts with zero destination balances

Approximately 44.7% of fraud transactions involve destination accounts with zero balances, indicating possible intermediary or temporary accounts.

Business Recommendations

Based on the analysis, financial institutions should implement the following strategies.

Risk-Based Transaction Monitoring

Apply stricter monitoring for high-risk transaction types such as:

TRANSFER

CASH_OUT

Large Transaction Monitoring

Implement alerts for unusually large transaction amounts compared to typical customer behavior.

Real-Time Fraud Detection Systems

Deploy machine learning models to score transactions in real time and flag suspicious activity.

Balance Anomaly Detection

Monitor abnormal balance patterns such as sudden large withdrawals or unusual balance inconsistencies.

Behavioral Transaction Profiling

Build models that learn normal customer transaction patterns and flag deviations as potential fraud.

Repository Structure
payment-fraud-detection
│
├── sql
│   └── fraud_analysis_queries.sql
│
├── python
│   └── fraud_analysis.ipynb
│
├── tableau
│   └── fraud_dashboard.twbx
│
└── README.md
Conclusion

This project demonstrates how combining SQL analysis, statistical methods, and machine learning techniques can uncover fraud patterns in financial transaction data.

The analysis highlights the importance of monitoring high-risk transaction types, transaction amounts, and abnormal balance patterns to improve fraud detection systems.
