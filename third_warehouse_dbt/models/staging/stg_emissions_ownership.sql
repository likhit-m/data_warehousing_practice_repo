SELECT
    source_id,
    parent_entity_id AS parent_id,
    immediate_source_owner AS source_owner,
    parent_name,
    parent_entity_type AS parent_type,
    overall_share_percent:: FLOAT AS ownership_percent
FROM
    {{ source('climate_trace_steel', 'sources_ownership') }}