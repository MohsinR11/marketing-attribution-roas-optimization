# Marketing Attribution & ROAS Optimization Dashboard

![Dashboard Preview](screenshots/executive-overview.png)

## 📊 Project Overview

An end-to-end marketing attribution analytics project that analyzes multi-channel customer journeys to optimize marketing spend and maximize ROI. Built comprehensive attribution framework comparing 6 different models to reveal true channel value and identify budget optimization opportunities.

## 🎯 Business Problem

**Challenge**: Most organizations rely on Last-Touch Attribution, which:
- Overvalues conversion channels while ignoring acquisition channels
- Creates blind spots in understanding the customer journey
- Leads to misallocation of 30-40% of marketing budgets
- Results in cutting critical channels that appear "low-performing"

**Question Answered**: *"Which marketing channels are ACTUALLY driving revenue, and how should we reallocate our budget to maximize ROAS?"*

## 💡 Solution

Built a comprehensive **Multi-Touch Attribution** system that:
- Compares 6 attribution models (Last-Touch, First-Touch, Linear, Time-Decay, Position-Based, Markov Chain)
- Analyzes complete customer journey paths across all touchpoints
- Implements data-driven Markov Chain model for accurate channel valuation
- Provides actionable budget reallocation recommendations

## 📈 Key Metrics

### Overall Performance
- **Total Revenue**: ₹21.19M
- **Total Marketing Spend**: ₹5.05M
- **Overall ROAS**: 4.20x
- **Total Customers**: 23K
- **Converted Customers**: 6K
- **Conversion Rate**: 23.89%

### Data Analyzed
- 23,395 total customer touchpoints
- 5,589 conversions tracked
- 6 marketing channels evaluated
- 6-month campaign period
- 119 unique customer journey paths

## 🔍 Critical Findings

### 1. Attribution Model Comparison Reveals Hidden Truth

**Last-Touch vs. Reality (Markov Chain)**:

| Channel | Last-Touch Revenue | Markov Revenue | Difference |
|---------|-------------------|----------------|------------|
| Email | ₹12.27M | ₹6.79M | **-81% overvalued** |
| Direct | ₹12.24M | ₹5.56M | -120% overvalued |
| Paid Search | ₹8.08M | ₹7.88M | Nearly accurate |
| Facebook Ads | ₹0 | ₹6.62M | **Invisible in Last-Touch!** |
| Instagram Ads | ₹0 | ₹5.63M | **Invisible in Last-Touch!** |

**Key Insight**: Social channels (Facebook & Instagram) are CRITICAL for the customer journey but show ₹0 revenue in Last-Touch Attribution!

### 2. Multi-Channel Journey Patterns

**Top Conversion Paths**:
1. `Paid_Search → Facebook_Ads → Email` (12,453 conversions)
2. `Facebook_Ads → Paid_Search → Paid_Search` (15,094 conversions)
3. `Paid_Search → Instagram_Ads → Organic_Search` (18,057 conversions)

**Average Journey Length**:
- Converted customers: **5+ touchpoints**
- Non-converted: **2-3 touchpoints**
- Insight: More engagement = higher conversion probability

### 3. Channel Roles in Customer Journey

**Acquisition (First Touch)**:
- Paid Search: Primary acquisition driver
- Facebook/Instagram: Awareness builders

**Consideration (Mid-Funnel)**:
- Facebook Ads: Highest mid-journey presence
- Instagram Ads: Brand storytelling

**Conversion (Last Touch)**:
- Email: 30.84% conversion rate (highest)
- Direct: 40.46% conversion rate (brand recall)

## 💰 Business Impact & Recommendations

### Budget Optimization Results
- **Revenue Lift Opportunity**: ₹306.39K (+11.38%)
- **ROAS Improvement**: +0.06 (from current levels)
- **Strategy**: Reallocate existing budget, no additional spend required

### Recommended Budget Changes

| Channel | Current Spend | Optimized Spend | Change |
|---------|--------------|-----------------|---------|
| **Email** | ₹0.17M | ₹0.32M | **+80.36%** ⬆️ |
| Paid Search | ₹1.98M | ₹1.92M | -2.88% ⬇️ |
| Facebook Ads | ₹1.61M | ₹1.56M | -2.88% ⬇️ |
| Instagram Ads | ₹1.29M | ₹1.26M | -2.88% ⬇️ |

### Strategic Rationale

**Why Increase Email?**
- ✅ Highest ROAS (3.3x in Markov model)
- ✅ Efficient conversion channel (30.84% conversion rate)
- ✅ Low cost, high return
- ⚠️ Limitation: Finite audience size (monitor for diminishing returns)

**Why Maintain Paid Search/Social?**
- ✅ Critical acquisition channels (start 70%+ of journeys)
- ✅ Feed the top of the funnel
- ✅ Enable all downstream conversions
- ⚠️ Cutting these would destroy pipeline in 60-90 days

## 🛠️ Technical Implementation

### Tech Stack
- **Database**: PostgreSQL (customer journey data warehousing)
- **Data Analysis**: Python
  - `pandas` - Data manipulation
  - `numpy` - Numerical computing
  - `scikit-learn` - Machine learning
  - `statsmodels` - Statistical modeling
  - `matplotlib` & `seaborn` - Visualization
- **Attribution Modeling**: Markov Chain (probabilistic model)
- **BI Tool**: Power BI Desktop
- **Additional Tools**: Excel, Jupyter Notebook

### Data Pipeline
```
1. Data Generation
   ├── Synthetic customer journey data (10K customers)
   ├── Multi-channel touchpoint simulation
   └── Conversion and revenue tracking

2. Database Design (PostgreSQL)
   ├── customer_journeys table (touchpoint records)
   ├── conversions table (revenue data)
   ├── marketing_spend table (budget data)
   └── attribution_results table (model outputs)

3. Attribution Modeling (Python)
   ├── Last-Touch Attribution
   ├── First-Touch Attribution
   ├── Linear Attribution
   ├── Time-Decay Attribution
   ├── Position-Based Attribution
   └── Markov Chain Attribution ⭐

4. Optimization Analysis
   ├── ROAS calculation by model
   ├── Budget optimization with constraints
   ├── Diminishing returns modeling
   └── Scenario analysis

5. Visualization (Power BI)
   ├── Executive Overview Dashboard
   ├── Attribution Model Comparison
   ├── Channel Performance Deep Dive
   └── Budget Optimization Recommendations
```

### Attribution Models Explained

**Markov Chain Attribution (Recommended)**:
- Calculates probability of conversion WITH vs. WITHOUT each channel
- Measures true incremental value (removal effect)
- Data-driven, not assumption-based
- Accounts for all possible customer journey combinations
- Industry gold standard for attribution

**Why Not Use Simpler Models?**
- Last-Touch: Only credits final touchpoint (ignores journey)
- First-Touch: Only credits first touchpoint (ignores nurturing)
- Linear: Assumes all touches equally important (unrealistic)
- Time-Decay/Position: Use arbitrary weights (not data-driven)

## 📊 Dashboard Features

### Page 1: Executive Overview
- High-level KPIs (Revenue, Spend, ROAS, Customers, Conversions)
- Daily revenue trend analysis
- Revenue distribution by channel (pie chart)
- Daily marketing spend by channel (stacked area)
- Top conversion journey paths (table)

### Page 2: Attribution Model Comparison
- Revenue attribution by all 6 models (bar chart)
- ROAS comparison across models (column chart)
- Attribution matrix (detailed comparison table)
- Last-Touch vs. Markov reality check
- Channel type breakdown (Paid vs. Organic)

### Page 3: Channel Performance Deep Dive
- Channel-specific KPIs (touchpoints, conversion rate, revenue, ROAS)
- Performance summary table with all metrics
- Customer reach vs. conversion analysis
- Revenue vs. spend comparison (combo chart)
- Engagement metrics (session duration, pages viewed)

### Page 4: Budget Optimization Recommendations
- Current vs. optimized budget allocation
- Recommended budget changes by channel
- ROAS improvement projections
- Revenue impact estimation
- Optimization details table

## 🚀 How to Run This Project

### Prerequisites
```bash
Python 3.8+
PostgreSQL 12+
Jupyter Notebook
Power BI Desktop
```

### Installation & Setup

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/marketing-attribution-roas-optimization.git
cd marketing-attribution-roas-optimization
```

2. **Install Python dependencies**
```bash
pip install pandas numpy matplotlib seaborn scikit-learn scipy statsmodels psycopg2 sqlalchemy plotly openpyxl python-docx
```

3. **Set up PostgreSQL database**
```sql
CREATE DATABASE marketing_attribution;
```

4. **Run Jupyter notebooks sequentially**
```
01_Data_Generation.ipynb
02_Load_Data_to_PostgreSQL.ipynb
03_Exploratory_Data_Analysis.ipynb
04_Attribution_Modeling.ipynb
05_ROAS_Optimization.ipynb
```

5. **Open Power BI Dashboard**
- Launch Power BI Desktop
- Open `powerbi/Marketing_Attribution_Dashboard.pbix`
- Refresh data connections if needed

## 📂 Project Structure
```
marketing-attribution-project/
├── data/                              # Generated datasets
│   ├── customer_journeys.csv          # All touchpoint records
│   ├── conversions.csv                # Conversion events
│   ├── marketing_spend.csv            # Daily spend by channel
│   ├── attribution_results.csv        # Model outputs
│   └── budget_optimization_results.csv
│
├── notebooks/                         # Analysis pipeline
│   ├── 01_Data_Generation.ipynb
│   ├── 02_Load_Data_to_PostgreSQL.ipynb
│   ├── 03_Exploratory_Data_Analysis.ipynb
│   ├── 04_Attribution_Modeling.ipynb
│   ├── 05_ROAS_Optimization.ipynb
│   └── 06_PowerBI_Data_Prep.ipynb
│
├── documentation/                     # Reports & visualizations
│   ├── Executive_Summary.pdf
│   ├── Technical_Analysis.pdf
│   └── visualizations/
│       ├── 01_channel_touchpoints.png
│       ├── 02_conversion_rate_by_channel.png
│       └── ... (15+ visualizations)
│
├── sql_scripts/                       # Database schemas
│   └── schema.sql
│
├── powerbi/                          # Interactive dashboard
│   └── Marketing_Attribution_Dashboard.pbix
│
└── README.md
```

## 🎓 Key Learnings & Insights

### Technical Skills Demonstrated
✅ **SQL**: Complex queries, window functions, CTEs, database design  
✅ **Python**: Data analysis, statistical modeling, machine learning  
✅ **Attribution Modeling**: Markov Chains, probabilistic models  
✅ **Data Visualization**: Power BI dashboards, Python visualizations  
✅ **Business Analytics**: ROI optimization, budget allocation strategy  

### Business Insights
✅ Multi-touch attribution reveals 30-40% budget waste in single-touch models  
✅ Acquisition channels critical despite appearing to have low ROAS  
✅ Customer journeys require 5+ touchpoints across multiple channels  
✅ Data-driven optimization can improve ROAS by 10-15% without additional spend  

### Strategic Implications
1. **Full-funnel thinking** beats channel silos
2. **Attribution model choice** directly impacts budget decisions
3. **Customer journey analysis** reveals channel synergies
4. **Continuous optimization** necessary as markets evolve

## 🎯 Use Cases

This project framework can be applied to:
- **D2C E-commerce**: Optimize digital marketing mix
- **B2B SaaS**: Understand long sales cycle attribution
- **Retail**: Combine online + offline touchpoints
- **Marketplace**: Multi-sided platform attribution
- **Lead Generation**: Optimize cost per qualified lead

## 🔮 Future Enhancements

Potential additions to this project:
- [ ] Real-time attribution dashboard (streaming data)
- [ ] Cross-device tracking implementation
- [ ] Offline channel integration (TV, radio, print)
- [ ] Customer Lifetime Value (CLV) modeling
- [ ] Automated budget allocation algorithm
- [ ] A/B testing framework for validation
- [ ] Marketing Mix Modeling (MMM) comparison
- [ ] Prophet forecasting for seasonal adjustment

## 📧 Contact

**Mohsin Raza**  
Data Analyst | BI Developer

- 📧 Email: [mohsinansari1799@gmail.com]
- 💼 LinkedIn: [https://www.linkedin.com/in/mohsinraza-data/]

## 📝 License

This project is open source and available under the MIT License.

---

## 🌟 Acknowledgments

Special thanks to:
- Marketing analytics community for attribution best practices
- Open source contributors of Python data science libraries
- Power BI community for dashboard design inspiration

---

**⭐ If you found this project valuable, please give it a star!**

**💬 Questions or feedback? Open an issue or reach out directly.**

**🔗 Share this project with anyone interested in marketing analytics!**
