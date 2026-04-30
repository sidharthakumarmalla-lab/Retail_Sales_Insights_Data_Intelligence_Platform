# 📊 Retail_Sales_Insights_Data_Intelligence_Platform
## 🚀 Project Overview
This project demonstrates an end-to-end data platform built using Microsoft Fabric, SQL, and Power BI. It follows the Medallion Architecture (Bronze, Silver, Gold) to transform raw CRM and ERP data into actionable business insights.


## 🏗️ Architecture
This project implements a modern data pipeline using Medallion Architecture principles:

- *Data Ingestion:* CRM and ERP data loaded into Microsoft Fabric Lakehouse using Pipelines 
- *Data Processing:* SQL-based transformations using stored procedures  
- *Data Modeling:* Star schema with fact and dimension tables  
- *Data Serving:* Optimized Gold layer views for analytics  
- *Data Visualization:* Power BI dashboards for business insights  

### 🔄 Pipeline Flow:
Source → Bronze → Silver → Gold → Semantic Model → Dashboard


## ⚙️ Tech Stack
Microsoft Fabric (Lakehouse + Warehouse + Pipeline)
SQL (T-SQL)
Power BI
DAX
Data Modeling (Star Schema)


## 🔄 Data Pipeline
### 🥉 Bronze Layer
Raw data ingested from CRM & ERP systems
### 🥈 Silver Layer
Data cleaning and transformation using SQL
Stored procedures used for automation
### 🥇 Gold Layer
Business-ready views created:
dim_customer_vw
dim_product_vw
fact_sales_vw


## 📊 Semantic Model
Star schema implemented
Fact & dimension tables connected
Separate measures table created for KPIs


## 📈 Dashboard Features
Executive Overview
Total Sales
Total Orders
Total Customers
Avg Order Value
Sales Trend
Product Analysis
Sales by Category & Subcategory
Top/Bottom Products
Profit Analysis
Customer Insights
Sales by Country
Gender-wise Sales
Customer Growth


## 📸 Dashboard Screenshots
### Executive Overview
<img width="1305" height="735" alt="image" src="https://github.com/user-attachments/assets/e6d707d2-c5d8-4afe-9c98-5d4909da5e17" />

### Product Analysis
<img width="1303" height="732" alt="image" src="https://github.com/user-attachments/assets/a9d20fb7-fbf0-40a5-a490-27addb8ed9b4" />

### Customer Insights
<img width="1300" height="732" alt="image" src="https://github.com/user-attachments/assets/3048cddc-176a-4ab6-b627-44239e47dee0" />



## 💡 Key Highlights
End-to-end data pipeline design
SQL-based transformations using stored procedures
Star schema data modeling
Scalable and optimized reporting layer
