SELECT 
    source_name, 
    country_code, 
    emissions_quantity
FROM {{ ref('stg_emissions_sources') }}
WHERE emissions_quantity <= 0
ORDER BY emissions_quantity ASC