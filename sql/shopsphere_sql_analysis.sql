-- ShopSphere E-Commerce Data Analytics
-- Standalone SQL analysis extracted from Section 16 of the analysis notebook.

-- SQL Query 1
SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS order_frequency,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS total_sales
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name
    ORDER BY total_sales DESC

-- SQL Query 2
SELECT
        CASE
            WHEN customer_sales >= 100000 THEN 'High Value'
            WHEN customer_sales >= 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment,
        ROUND(SUM(customer_sales), 2) AS total_sales
    FROM (
        SELECT
            c.customer_id,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS customer_sales
        FROM customers c
        INNER JOIN orders o
            ON c.customer_id = o.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY c.customer_id
    )
    GROUP BY customer_segment
    ORDER BY total_sales DESC

-- SQL Query 3
SELECT
        CASE
            WHEN customer_sales >= 100000 THEN 'High Value'
            WHEN customer_sales >= 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment,
        COUNT(*) AS customer_count,
        ROUND(SUM(customer_sales), 2) AS total_sales
    FROM (
        SELECT
            c.customer_id,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS customer_sales
        FROM customers c
        INNER JOIN orders o
            ON c.customer_id = o.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY c.customer_id
    )
    GROUP BY customer_segment
    ORDER BY total_sales DESC

-- SQL Query 4
SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS order_frequency,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS total_spending
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name
    ORDER BY total_spending DESC

-- SQL Query 5
SELECT
        p.category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            )
            / COUNT(DISTINCT o.order_id),
            2
        ) AS average_order_value
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY average_order_value DESC

-- SQL Query 6
SELECT
        p.category,
        ROUND(AVG(oi.discount), 2) AS average_discount
    FROM order_items oi
    INNER JOIN products p
        ON oi.product_id = p.product_id
    INNER JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY average_discount DESC

-- SQL Query 7
SELECT
        p.category,
        COUNT(DISTINCT CASE
            WHEN o.order_status = 'Returned'
            THEN o.order_id
        END) * 100.0
        / COUNT(DISTINCT o.order_id) AS return_rate
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category
    ORDER BY return_rate DESC

-- SQL Query 8
SELECT
        p.category,
        ROUND(
            SUM(oi.quantity) * 1.0
            / COUNT(DISTINCT o.order_id),
            2
        ) AS average_quantity_per_order
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY average_quantity_per_order DESC

-- SQL Query 9
SELECT
        p.category,
        ROUND(
            AVG(
                (
                    oi.quantity * p.selling_price
                    - (
                        oi.quantity
                        * p.selling_price
                        * oi.discount / 100.0
                    )
                    - oi.quantity * p.cost_price
                )
                /
                NULLIF(
                    oi.quantity * p.selling_price
                    - (
                        oi.quantity
                        * p.selling_price
                        * oi.discount / 100.0
                    ),
                    0
                ) * 100
            ),
            2
        ) AS average_profit_margin
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY average_profit_margin DESC

-- SQL Query 10
SELECT
        CAST(strftime('%m', order_date) AS INTEGER) AS order_month,
        COUNT(DISTINCT order_id) AS delivered_orders
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY order_month
    ORDER BY order_month

-- SQL Query 11
SELECT
        CAST(strftime('%m', o.order_date) AS INTEGER) AS order_month,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            )
            / COUNT(DISTINCT o.order_id),
            2
        ) AS average_order_value
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY order_month
    ORDER BY order_month

-- SQL Query 12
SELECT
        CAST(strftime('%m', o.order_date) AS INTEGER) AS order_month,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            )
            / COUNT(DISTINCT o.order_id),
            2
        ) AS average_order_value

    FROM orders o

    INNER JOIN order_items oi
        ON o.order_id = oi.order_id

    INNER JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.order_status = 'Delivered'

    GROUP BY order_month

    ORDER BY order_month

-- SQL Query 13
SELECT
        CAST(strftime('%m', order_date) AS INTEGER) AS order_month,

        ROUND(
            SUM(
                CASE
                    WHEN order_status = 'Cancelled'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
            / COUNT(order_id),
            2
        ) AS cancellation_rate

    FROM orders

    GROUP BY order_month

    ORDER BY order_month

-- SQL Query 14
SELECT
        CAST(strftime('%m', order_date) AS INTEGER) AS order_month,

        ROUND(
            SUM(
                CASE
                    WHEN order_status = 'Returned'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
            / COUNT(order_id),
            2
        ) AS return_rate

    FROM orders

    GROUP BY order_month

    ORDER BY order_month

-- SQL Query 15
SELECT
        p.category,
        COUNT(DISTINCT o.order_id) AS delivered_orders
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY delivered_orders DESC

-- SQL Query 16
SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity) AS delivered_quantity
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
    ORDER BY delivered_quantity DESC
    LIMIT 10

-- SQL Query 17
SELECT
        p.category,
        ROUND(AVG(p.selling_price), 2) AS average_selling_price
    FROM products p
    GROUP BY p.category
    ORDER BY average_selling_price DESC

-- SQL Query 18
SELECT
        p.category,
        ROUND(AVG(p.cost_price), 2) AS average_cost_price
    FROM products p
    GROUP BY p.category
    ORDER BY average_cost_price DESC

-- SQL Query 19
SELECT
        p.category,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - (
                    oi.quantity * p.cost_price
                )
            )
            / COUNT(DISTINCT o.order_id),
            2
        ) AS average_profit_per_order

    FROM orders o

    INNER JOIN order_items oi
        ON o.order_id = oi.order_id

    INNER JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.order_status = 'Delivered'

    GROUP BY p.category

    ORDER BY average_profit_per_order DESC

-- SQL Query 20
SELECT
        p.category,
        ROUND(
            SUM(
                oi.quantity
                * p.selling_price
                * oi.discount / 100.0
            ),
            2
        ) AS total_discount_amount
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY total_discount_amount DESC

-- SQL Query 21
SELECT
        purchased AS purchase_status,
        ROUND(AVG(session_duration), 2) AS average_session_duration
    FROM website_activity
    GROUP BY purchased
    ORDER BY average_session_duration DESC

-- SQL Query 22
SELECT
        purchased AS purchase_status,
        ROUND(AVG(pages_viewed), 2) AS average_pages_viewed
    FROM website_activity
    GROUP BY purchased
    ORDER BY average_pages_viewed DESC

-- SQL Query 23
SELECT
        p.price_category,
        ROUND(AVG(oi.discount), 2) AS average_discount
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.price_category
    ORDER BY average_discount DESC

-- SQL Query 24
SELECT
        device,
        purchased AS purchase_status,
        ROUND(AVG(session_duration), 2) AS average_session_duration
    FROM website_activity
    GROUP BY device, purchased
    ORDER BY device, purchased

-- SQL Query 25
SELECT
        device,
        purchased AS purchase_status,
        ROUND(AVG(pages_viewed), 2) AS average_pages_viewed
    FROM website_activity
    GROUP BY device, purchased
    ORDER BY device, purchased

-- SQL Query 26
SELECT
        device,
        engagement_level,
        ROUND(AVG(session_duration), 2) AS average_session_duration
    FROM website_activity
    GROUP BY device, engagement_level
    ORDER BY device, engagement_level

-- SQL Query 27
SELECT
        device,
        engagement_level,
        ROUND(AVG(pages_viewed), 2) AS average_pages_viewed
    FROM website_activity
    GROUP BY device, engagement_level
    ORDER BY device, engagement_level

-- SQL Query 28
SELECT
        CAST(strftime('%m', o.order_date) AS INTEGER) AS order_month,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - oi.quantity * p.cost_price
            ),
            2
        ) AS delivered_profit

    FROM orders o

    INNER JOIN order_items oi
        ON o.order_id = oi.order_id

    INNER JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.order_status = 'Delivered'

    GROUP BY order_month

    ORDER BY order_month

-- SQL Query 29
SELECT
        oi.quantity,
        oi.discount,
        p.selling_price,
        p.cost_price,
        (
            oi.quantity * p.selling_price
            - (
                oi.quantity
                * p.selling_price
                * oi.discount / 100.0
            )
            - oi.quantity * p.cost_price
        ) AS profit,

        CASE
            WHEN p.selling_price > 0
            THEN
                (
                    (
                        oi.quantity * p.selling_price
                        - (
                            oi.quantity
                            * p.selling_price
                            * oi.discount / 100.0
                        )
                        - oi.quantity * p.cost_price
                    )
                    /
                    (
                        oi.quantity * p.selling_price
                        - (
                            oi.quantity
                            * p.selling_price
                            * oi.discount / 100.0
                        )
                    )
                ) * 100
        END AS profit_margin

    FROM order_items oi

    INNER JOIN products p
        ON oi.product_id = p.product_id

    INNER JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'Delivered'

-- SQL Query 30
SELECT
        order_status,
        payment_method,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY order_status, payment_method
    ORDER BY order_status, payment_method

-- SQL Query 31
SELECT
        o.order_status,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS order_value
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status IN ('Delivered', 'Returned')
    GROUP BY o.order_id, o.order_status

-- SQL Query 32
SELECT
        p.category,
        (
            oi.quantity * p.selling_price
            - (
                oi.quantity
                * p.selling_price
                * oi.discount / 100.0
            )
            - oi.quantity * p.cost_price
        ) AS profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'

-- SQL Query 33
SELECT
        order_status,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY order_status
    ORDER BY order_count DESC

-- SQL Query 34
SELECT
        payment_method,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN order_status = 'Delivered' THEN 1
                ELSE 0
            END
        ) AS delivered_orders
    FROM orders
    GROUP BY payment_method
    ORDER BY payment_method

-- SQL Query 35
SELECT
        payment_method,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN order_status = 'Returned' THEN 1
                ELSE 0
            END
        ) AS returned_orders
    FROM orders
    GROUP BY payment_method
    ORDER BY payment_method

-- SQL Query 36
SELECT
        payment_method,
        SUM(
            CASE
                WHEN order_status = 'Delivered' THEN 1
                ELSE 0
            END
        ) AS delivered_orders
    FROM orders
    GROUP BY payment_method
    ORDER BY payment_method

-- SQL Query 37
SELECT
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN order_status IN ('Cancelled', 'Returned')
                THEN 1
                ELSE 0
            END
        ) AS non_delivered_orders
    FROM orders

-- 16.1 Total Delivered Sales
SELECT
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS total_delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'

-- 16.2 Delivered Sales by Product Category
SELECT
        p.category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY delivered_sales DESC

-- 16.3 Top 10 Products by Delivered Sales
SELECT
        p.product_id,
        p.product_name,
        p.category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
    ORDER BY delivered_sales DESC
    LIMIT 10

-- 16.4 Delivered Profit by Product Category
SELECT
        p.category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - oi.quantity * p.cost_price
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
    ORDER BY delivered_profit DESC

-- 16.5 Order Status Distribution
SELECT
        order_status,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY order_status
    ORDER BY order_count DESC

-- 16.6 Delivered Sales by Payment Method
SELECT
        o.payment_method,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.payment_method
    ORDER BY delivered_sales DESC

-- 16.7 Top 10 Customers by Delivered Sales
SELECT
        c.customer_id,
        c.customer_name,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name
    ORDER BY delivered_sales DESC
    LIMIT 10

-- 16.8 Delivered Sales by Customer Segment
SELECT
        c.customer_segment,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_segment
    ORDER BY delivered_sales DESC

-- 16.9 Delivered Profit by Customer Segment
SELECT
        c.customer_segment,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - oi.quantity * p.cost_price
            ),
            2
        ) AS delivered_profit
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_segment
    ORDER BY delivered_profit DESC

-- 16.10 Average Delivered Order Value by Customer Segment
SELECT
        c.customer_segment,
        ROUND(
            AVG(
                order_value
            ),
            2
        ) AS avg_delivered_order_value
    FROM (
        SELECT
            o.order_id,
            o.customer_id,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            o.customer_id
    ) AS order_totals
    INNER JOIN customers c
        ON order_totals.customer_id = c.customer_id
    GROUP BY c.customer_segment
    ORDER BY avg_delivered_order_value DESC

-- 16.11 Delivered Orders by Customer Segment
SELECT
        c.customer_segment,
        COUNT(DISTINCT o.order_id) AS delivered_orders
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_segment
    ORDER BY delivered_orders DESC

-- 16.12 Delivered Sales by Product Price Category
SELECT
        p.price_category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.price_category
    ORDER BY delivered_sales DESC

-- 16.13 Delivered Profit by Product Price Category
SELECT
        p.price_category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - oi.quantity * p.cost_price
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.price_category
    ORDER BY delivered_profit DESC

-- 16.14 Delivered Orders by Payment Method
SELECT
        payment_method,
        COUNT(*) AS delivered_orders
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY payment_method
    ORDER BY delivered_orders DESC

-- 16.15 Delivered Sales by Payment Method and Customer Segment
SELECT
        o.payment_method,
        c.customer_segment,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        o.payment_method,
        c.customer_segment
    ORDER BY delivered_sales DESC

-- 16.16 Monthly Delivered Sales
SELECT
        strftime('%Y-%m', o.order_date) AS order_month,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY strftime('%Y-%m', o.order_date)
    ORDER BY order_month

-- 16.17 Monthly Delivered Profit
SELECT
        strftime('%Y-%m', o.order_date) AS order_month,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
                - oi.quantity * p.cost_price
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY strftime('%Y-%m', o.order_date)
    ORDER BY order_month

-- 16.18 Monthly Delivered Order Count
SELECT
        strftime('%Y-%m', order_date) AS order_month,
        COUNT(*) AS delivered_orders
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY strftime('%Y-%m', order_date)
    ORDER BY order_month

-- 16.19 Average Delivered Order Value by Month
SELECT
        order_month,
        ROUND(AVG(order_value), 2) AS avg_delivered_order_value
    FROM (
        SELECT
            o.order_id,
            strftime('%Y-%m', o.order_date) AS order_month,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            strftime('%Y-%m', o.order_date)
    ) AS monthly_orders
    GROUP BY order_month
    ORDER BY order_month

-- 16.20 Monthly Cancellation and Return Rate
SELECT
        strftime('%Y-%m', order_date) AS order_month,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
        SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
        ROUND(
            100.0 * SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
            / COUNT(*),
            2
        ) AS cancellation_rate,
        ROUND(
            100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END)
            / COUNT(*),
            2
        ) AS return_rate
    FROM orders
    GROUP BY strftime('%Y-%m', order_date)
    ORDER BY order_month

-- 16.21 Monthly Delivered Sales and Profit
SELECT
        strftime('%Y-%m', o.order_date) AS order_month,

        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales,

        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit

    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.order_status = 'Delivered'

    GROUP BY strftime('%Y-%m', o.order_date)
    ORDER BY order_month

-- 16.22 Monthly Delivered Profit Margin
SELECT
        order_month,
        delivered_sales,
        delivered_profit,
        ROUND(
            100.0 * delivered_profit / delivered_sales,
            2
        ) AS profit_margin
    FROM (
        SELECT
            strftime('%Y-%m', o.order_date) AS order_month,

            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS delivered_sales,

            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ) AS delivered_profit

        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id

        WHERE o.order_status = 'Delivered'

        GROUP BY strftime('%Y-%m', o.order_date)
    ) AS monthly_profit

    ORDER BY order_month

-- 16.23 Delivered Sales by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.sub_category
    ORDER BY delivered_sales DESC

-- 16.24 Delivered Profit by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.sub_category
    ORDER BY delivered_profit DESC

-- 16.25 Average Profit Margin by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            100.0 * SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            )
            /
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                )
            ),
            2
        ) AS profit_margin
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.sub_category
    ORDER BY profit_margin DESC

-- 16.26 Delivered Quantity by Product Sub-Category
SELECT
        p.sub_category,
        SUM(oi.quantity) AS delivered_quantity
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.sub_category
    ORDER BY delivered_quantity DESC

-- 16.27 Average Delivered Order Quantity by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            AVG(oi.quantity),
            2
        ) AS avg_quantity_per_order
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.sub_category
    ORDER BY avg_quantity_per_order DESC

-- 16.28 Average Delivered Sales per Order by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            AVG(order_value),
            2
        ) AS avg_delivered_sales_per_order
    FROM (
        SELECT
            o.order_id,
            oi.product_id,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            oi.product_id
    ) AS order_subcategory_sales
    INNER JOIN products p
        ON order_subcategory_sales.product_id = p.product_id
    GROUP BY p.sub_category
    ORDER BY avg_delivered_sales_per_order DESC

-- 16.29 Average Delivered Profit per Order by Product Sub-Category
SELECT
        p.sub_category,
        ROUND(
            AVG(order_profit),
            2
        ) AS avg_delivered_profit_per_order
    FROM (
        SELECT
            o.order_id,
            oi.product_id,
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ) AS order_profit
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            oi.product_id
    ) AS order_subcategory_profit
    INNER JOIN products p
        ON order_subcategory_profit.product_id = p.product_id
    GROUP BY p.sub_category
    ORDER BY avg_delivered_profit_per_order DESC

-- 16.30 Delivered Sales by Product Sub-Category and Price Category
SELECT
        p.sub_category,
        p.price_category,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.sub_category,
        p.price_category
    ORDER BY
        p.sub_category,
        delivered_sales DESC

-- 16.31 Delivered Profit by Product Sub-Category and Price Category
SELECT
        p.sub_category,
        p.price_category,
        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.sub_category,
        p.price_category
    ORDER BY
        p.sub_category,
        delivered_profit DESC

-- 16.32 Delivered Quantity by Product Sub-Category and Price Category
SELECT
        p.sub_category,
        p.price_category,
        SUM(oi.quantity) AS delivered_quantity
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.sub_category,
        p.price_category
    ORDER BY
        p.sub_category,
        delivered_quantity DESC

-- 16.33 Average Profit Margin by Product Sub-Category and Price Category
SELECT
        p.sub_category,
        p.price_category,
        ROUND(
            100.0 * SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            )
            /
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                )
            ),
            2
        ) AS profit_margin
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.sub_category,
        p.price_category
    ORDER BY
        p.sub_category,
        profit_margin DESC

-- 16.34 Delivered Sales by Product Category and Customer Segment
SELECT
        p.category,
        c.customer_segment,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment
    ORDER BY
        p.category,
        delivered_sales DESC

-- 16.35 Delivered Profit by Product Category and Customer Segment
SELECT
        p.category,
        c.customer_segment,
        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment
    ORDER BY
        p.category,
        delivered_profit DESC

-- 16.36 Delivered Quantity by Product Category and Customer Segment
SELECT
        p.category,
        c.customer_segment,
        SUM(oi.quantity) AS delivered_quantity
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment
    ORDER BY
        p.category,
        delivered_quantity DESC

-- 16.37 Average Profit Margin by Product Category and Customer Segment
SELECT
        p.category,
        c.customer_segment,
        ROUND(
            100.0 * SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            )
            /
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                )
            ),
            2
        ) AS profit_margin
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment
    ORDER BY
        p.category,
        profit_margin DESC

-- 16.38 Average Delivered Order Value by Product Category and Customer Segment
SELECT
        p.category,
        c.customer_segment,
        ROUND(
            AVG(order_value),
            2
        ) AS avg_delivered_order_value
    FROM (
        SELECT
            o.order_id,
            o.customer_id,
            oi.product_id,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            o.customer_id,
            oi.product_id
    ) AS order_category_sales
    INNER JOIN customers c
        ON order_category_sales.customer_id = c.customer_id
    INNER JOIN products p
        ON order_category_sales.product_id = p.product_id
    GROUP BY
        p.category,
        c.customer_segment
    ORDER BY
        p.category,
        avg_delivered_order_value DESC

-- 16.39 Delivered Sales by Product Category and Payment Method
SELECT
        p.category,
        o.payment_method,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        o.payment_method
    ORDER BY
        p.category,
        delivered_sales DESC

-- 16.40 Delivered Profit by Product Category and Payment Method
SELECT
        p.category,
        o.payment_method,
        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        o.payment_method
    ORDER BY
        p.category,
        delivered_profit DESC

-- 16.41 Average Profit Margin by Product Category and Payment Method
SELECT
        p.category,
        o.payment_method,
        ROUND(
            100.0 * SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            )
            /
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                )
            ),
            2
        ) AS profit_margin
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        o.payment_method
    ORDER BY
        p.category,
        profit_margin DESC

-- 16.42 Delivered Quantity by Product Category and Payment Method
SELECT
        p.category,
        o.payment_method,
        SUM(oi.quantity) AS delivered_quantity
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        o.payment_method
    ORDER BY
        p.category,
        delivered_quantity DESC

-- 16.43 Average Delivered Order Value by Product Category and Payment Method
SELECT
        category,
        payment_method,
        ROUND(
            AVG(order_value),
            2
        ) AS avg_delivered_order_value
    FROM (
        SELECT
            o.order_id,
            o.payment_method,
            p.category,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY
            o.order_id,
            o.payment_method,
            p.category
    ) AS order_payment_sales
    GROUP BY
        category,
        payment_method
    ORDER BY
        category,
        avg_delivered_order_value DESC

-- 16.44 Delivered Sales by Product Category, Customer Segment, and Payment Method
SELECT
        p.category,
        c.customer_segment,
        o.payment_method,
        ROUND(
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ),
            2
        ) AS delivered_sales
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment,
        o.payment_method
    ORDER BY
        p.category,
        c.customer_segment,
        delivered_sales DESC

-- 16.45 Delivered Profit by Product Category, Customer Segment, and Payment Method
SELECT
        p.category,
        c.customer_segment,
        o.payment_method,
        ROUND(
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ),
            2
        ) AS delivered_profit
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment,
        o.payment_method
    ORDER BY
        p.category,
        c.customer_segment,
        delivered_profit DESC

-- 16.46 Average Profit Margin by Product Category, Customer Segment, and Payment Method
SELECT
        p.category,
        c.customer_segment,
        o.payment_method,
        ROUND(
            100.0 * SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            )
            /
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                )
            ),
            2
        ) AS profit_margin
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        c.customer_segment,
        o.payment_method
    ORDER BY
        p.category,
        c.customer_segment,
        profit_margin DESC

-- 16.47 Delivered Sales Contribution by Customer Segment
SELECT
        customer_segment,
        ROUND(
            SUM(delivered_sales),
            2
        ) AS delivered_sales,
        ROUND(
            100.0 * SUM(delivered_sales)
            / (
                SELECT SUM(delivered_sales)
                FROM (
                    SELECT
                        c.customer_segment,
                        SUM(
                            oi.quantity * p.selling_price
                            - (
                                oi.quantity
                                * p.selling_price
                                * oi.discount / 100.0
                            )
                        ) AS delivered_sales
                    FROM orders o
                    INNER JOIN customers c
                        ON o.customer_id = c.customer_id
                    INNER JOIN order_items oi
                        ON o.order_id = oi.order_id
                    INNER JOIN products p
                        ON oi.product_id = p.product_id
                    WHERE o.order_status = 'Delivered'
                    GROUP BY c.customer_segment
                ) AS segment_totals
            ),
            2
        ) AS sales_contribution_percentage
    FROM (
        SELECT
            c.customer_segment,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS delivered_sales
        FROM orders o
        INNER JOIN customers c
            ON o.customer_id = c.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY c.customer_segment
    ) AS segment_sales
    GROUP BY customer_segment
    ORDER BY delivered_sales DESC

-- 16.48 Delivered Profit Contribution by Customer Segment
SELECT
        customer_segment,
        ROUND(
            SUM(delivered_profit),
            2
        ) AS delivered_profit,
        ROUND(
            100.0 * SUM(delivered_profit)
            / (
                SELECT SUM(delivered_profit)
                FROM (
                    SELECT
                        c.customer_segment,
                        SUM(
                            oi.quantity
                            * (
                                p.selling_price
                                - (
                                    p.selling_price
                                    * oi.discount / 100.0
                                )
                                - p.cost_price
                            )
                        ) AS delivered_profit
                    FROM orders o
                    INNER JOIN customers c
                        ON o.customer_id = c.customer_id
                    INNER JOIN order_items oi
                        ON o.order_id = oi.order_id
                    INNER JOIN products p
                        ON oi.product_id = p.product_id
                    WHERE o.order_status = 'Delivered'
                    GROUP BY c.customer_segment
                ) AS segment_totals
            ),
            2
        ) AS profit_contribution_percentage
    FROM (
        SELECT
            c.customer_segment,
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ) AS delivered_profit
        FROM orders o
        INNER JOIN customers c
            ON o.customer_id = c.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY c.customer_segment
    ) AS segment_profit
    GROUP BY customer_segment
    ORDER BY delivered_profit DESC

-- 16.49 Delivered Sales vs Profit Contribution by Customer Segment
SELECT
        customer_segment,
        ROUND(delivered_sales, 2) AS delivered_sales,
        ROUND(
            100.0 * delivered_sales / total_sales,
            2
        ) AS sales_contribution_percentage,
        ROUND(delivered_profit, 2) AS delivered_profit,
        ROUND(
            100.0 * delivered_profit / total_profit,
            2
        ) AS profit_contribution_percentage
    FROM (
        SELECT
            c.customer_segment,
            SUM(
                oi.quantity * p.selling_price
                - (
                    oi.quantity
                    * p.selling_price
                    * oi.discount / 100.0
                )
            ) AS delivered_sales,
            SUM(
                oi.quantity
                * (
                    p.selling_price
                    - (
                        p.selling_price
                        * oi.discount / 100.0
                    )
                    - p.cost_price
                )
            ) AS delivered_profit
        FROM orders o
        INNER JOIN customers c
            ON o.customer_id = c.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        INNER JOIN products p
            ON oi.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY c.customer_segment
    ) AS segment_metrics
    CROSS JOIN (
        SELECT
            SUM(delivered_sales) AS total_sales,
            SUM(delivered_profit) AS total_profit
        FROM (
            SELECT
                c.customer_segment,
                SUM(
                    oi.quantity * p.selling_price
                    - (
                        oi.quantity
                        * p.selling_price
                        * oi.discount / 100.0
                    )
                ) AS delivered_sales,
                SUM(
                    oi.quantity
                    * (
                        p.selling_price
                        - (
                            p.selling_price
                            * oi.discount / 100.0
                        )
                        - p.cost_price
                    )
                ) AS delivered_profit
            FROM orders o
            INNER JOIN customers c
                ON o.customer_id = c.customer_id
            INNER JOIN order_items oi
                ON o.order_id = oi.order_id
            INNER JOIN products p
                ON oi.product_id = p.product_id
            WHERE o.order_status = 'Delivered'
            GROUP BY c.customer_segment
        ) AS totals
    ) AS overall_totals
    ORDER BY delivered_sales DESC

-- 16.50 Product Return Rate by Category
SELECT
        p.category,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(
            DISTINCT CASE
                WHEN o.order_status = 'Returned'
                THEN o.order_id
            END
        ) AS returned_orders,
        ROUND(
            100.0
            * COUNT(
                DISTINCT CASE
                    WHEN o.order_status = 'Returned'
                    THEN o.order_id
                END
            )
            / COUNT(DISTINCT o.order_id),
            2
        ) AS return_rate
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category
    ORDER BY return_rate DESC

