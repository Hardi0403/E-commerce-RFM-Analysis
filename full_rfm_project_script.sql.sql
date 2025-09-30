DROP TABLE IF EXISTS rfm_segments;

CREATE TABLE rfm_segments AS
WITH rfm_scores AS (
    SELECT
        "CustomerID",
        "Recency",
        "Frequency",
        "Monetary",

        -- Recency Score: Lower Recency (closer to 0 days) gets a higher score.
        -- We use NTILE(5) and assign the highest score (5) to the lowest quartile (1).
        NTILE(5) OVER (ORDER BY "Recency" DESC) AS R_Score,
        
        -- Frequency Score: Higher Frequency gets a higher score.
        NTILE(5) OVER (ORDER BY "Frequency" ASC) AS F_Score,
        
        -- Monetary Score: Higher Monetary value gets a higher score.
        NTILE(5) OVER (ORDER BY "Monetary" ASC) AS M_Score
    FROM 
        rfm_metrics
)
SELECT
    "CustomerID",
    "Recency",
    "Frequency",
    "Monetary",
    R_Score,
    F_Score,
    M_Score,
    -- Combine the three scores into one string (e.g., 5-5-5)
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score,

    -- Assign the final segment name based on the combined score
    CASE
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN '01 - Champions'
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score < 4 THEN '02 - Loyal Customers'
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN '03 - Potential Loyalists'
        WHEN R_Score >= 4 AND F_Score BETWEEN 2 AND 3 THEN '04 - New Customers'
        WHEN R_Score BETWEEN 3 AND 4 AND F_Score < 2 THEN '05 - Promising'
        WHEN R_Score BETWEEN 2 AND 3 AND F_Score BETWEEN 2 AND 3 THEN '06 - Need Attention'
        WHEN R_Score BETWEEN 2 AND 3 AND F_Score < 2 THEN '07 - At Risk'
        WHEN R_Score <= 2 AND F_Score >= 4 THEN '08 - Can''t Lose Them'
        WHEN R_Score <= 2 AND F_Score BETWEEN 2 AND 3 THEN '09 - Lost'
        ELSE '10 - Hibernating'
    END AS Segment_Name
FROM rfm_scores
ORDER BY RFM_Score DESC;


-- 5. Final Strategic Recommendation Query: Get average metrics and counts for the top 3 segments
SELECT 
    Segment_Name,
    COUNT("CustomerID") AS Customer_Count,
    ROUND(AVG("Recency")) AS Avg_Recency,
    ROUND(AVG("Frequency")) AS Avg_Frequency,
    ROUND(AVG("Monetary")) AS Avg_Monetary,
    -- Define the strategic action for this segment
    CASE Segment_Name
        WHEN '01 - Champions' THEN 'Reward them, offer early access to new products, and ask for referrals/reviews.'
        WHEN '03 - Potential Loyalists' THEN 'Offer membership or loyalty program upgrades to solidify their loyalty.'
        WHEN '06 - Need Attention' THEN 'Run limited-time re-engagement campaigns (e.g., "We Miss You" email with small discount).'
        ELSE 'Review all other segments for specialized campaigns.'
    END AS Strategic_Action
FROM 
    rfm_segments
WHERE 
    Segment_Name IN ('01 - Champions', '03 - Potential Loyalists', '06 - Need Attention')
GROUP BY 
    Segment_Name
ORDER BY 
    Customer_Count DESC;