SELECT 
    source_id, 
    parent_id, 
    parent_name
FROM {{ ref('stg_emissions_ownership') }}
WHERE ownership_percent IS NULL