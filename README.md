# Financial MIS & Statistical Reporting System

## Overview
This repository contains the end-to-end automated data pipeline for a Financial Management Information System (MIS). The project transitions a manual, error-prone monthly reporting process into a secure, automated architecture using Excel VBA, SQL, and Tableau.

## Key Business Impact
* **Efficiency:** Automated monthly financial and statistical reporting workflows, reducing manual tracking effort by 70%.
* **Data Governance:** Implemented automated validation and error-checking mechanisms within SQL to quarantine corrupt records and secure data integrity before visualization.

## Architecture & Tech Stack
1. **Excel VBA (Pre-Processing Layer):** Automates the initial ingestion of raw financial extracts, applies standardized formatting, and visually flags critical missing data points.
2. **SQL (Validation Layer):** Uses `CASE WHEN` logic and conditional routing to detect anomalies (e.g., negative revenue, missing Customer IDs, null profit margins). Clean data is passed to a reporting view, while broken records are quarantined for review.
3. **Tableau Prep & Desktop (Visualization Layer):** Connects directly to the validated SQL view to generate the monthly executive dashboard, highlighting profitability KPIs and data integrity metrics.

## Repository Files
* `Raw_Financial_Dump.csv`: Simulated monthly raw data containing intentional data entry errors for testing.
* `Automate_MIS_Preprocessing.vba`: The Excel macro script for immediate format standardization.
* `Data_Validation_Pipeline.sql`: The SQL scripts used to build the error-checking views and aggregate statistical summaries.
* `Financial_Dashboard_Sample.png`: A screenshot of the final automated Tableau dashboard.

## How to Run Locally
1. Run the `.vba` macro against the `Raw_Financial_Dump.csv` file in Excel to see the formatting automation.
2. Load the CSV into your local SQL environment and execute `Data_Validation_Pipeline.sql` to generate the `vw_validated_financial_mis` view.
3. Connect Tableau to the resulting view to instantly generate the monthly statistical report.
