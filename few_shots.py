few_shots = [
    {'Question': "How many cars do we have left for ford in sedan model and white color?",
     'SQLQuery': "SELECT stock_quantity FROM cars WHERE brand = 'Ford' AND model = 'Sedan' AND color = 'White'",
     'SQLResult': "Result of the SQL query",
     'Answer': "74"},
    {'Question': "How much is the price of the inventory for all SUV model cars?",
     'SQLQuery': "SELECT SUM(price*stock_quantity) FROM cars WHERE model = 'SUV'",
     'SQLResult': "Result of the SQL query",
     'Answer': "34196152.54"},
    {'Question': "If we have to sell all the BMW cars today with discounts applied. How much revenue our store will generate (post discounts)?",
     'SQLQuery': """select sum(a.total_amount * ((100-COALESCE(discounts.pct_discount,0))/100)) as total_revenue from
					(select sum(price*stock_quantity) as total_amount, car_id from cars where brand = 'BMW'
					group by car_id) a left join discounts on a.car_id = discounts.car_id""",
     'SQLResult': "Result of the SQL query",
     'Answer': "61370833.35"},
    {'Question': "How much revenue  our store will generate by selling all Ford cars without discount?",
     'SQLQuery': "SELECT SUM(price * stock_quantity) FROM cars WHERE brand = 'Ford'",
     'SQLResult': "Result of the SQL query",
     'Answer': "42061677"},
    {'Question': "How many red color audi cars we have available?",
     'SQLQuery': "SELECT sum(stock_quantity) FROM cars WHERE brand = 'Audi' AND color = 'Red'",
     'SQLResult': "Result of the SQL query",
     'Answer': "242"}
]
