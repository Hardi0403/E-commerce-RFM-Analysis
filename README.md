# E-commerce-RFM-Analysis
E-Commerce Customer Segmentation and Marketing Strategy (RFM Analysis)
Project Goal: To transform 12 months of raw e-commerce sales data into an actionable, segmented customer base to drive targeted marketing campaigns and maximize Customer Lifetime Value (CLV).

Methodology & Technical Execution:

Data Preparation (SQL): Utilized PostgreSQL to clean and prepare a 541k+ row sales dataset. This involved filtering out over 149,000 bad records, including canceled orders (InvoiceNo starting with 'C') and transactions with missing CustomerID or zero/negative quantity/unit price.

Feature Engineering (SQL): Calculated core RFM metrics (Recency, Frequency, Monetary Value) for 4,338 unique customers, using the NTILE window function to assign scores (1-5) based on quartile distribution.

Segmentation: Created the final rfm_segments table by combining scores into 10 distinct, business-focused categories (e.g., Champions, At-Risk, Need Attention).

Visualization & Recommendation (Power BI): Exported the final segments to Power BI to create a dashboard featuring a segment distribution chart and a clustered column chart comparing the average RFM metrics across groups.

Key Strategic Results:
The analysis successfully isolated three priority segments, representing over 60% of the customer base, each requiring a unique strategy.

E-commerce-RFM-Analysis: File Directory Breakdown

1. Source and Output Data
The repository contains two key data files. First is Online Retail.xlsx, which is the Raw Data Source. This is the original, unprocessed transactional data from your e-commerce platform and is included to ensure full reproducibility of your entire analysis. Second is rfm_segments.csv, the Final Data Output. This is the clean, processed table that you exported from your SQL database, containing the calculated R, F, M scores and the final assigned Segment Name for every customer—this is the file that was directly imported into Power BI.

2. Transformation and Documentation
The code you wrote is contained in full_rfm_project_script.sql, the Transformation Code. This is the complete PostgreSQL script showing all the steps for data cleaning, calculating the RFM metrics, and assigning the final 10 customer segments using complex SQL, including window functions and CTEs. The overall project is documented by README.md, which serves as the Project Summary & Guide. This is the main landing page for your repository and provides a concise overview of the project's methodology (SQL, Power BI), strategic results, and a guide for all the other files contained in the repository.

3. Visualization
Finally, RFM_Customer_Segmentation_Dashboard.pbix is the Visualization Dashboard. This is the final Power BI file that contains the data model, all DAX measures, and the two key final visualizations (the Donut Chart and the Clustered Column Chart) used to deliver the actionable business insights.








