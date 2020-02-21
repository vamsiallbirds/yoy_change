-- eComm sales with stores
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth, sum(gross_sales_usd) from fact_sales
where profit_center_country = 'United States'
and happened_at_local_date between '2018-01-01' and '2019-02-15'
and sales_channel in ('eCommerce')
and left(shipping_postal_code, 5) in
(select distinct left(postal_code, 5) from dma_to_zip_mapping where dma in 
(
'New York',
  'San Francisco - Oakland - San Jose',
  'Boston',
  'Seattle - Tacoma',
  'Chicago',
  'Los Angeles'  
))
group by 1
order by 1


-- eComm sales without stores;
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth, sum(gross_sales_usd) from fact_sales
where profit_center_country = 'United States'
and happened_at_local_date between '2019-01-01' and '2020-02-15'
and sales_channel in ('eCommerce')
and left(shipping_postal_code, 5) in
(select distinct left(postal_code, 5) from dma_to_zip_mapping where dma not in 
(
'New York',
  'San Francisco - Oakland - San Jose',
  'Boston',
  'Seattle - Tacoma',
  'Chicago',
  'Los Angeles'  
))
group by 1
order by 1



-- nca with stores
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth, count(distinct customer_id) from fact_sales
where profit_center_country = 'United States'
and happened_at_local_date between '2019-01-01' and '2020-02-15'
and sales_channel in ('eCommerce')
and is_new_customer = 'TRUE'
and left(shipping_postal_code, 5) in
(select distinct left(postal_code, 5) from dma_to_zip_mapping where dma in 
(
'New York',
  'San Francisco - Oakland - San Jose',
  'Boston',
  'Seattle - Tacoma',
  'Chicago',
  'Los Angeles'  
))
group by 1
order by 1


-- nca without stores;
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth, count(distinct customer_id) from fact_sales
where profit_center_country = 'United States'
and happened_at_local_date between '2019-01-01' and '2020-02-15'
and sales_channel in ('eCommerce')
and is_new_customer = 'TRUE'
and left(shipping_postal_code, 5) in
(select distinct left(postal_code, 5) from dma_to_zip_mapping where dma not in 
(
'New York',
  'San Francisco - Oakland - San Jose',
  'Boston',
  'Seattle - Tacoma',
  'Chicago',
  'Los Angeles'  
))
group by 1
order by 1



-- visits with stores
select year(date) || right(0 || month(date), 2) as yearmonth, count(distinct visit_id, visitor_id, visit_start_time) as sessions from fivetran.google_analytics_360.ga_session
WHERE GEO_NETWORK_COUNTRY = 'United States'
and date between '2019-01-01' and '2020-02-15'
and
geo_network_metro in
(
'New York, NY',
  'New York NY',
  'San Francisco-Oakland-San Jose CA',
  'Boston MA-Manchester NH',
  'Seattle-Tacoma WA',
  'Chicago IL',
  'Los Angeles CA'  
)
group by 1
order by 1
;

show columns in fivetran.google_analytics_360.ga_session
select distinct PAGE_HOSTNAME in fivetran.google_analytics_360.session_hit


-- visits without stores
select year(date) || right(0 || month(date), 2) as yearmonth, count(distinct visit_id, visitor_id, visit_start_time) as sessions from fivetran.google_analytics_360.ga_session
WHERE GEO_NETWORK_COUNTRY = 'United States'
and date between '2018-01-01' and '2019-02-15'
and
geo_network_metro not in
(
'New York, NY',
  'New York NY',
  'San Francisco-Oakland-San Jose CA',
  'Boston MA-Manchester NH',
  'Seattle-Tacoma WA',
  'Chicago IL',
  'Los Angeles CA'  
)
group by 1
order by 1
;



-- Retail DMAs with stores;
-- nca
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth,
count(distinct customer_id) from fact_sales
where is_new_customer = 'TRUE'
and profit_center_country = 'United States'
and happened_at_local_date between '2019-01-01' and '2020-02-15'
and profit_center_name in
('B&M Door, US, Boston 1',
'B&M Door2, US, SF 2',
'B&M Door, US, NY 1',
'B&M Door, US, Seattle 1',
'B&M Door, US, SF, 1',
'B&M Door, US, LA 1',
'B&M Door, US, Chicago 1')
group by 1
order by 1
;

-- Retail DMAs with stores;
-- sales 
select year(happened_at_local_date) || right(0 || month(happened_at_local_date), 2) as yearmonth,
sum(gross_sales_usd) from fact_sales
where
profit_center_country = 'United States'
and happened_at_local_date between '2019-01-01' and '2020-02-15'
and profit_center_name in
('B&M Door, US, Boston 1',
'B&M Door2, US, SF 2',
'B&M Door, US, NY 1',
'B&M Door, US, Seattle 1',
'B&M Door, US, SF, 1',
'B&M Door, US, LA 1',
'B&M Door, US, Chicago 1')
group by 1
order by 1
;
