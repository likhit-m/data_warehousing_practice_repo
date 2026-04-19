{{ config(severity='warn') }}

select
    source_id,
    ownership_percent
from {{ ref('stg_emissions_ownership') }}
where ownership_percent IS NULL