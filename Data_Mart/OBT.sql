create or replace table OBT as( 
  SELECT
    d.address_key, -- surrogate key criteria
    d."customer_id",
    d."address",
    d."city",
    d."postal_code",
    d.dvd_in_stock,
    rp."first_name",
    rp."last_name",
    rp.rental_frequency,
    rp.total_spent,
    rps.total_revenue
    
FROM
    "AIRBYTE_DATABASE"."DATA_MART".dvd_in_stock d

LEFT JOIN  "AIRBYTE_DATABASE"."DATA_MART".rental_freq_payment rp ON d."customer_id" = rp."customer_id" -- joining rental_freq_payment table with dvd_in_stock
LEFT JOIN  "AIRBYTE_DATABASE"."DATA_MART".revenue_per_store rps ON d."customer_id" = rps."customer_id"
);