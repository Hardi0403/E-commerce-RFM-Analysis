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
