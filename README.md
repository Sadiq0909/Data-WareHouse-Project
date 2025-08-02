# Data Warehouse and Analytics Project

This repository demonstrates a complete data warehousing and analytics solution, including data modeling, ETL pipelines, and SQL-based reporting. The project follows industry-standard practices and a **Medallion Architecture** using SQL Server.

---

## 🏗️ Data Architecture

The architecture uses three layers:

1. **Bronze Layer**  
   Raw data ingestion from ERP and CRM CSV files into SQL Server.

2. **Silver Layer**  
   Data cleansing, standardization, and transformation.

3. **Gold Layer**  
   Final business-ready star schema for reporting and analysis.

---

## 📖 Project Overview

### Key Components:
- **ETL Pipelines**: SQL-based data extraction, transformation, and loading.
- **Data Modeling**: Star schema with fact and dimension tables.
- **SQL Analytics**: Business insights via SQL queries.

### Skills Demonstrated:
- SQL Development  
- Data Engineering  
- ETL Pipeline Creation  
- Data Modeling  
- Analytical Reporting  

---

## 🚀 Project Phases

### 1. Data Engineering
- Load ERP & CRM CSV data into SQL Server (Bronze).
- Clean and join data (Silver).
- Build star schema model (Gold).

### 2. Data Analysis
- Customer behavior
- Sales trends
- Product performance

---

## 📂 Repository Structure
data-warehouse-project/
│
├── datasets/ # Raw CSV files
│
├── scripts/ # SQL ETL scripts
│ ├── bronze/
│ ├── silver/
│ ├── gold/
│
├── tests/ # Data validation scripts
├── README.md # Project documentation
├── LICENSE
└── requirements.txt # Setup instructions


---

## ✅ Data Quality Checks

### Silver Layer
- No duplicate or NULL keys
- No unwanted spaces
- No invalid or out-of-range dates
- Consistent numerical fields (e.g., sales = qty × price)

### Gold Layer
- Unique surrogate keys
- Fact-to-dimension referential integrity

---

## 🛠️ Tools Used

- SQL Server Express
- SQL Server Management Studio (SSMS)
- Draw.io
- Git

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).
