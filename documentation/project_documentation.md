# ShopSphere E-Commerce Data Analytics

## Project Overview

ShopSphere is an end-to-end e-commerce data analytics project designed to analyze sales performance, customer behavior, product performance, website engagement, and order outcomes.

The project combines Python, Pandas, NumPy, SQL, statistics, probability, and data visualization to transform raw e-commerce data into meaningful business insights.

## Business Objectives

- Analyze overall sales and revenue performance.
- Understand customer purchasing behavior.
- Identify high-performing products and categories.
- Analyze customer segments and repeat purchasing behavior.
- Study website engagement and purchase behavior.
- Analyze discounts, profitability, returns, and cancellations.
- Apply statistical and probability techniques.
- Use SQL for business-oriented data analysis.
- Generate actionable business recommendations.

## Dataset

The project uses six datasets:

- `customers.csv`
- `orders.csv`
- `order_items.csv`
- `products.csv`
- `reviews.csv`
- `website_activity.csv`

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- Statsmodels
- SQL
- SQLite
- Google Colab
- GitHub

## Analysis Performed

### Exploratory Data Analysis

The project includes:

- Data loading
- Data cleaning
- Data type validation
- Missing-value analysis
- Duplicate detection
- Descriptive statistics
- Dataset-level exploration

### Business Analysis

The analysis covers:

- Delivered sales
- Delivered profit
- Profit margins
- Order status
- Payment methods
- Customer segments
- Product categories
- Product sub-categories
- Price categories
- Customer spending
- Order frequency
- Website engagement
- Returns and cancellations

### Statistical Analysis

The project includes:

- Descriptive statistics
- Correlation analysis
- Pearson correlation tests
- Discount vs profit analysis
- Selling price vs profit analysis
- Cost price vs profit analysis
- Chi-square test
- Independent two-sample t-test
- One-way ANOVA

### Probability Analysis

The project includes:

- Order status probabilities
- Conditional delivery probabilities by payment method
- Conditional return probabilities by payment method
- Joint probability analysis
- Non-delivery probability

### SQL Analysis

SQL is used to analyze:

- Sales
- Profit
- Orders
- Customers
- Customer segments
- Product categories
- Product sub-categories
- Payment methods
- Monthly performance
- Returns
- Profit margins
- Cross-dimensional business performance

## Visualizations

The project contains multiple visualizations covering:

- Monthly sales
- Monthly profit
- Product category performance
- Customer spending
- Customer segments
- Product performance
- Website engagement
- Conversion rates
- Discounts
- Profit margins
- Returns
- Order trends
- Payment methods

## Key Business Findings

- Delivered sales are concentrated across major product categories, with Electronics generating the highest delivered sales.
- Beauty generates the highest delivered profit among product categories.
- Regular customers contribute the largest share of both sales and profit.
- High-price products contribute a larger share of delivered sales and profit.
- Discounts show a statistically significant negative relationship with profit.
- Selling price has a statistically significant positive relationship with profit.
- Cost price has a statistically significant negative relationship with profit.
- Product category has a statistically significant effect on average profit.
- Payment method and order status do not show sufficient statistical evidence of association.
- Delivered and returned order values do not show sufficient statistical evidence of a difference in average order value.
- Beauty has the highest product return rate among the analyzed categories.

## Business Recommendations

- Focus on high-performing product categories while monitoring profitability.
- Investigate products and categories with weaker profit margins.
- Review discount strategies to reduce unnecessary margin erosion.
- Strengthen retention strategies for regular customers.
- Investigate higher-return categories such as Beauty.
- Monitor product costs and pricing decisions to protect profitability.
- Improve website engagement and conversion analysis.
- Use monthly performance trends to support operational planning.

## Future Improvements

Future development could include:

- Customer lifetime value analysis
- RFM segmentation
- Customer churn prediction
- Sales forecasting
- Demand forecasting
- Product recommendation systems
- Return prediction
- Customer purchase prediction
- Interactive Power BI or Tableau dashboards
- Streamlit analytics applications

## Reproducibility

The project is organized into separate folders for data, documentation, notebooks, SQL, and visualizations.

The main analysis notebook can be opened in Google Colab and used to reproduce the Python analysis, statistical analysis, probability analysis, visualizations, and business findings.
