-- ============================================
-- OVERALL BUSINESS METRICS
-- ============================================

WITH business_metrics AS (
    SELECT 
        COUNT(DISTINCT cj.customer_id) as total_customers,
        COUNT(DISTINCT c.customer_id) as converted_customers,
        ROUND(COUNT(DISTINCT c.customer_id) * 100.0 / COUNT(DISTINCT cj.customer_id), 2) as conversion_rate,
        ROUND(SUM(c.revenue), 2) as total_revenue,
        ROUND(AVG(c.revenue), 2) as avg_order_value,
        COUNT(*) as total_touchpoints,
        ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT cj.customer_id), 2) as avg_touchpoints_per_customer
    FROM customer_journeys cj
    LEFT JOIN conversions c ON cj.customer_id = c.customer_id
),
spend_metrics AS (
    SELECT 
        ROUND(SUM(spend), 2) as total_spend,
        SUM(impressions) as total_impressions,
        SUM(clicks) as total_clicks,
        ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) as overall_ctr
    FROM marketing_spend
)

SELECT 
    bm.*,
    sm.total_spend,
    sm.total_impressions,
    sm.total_clicks,
    sm.overall_ctr,
    ROUND(bm.total_revenue / NULLIF(sm.total_spend, 0), 2) as overall_roas,
    ROUND(sm.total_spend / NULLIF(bm.converted_customers, 0), 2) as cac
FROM business_metrics bm, spend_metrics sm;


-- ============================================
-- CHANNEL PERFORMANCE METRICS
-- ============================================

WITH channel_touchpoints AS (
    SELECT 
        channel,
        COUNT(*) as total_touchpoints,
        COUNT(DISTINCT customer_id) as unique_customers
    FROM customer_journeys
    GROUP BY channel
),
channel_conversions AS (
    SELECT 
        cj.channel,
        COUNT(DISTINCT c.customer_id) as conversions,
        ROUND(SUM(c.revenue), 2) as revenue
    FROM customer_journeys cj
    INNER JOIN conversions c ON cj.customer_id = c.customer_id
    GROUP BY cj.channel
),
channel_spend AS (
    SELECT 
        channel,
        ROUND(SUM(spend), 2) as total_spend,
        SUM(impressions) as impressions,
        SUM(clicks) as clicks
    FROM marketing_spend
    GROUP BY channel
)

SELECT 
    ct.channel,
    ct.total_touchpoints,
    ct.unique_customers,
    COALESCE(cc.conversions, 0) as conversions,
    ROUND(COALESCE(cc.conversions, 0) * 100.0 / ct.unique_customers, 2) as conversion_rate,
    COALESCE(cc.revenue, 0) as revenue,
    COALESCE(cs.total_spend, 0) as spend,
    COALESCE(cs.impressions, 0) as impressions,
    COALESCE(cs.clicks, 0) as clicks,
    ROUND(COALESCE(cs.clicks, 0) * 100.0 / NULLIF(cs.impressions, 0), 2) as ctr,
    ROUND(COALESCE(cc.revenue, 0) / NULLIF(cs.total_spend, 0), 2) as roas
FROM channel_touchpoints ct
LEFT JOIN channel_conversions cc ON ct.channel = cc.channel
LEFT JOIN channel_spend cs ON ct.channel = cs.channel
ORDER BY revenue DESC;


-- ============================================
-- CUSTOMER JOURNEY PATTERNS
-- ============================================

-- Average journey length by conversion status
WITH journey_stats AS (
    SELECT 
        cj.customer_id,
        COUNT(*) as touchpoints,
        CASE WHEN c.customer_id IS NOT NULL THEN 'Converted' ELSE 'Not Converted' END as status
    FROM customer_journeys cj
    LEFT JOIN conversions c ON cj.customer_id = c.customer_id
    GROUP BY cj.customer_id, c.customer_id
)

SELECT 
    status,
    COUNT(*) as num_customers,
    ROUND(AVG(touchpoints)::numeric, 2) as avg_touchpoints,
    MIN(touchpoints) as min_touchpoints,
    MAX(touchpoints) as max_touchpoints,
    ROUND(CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY touchpoints) AS numeric), 2) as median_touchpoints
FROM journey_stats
GROUP BY status
ORDER BY status;


-- ============================================
-- FIRST TOUCH VS LAST TOUCH CHANNEL ANALYSIS
-- ============================================

SELECT 
    first_touch_channel,
    COUNT(*) as first_touch_conversions,
    ROUND(SUM(revenue), 2) as first_touch_revenue,
    ROUND(AVG(revenue), 2) as avg_order_value
FROM conversions
GROUP BY first_touch_channel
ORDER BY first_touch_revenue DESC;

-- Also check last touch
SELECT 
    last_touch_channel,
    COUNT(*) as last_touch_conversions,
    ROUND(SUM(revenue), 2) as last_touch_revenue,
    ROUND(AVG(revenue), 2) as avg_order_value
FROM conversions
GROUP BY last_touch_channel
ORDER BY last_touch_revenue DESC;


-- ============================================
-- MOST COMMON CONVERSION PATHS (TOP 10)
-- ============================================

WITH customer_paths AS (
    SELECT 
        cj.customer_id,
        STRING_AGG(cj.channel, ' -> ' ORDER BY cj.touchpoint_number) as journey_path,
        COUNT(*) as path_length
    FROM customer_journeys cj
    INNER JOIN conversions c ON cj.customer_id = c.customer_id
    GROUP BY cj.customer_id
)

SELECT 
    journey_path,
    COUNT(*) as num_customers,
    ROUND(SUM(c.revenue), 2) as total_revenue,
    ROUND(AVG(c.revenue), 2) as avg_revenue,
    ROUND(AVG(path_length), 2) as avg_path_length
FROM customer_paths cp
JOIN conversions c ON cp.customer_id = c.customer_id
GROUP BY journey_path
ORDER BY num_customers DESC
LIMIT 10;