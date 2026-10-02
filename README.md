# ShopSphere – E-Commerce Data Analytics

End-to-end e-commerce data analytics project using Python, Pandas, NumPy, SQL, statistics, probability, and data visualization.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/harinianbu-create/shopsphere-ecommerce-data-analytics/blob/main/notebooks/shopsphere_ecommerce_data_analysis.ipynb)

## Key Business Insights

- Electronics generated the highest delivered sales among product categories.
- Beauty generated the highest delivered profit among product categories.
- Regular customers contributed the largest share of delivered sales and profit.
- Higher-priced products contributed a larger share of delivered sales and profit.
- Discounts showed a statistically significant negative relationship with profit.
- Selling price showed a statistically significant positive relationship with profit.
- Product category had a statistically significant effect on average profit.
- Beauty recorded the highest product return rate among the analyzed categories.

## Project Overview

ShopSphere is an end-to-end e-commerce analytics project designed to transform raw business data into meaningful insights for sales, customers, products, profitability, website engagement, and order performance.

The project combines exploratory data analysis, business KPI analysis, statistical testing, probability analysis, SQL queries, and data visualization to answer practical business questions.

## Business Objectives

* Analyze sales and revenue performance.
* Understand customer purchasing behavior.
* Identify high-performing products and categories.
* Analyze customer segments and repeat purchasing behavior.
* Evaluate product profitability and profit margins.
* Analyze discounts, returns, and cancellations.
* Study website engagement and purchase behavior.
* Apply statistical and probability techniques to validate findings.
* Use SQL for business-oriented analysis.
* Generate actionable business recommendations.

## Dataset

The project uses six datasets:

* `customers.csv`
* `orders.csv`
* `order_items.csv`
* `products.csv`
* `reviews.csv`
* `website_activity.csv`

The datasets contain information about customers, products, orders, order items, reviews, and website activity.

## Technologies Used

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* SciPy
* Statsmodels
* SQL
* SQLite
* Google Colab
* GitHub

## Analysis Performed

### Exploratory Data Analysis

* Data loading and preparation
* Data cleaning
* Data type validation
* Missing-value analysis
* Duplicate detection
* Descriptive statistics
* Dataset exploration

### Business Analysis

* Delivered sales
* Delivered profit
* Profit margins
* Order status
* Payment methods
* Customer segments
* Product categories
* Product sub-categories
* Price categories
* Customer spending
* Order frequency
* Website engagement
* Returns and cancellations
* Monthly sales and profit trends

### Statistical Analysis

The project applies statistical techniques including:

* Descriptive statistics
* Correlation analysis
* Pearson correlation tests
* Chi-square test
* Independent two-sample t-test
* One-way ANOVA

### Probability Analysis

* Order status probabilities
* Conditional delivery probabilities
* Conditional return probabilities
* Joint probabilities
* Non-delivery probability

### SQL Analysis

SQL is used to analyze:

* Sales and profit
* Orders
* Customers
* Customer segments
* Product categories
* Product sub-categories
* Payment methods
* Monthly performance
* Returns
* Profit margins
* Cross-dimensional business performance

## Key Business Findings

* Electronics generates the highest delivered sales among product categories.
* Beauty generates the highest delivered profit among product categories.
* Regular customers contribute the largest share of delivered sales and profit.
* High-price products contribute a larger share of delivered sales and profit.
* Discounts have a statistically significant negative relationship with profit.
* Selling price has a statistically significant positive relationship with profit.
* Cost price has a statistically significant negative relationship with profit.
* Product category has a statistically significant effect on average profit.
* There is insufficient statistical evidence of an association between payment method and order status.
* There is insufficient statistical evidence that average delivered and returned order values differ.
* Beauty has the highest product return rate among the analyzed categories.

## Business Recommendations

* Focus on high-performing categories while monitoring profitability.
* Review discount strategies to reduce unnecessary margin erosion.
* Investigate products and categories with weaker profit margins.
* Strengthen retention strategies for regular customers.
* Investigate higher-return categories such as Beauty.
* Monitor product costs and pricing decisions to protect profitability.
* Improve website engagement and conversion analysis.
* Use monthly performance trends to support operational planning.

## Visualizations

The project contains visualizations covering:

* Monthly sales and profit
* Product category performance
* Customer segments
* Customer spending
* Product performance
* Profit margins
* Website engagement
* Conversion rates
* Discounts
* Returns and cancellations
* Order trends
* Payment methods

All generated visualizations are available in the [`visualizations/`](visualizations/) folder.

## Repository Structure

```text
shopsphere-ecommerce-data-analytics/
│
├── data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── products.csv
│   ├── reviews.csv
│   └── website_activity.csv
│
├── documentation/
│   └── project_documentation.md
│
├── notebooks/
│   └── shopsphere_ecommerce_data_analysis.ipynb
│
├── sql/
│   └── SQL analysis files
│
├── visualizations/
│   └── generated charts
│
├── README.md
└── requirements.txt
```

## How to Run

### Google Colab

1. Open the analysis notebook.
2. Open it in Google Colab.
3. Upload or connect the required dataset files.
4. Install the required Python libraries if necessary.
5. Run the notebook cells sequentially.

### Local Environment

Install the required dependencies using:

```bash
pip install -r requirements.txt
```

Then open the notebook using Jupyter Notebook or JupyterLab.

## Main Project Files

**Analysis Notebook**

[Open Analysis Notebook](https://github.com/harinianbu-create/shopsphere-ecommerce-data-analytics/blob/main/notebooks/shopsphere_ecommerce_data_analysis.ipynb)

Contains the complete end-to-end analysis, including Python, SQL, statistics, probability, visualizations, and business insights.

**Project Documentation**

`documentation/project_documentation.md`

Contains detailed project objectives, datasets, technologies, analysis performed, findings, recommendations, and future improvements.

**SQL Analysis**

[Open SQL Analysis](https://github.com/harinianbu-create/shopsphere-ecommerce-data-analytics/blob/main/sql/shopsphere_sql_analysis.sql)

Contains the SQL queries used for business analysis, KPI calculations, customer analysis, product analysis, and order analysis.

**Visualizations**

`visualizations/`

Contains the charts generated during the analysis.

**Requirements**

`requirements.txt`

Contains the Python libraries required to reproduce the analysis.

## Future Improvements

Future development could include:

* Customer Lifetime Value analysis
* RFM customer segmentation
* Customer churn prediction
* Sales forecasting
* Demand forecasting
* Product recommendation systems
* Return prediction
* Customer purchase prediction
* Interactive Power BI or Tableau dashboards
* Streamlit analytics application

## Project Status

**Status: Completed**

The current version includes the complete exploratory analysis, business analysis, statistical analysis, probability analysis, SQL analysis, visualizations, business insights, and recommendations.
