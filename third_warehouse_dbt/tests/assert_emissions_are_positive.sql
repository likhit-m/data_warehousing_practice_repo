{{ config(severity='warn') }}

select
    source_id,
    emissions_quantity
from {{ ref('stg_emissions_sources') }}
where emissions_quantity <= 0