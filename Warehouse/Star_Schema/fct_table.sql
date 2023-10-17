create or replace table fct_rental as(
  SELECT
    r."rental_id",
    r."rental_date",
    r."inventory_id",
    r."staff_id",
    r."customer_id",
    da."actor_id",
    dc."store_id",
    dc."address_id"
    
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."rental" r

LEFT JOIN
    "AIRBYTE_DATABASE"."DIM_FACT".dim_inventory i ON r."inventory_id" = i."inventory_id"
LEFT JOIN
    "AIRBYTE_DATABASE"."DIM_FACT".dim_actor da ON i."film_id" = da."film_id"
LEFT JOIN
    "AIRBYTE_DATABASE"."DIM_FACT".dim_customer dc ON r."customer_id" = dc."customer_id"
    
);

create or replace table fct_payment as(
  SELECT
    p."payment_id",
    p."staff_id",
    p."customer_id",
    p."amount",
    dc."store_id",
    dc."address_id"
    
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."payment" p

LEFT JOIN
    "AIRBYTE_DATABASE"."DIM_FACT".dim_customer dc ON p."customer_id" = dc."customer_id"
    
);
