SELECT * except( Salesperson, List_Price, Actual_Price, Discount__ )
FROM `item-sales.household.item_sales_detail` 
LIMIT 1000