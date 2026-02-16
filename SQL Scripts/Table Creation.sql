-- ============================================
-- MARKETING ATTRIBUTION DATABASE SCHEMA
-- ============================================

-- Drop tables if they exist (for clean slate)
DROP TABLE IF EXISTS customer_journeys CASCADE;
DROP TABLE IF EXISTS conversions CASCADE;
DROP TABLE IF EXISTS marketing_spend CASCADE;
DROP TABLE IF EXISTS attribution_results CASCADE;

-- ============================================
-- TABLE 1: CUSTOMER JOURNEYS
-- ============================================
CREATE TABLE customer_journeys (
    journey_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    touchpoint_number INTEGER NOT NULL,
    touchpoint_date TIMESTAMP NOT NULL,
    channel VARCHAR(50) NOT NULL,
    session_duration_seconds INTEGER,
    pages_viewed INTEGER,
    device VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX idx_customer_id ON customer_journeys(customer_id);
CREATE INDEX idx_channel ON customer_journeys(channel);
CREATE INDEX idx_touchpoint_date ON customer_journeys(touchpoint_date);

COMMENT ON TABLE customer_journeys IS 'Stores every touchpoint in a customers journey across marketing channels';

-- ============================================
-- TABLE 2: CONVERSIONS
-- ============================================
CREATE TABLE conversions (
    conversion_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL UNIQUE,
    conversion_date TIMESTAMP NOT NULL,
    revenue DECIMAL(10,2) NOT NULL,
    total_touchpoints INTEGER,
    first_touch_channel VARCHAR(50),
    last_touch_channel VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_conv_customer_id ON conversions(customer_id);
CREATE INDEX idx_conversion_date ON conversions(conversion_date);

COMMENT ON TABLE conversions IS 'Stores conversion events and revenue for customers who purchased';

-- ============================================
-- TABLE 3: MARKETING SPEND
-- ============================================
CREATE TABLE marketing_spend (
    spend_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    channel VARCHAR(50) NOT NULL,
    spend DECIMAL(10,2) NOT NULL,
    impressions INTEGER,
    clicks INTEGER,
    ctr DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_spend_date ON marketing_spend(date);
CREATE INDEX idx_spend_channel ON marketing_spend(channel);

COMMENT ON TABLE marketing_spend IS 'Daily marketing spend and performance metrics by channel';

-- ============================================
-- TABLE 4: ATTRIBUTION RESULTS (We'll populate this later)
-- ============================================
CREATE TABLE attribution_results (
    attribution_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    channel VARCHAR(50) NOT NULL,
    attribution_model VARCHAR(50) NOT NULL,
    attribution_credit DECIMAL(10,4) NOT NULL,
    attributed_revenue DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_attr_customer ON attribution_results(customer_id);
CREATE INDEX idx_attr_channel ON attribution_results(channel);
CREATE INDEX idx_attr_model ON attribution_results(attribution_model);

COMMENT ON TABLE attribution_results IS 'Stores attribution credits calculated by different models';

-- ============================================
-- VERIFY TABLES CREATED
-- ============================================
SELECT 
    table_name,
    (SELECT COUNT(*) 
     FROM information_schema.columns 
     WHERE table_name = t.table_name) as column_count
FROM information_schema.tables t
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Check all tables
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE';