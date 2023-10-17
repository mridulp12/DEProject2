--how many dvds are in stock in each city store.
create or replace table dvd_in_stock as( 
  SELECT
  
    ROW_NUMBER() OVER (ORDER BY "address") AS address_key, -- surrogate key criteria
    r."customer_id",
    da."address",
    da."city",
    da."postal_code",
    count("inventory_id") AS dvd_in_stock --renaming criteria/count criteria
    
FROM
    "AIRBYTE_DATABASE"."DIM_FACT".fct_rental r

LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_customer dc ON r."customer_id" = dc."customer_id" -- join criteria
LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_address da ON dc."address_id" = da."address_id"

GROUP BY r."customer_id", da."address", da."city",da."postal_code" -- group by criteria
);

-- who are the most frequent customer
create or replace table rental_freq_payment as(
 SELECT
     --ROW_NUMBER() OVER (ORDER BY "customer_id") AS customer_key, -- no repeating value but for practise I did it 
    p."customer_id",
    dc."first_name",
    dc."last_name",
    count("payment_id") AS rental_frequency,
    sum("amount") AS total_spent
   
FROM
    "AIRBYTE_DATABASE"."DIM_FACT".fct_payment p

LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_customer dc ON p."customer_id" = dc."customer_id"

GROUP BY p."customer_id",dc."first_name",dc."last_name"
ORDER BY rental_frequency desc
);

--what store makes the most money
create or replace table revenue_per_store as(
  SELECT
    ROW_NUMBER() OVER (ORDER BY "address") AS address_key, -- surrogate key criteria
    dc."customer_id",
    da."address",
    da."city",
    da."postal_code",
    sum("amount") AS total_revenue --renaming criteria/count criteria
     
FROM
    "AIRBYTE_DATABASE"."DIM_FACT".fct_payment p

LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_customer dc ON p."customer_id" = dc."customer_id" -- join criteria
LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_address da ON dc."address_id" = da."address_id"

GROUP BY  dc."customer_id", da."address", da."city",da."postal_code"-- group by criteria
ORDER BY total_revenue desc
);

--which actor is the most popular for renting movies?

create or replace table popular_actor_by_renting as(
  SELECT
    da."first_name",
    da."last_name",
    count("rental_id") AS movies_rented
   
FROM
    "AIRBYTE_DATABASE"."DIM_FACT".fct_rental r

LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_inventory di ON r."inventory_id" = di."inventory_id" -- join criteria
LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_actor da ON di."film_id" = da."film_id"

GROUP BY da."first_name", da."last_name" -- group by criteria
HAVING movies_rented >= 4000

ORDER BY movies_rented desc
);

--Average cost per rental
create or replace table average_rental_price as(

SELECT
  avg("rental_rate") AS Average_Rental_Price
FROM
    "AIRBYTE_DATABASE"."DIM_FACT".fct_rental r

LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_inventory di ON r."inventory_id" = di."inventory_id" -- join criteria
LEFT JOIN  "AIRBYTE_DATABASE"."DIM_FACT".dim_actor da ON di."film_id" = da."film_id"
);
