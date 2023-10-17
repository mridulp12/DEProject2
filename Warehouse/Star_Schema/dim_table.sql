create or replace table dim_customer as(
  SELECT
     --ROW_NUMBER() OVER (ORDER BY "customer_id") AS customer_key, -- no repeating value but for practise I did it 
    "customer_id",
    "store_id",
    "first_name",
    "last_name",
    "active",
    "address_id"
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."customer"

    ORDER BY "customer_id"
);

create or replace table dim_inventory as(
  SELECT
    "inventory_id",
      "film_id",
    "last_update"
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."inventory"

);

create or replace table dim_staff as(
  SELECT
    "staff_id",
     "first_name",
    "last_name",
    "address_id"
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."staff"

);

create or replace table dim_actor as(
  SELECT
    a."actor_id",
    a."first_name",
    a."last_name",
    fa."film_id",
    f."title",
    f."rental_rate"
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."actor" a

JOIN "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."film_actor" fa ON a."actor_id" = fa."actor_id"
LEFT JOIN "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."film" f ON fa."film_id" = f."film_id"
    
);

create or replace table dim_address as(
  SELECT
    da."address_id",
    da."address",
    da."postal_code",
    c."city"
FROM
    "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."address" da

LEFT JOIN "AIRBYTE_DATABASE"."AIRBYTE_SCHEMA"."city" c ON da."city_id" = c."city_id"
 
);
