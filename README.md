# 📊 SQL Server Data Warehouse Project  
### End-to-End Data Warehouse using Medallion Architecture (Bronze–Silver–Gold)

---

## 🧭 Project Overview

This project demonstrates the design and implementation of a modern **Data Warehouse using Microsoft SQL Server**, built by following **industry-standard data engineering practices**.

The warehouse integrates data from multiple source systems (CRM and ERP), processes it through layered transformations, and exposes **analytics-ready fact and dimension views** using a **Star Schema** design.

The project is intended as a **portfolio-quality implementation** suitable for academic evaluation, interviews, and real-world learning.

---

## 🎯 Project Objectives

- Design a scalable and maintainable Data Warehouse
- Implement **Medallion Architecture** (Bronze, Silver, Gold)
- Apply data cleansing, enrichment, and integration logic
- Build a **Star Schema** with surrogate keys
- Ensure clear data lineage from raw sources to analytics
- Demonstrate strong SQL Server and T-SQL skills

---

## 🏗️ Architecture Overview

The project follows the **Medallion Architecture**, which separates data processing into three logical layers:

### 🟫 Bronze Layer – Raw Data
- Stores raw data exactly as received from source systems
- No transformations or business logic applied
- Used for traceability, auditing, and reprocessing

### 🥈 Silver Layer – Cleansed & Transformed Data
- Cleans invalid or inconsistent data
- Standardizes formats and values
- Integrates CRM and ERP datasets

### 🥇 Gold Layer – Analytics Ready
- Business-level data model
- Star Schema (Facts & Dimensions)
- Optimized for reporting and analytics

---
## 📁 Project Folder Structure

SQL-DATAWAREHOUSE-PROJECT/
│
├── data/
│   ├── crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   │
│   └── erp/
│        ├── CUST_AZ12.csv
│        ├── LOC_A101.csv
│        └── PX_CAT_G1V2.csv
│
├── scripts/
│   ├── 01_database_setup.sql
│   ├── 02_bronze_load.sql
│   ├── 03_silver_transformations.sql
│   └── 04_gold_views.sql
│
├── README.md
└── LICENSE



---

## 🧩 Source Systems

### CRM Source
- Customer master data
- Product information
- Sales transaction details

### ERP Source
- Customer demographic enrichment
- Location data
- Product category reference data

---

## 🟫 Bronze Layer Details

**Purpose:**  
The Bronze layer stores raw data exactly as received from the source systems.

**Characteristics:**
- No transformations applied
- One-to-one mapping with source files
- Acts as the system of record

**Example Tables:**
- `bronze.crm_cust_info`
- `bronze.crm_prd_info`
- `bronze.crm_sales_details`
- `bronze.erp_cust_az12`
- `bronze.erp_loc_a101`
- `bronze.erp_px_cat_g1v2`

---

## 🥈 Silver Layer Details

**Purpose:**  
The Silver layer cleans, standardizes, and integrates data from the Bronze layer.

**Transformations Include:**
- Handling missing and invalid values
- Standardizing gender, dates, and text fields
- Removing duplicates
- Joining CRM and ERP datasets

**Example Tables:**
- `silver.crm_cust_info`
- `silver.crm_prd_info`
- `silver.crm_sales_details`

---

## 🥇 Gold Layer Details (Star Schema)

The Gold layer exposes **analytics-ready views** designed for reporting and business analysis.

### ⭐ Dimension Tables

#### `gold.dim_customers`
- Customer surrogate key
- Personal and demographic attributes
- Enriched using ERP data

#### `gold.dim_products`
- Product surrogate key
- Product category and subcategory
- Active products only

### ⭐ Fact Table

#### `gold.fact_sales`
- Sales transaction data
- Linked to customer and product dimensions
- Supports time-series and performance analytics

---

## 🔑 Key Design Concepts Used

- Medallion Architecture
- Star Schema Modeling
- Surrogate Keys using `ROW_NUMBER()`
- Data Cleansing and Enrichment
- Idempotent SQL Scripts (DROP + CREATE)
- Clear separation of raw and business logic

---

## 📈 Example Analytics Use Cases

- Total sales by product category
- Revenue by customer
- Sales trends over time
- Country-level sales analysis
- Product performance insights

---

## 🛠️ Tools & Technologies

- **Database:** Microsoft SQL Server
- **Language:** T-SQL
- **Version Control:** Git & GitHub
- **Architecture:** Medallion (Bronze–Silver–Gold)

---

## 🚀 How to Run the Project

1. Clone the repository
2. Open SQL Server Management Studio (SSMS)
3. Execute scripts in the following order:
  01_database_setup.sql
  02_bronze_load.sql
  03_silver_transformations.sql
  04_gold_views.sql


4. Query Gold layer views for analytics and reporting

---

## 📌 Future Enhancements

- Incremental data loading
- Slowly Changing Dimensions (SCD)
- Indexing and performance tuning
- BI dashboards using Power BI or Tableau
- ETL automation using SQL Agent or Airflow

---

## 👤 Author

**M. Lakshmi Narasimha**  
Data & Analytics Enthusiast  
Aspiring Data Engineer / Data Analyst

---

## ⭐ Final Note

This project is designed to closely resemble **real-world enterprise data warehouse implementations**.  
It demonstrates not just SQL skills, but also **architectural thinking, data modeling, and best practices**.

If you find this project useful, feel free to ⭐ the repository.


