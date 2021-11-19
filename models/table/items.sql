SELECT * except( Salesperson, List_Price, Actual_Price, Discount__ )
FROM `item-sales.household.item_sales_detail` 
where item = 'Toaster'
limit 10