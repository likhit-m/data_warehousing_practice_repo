# Steel Emissions Attribution Pipeline
### Climate TRACE | dbt + Snowflake | Weighted Attribution

A production-grade dbt project attributing global steel manufacturing emissions to corporate owners using satellite-verified data from Climate TRACE.

---

## Overview

This project solves a core ESG engineering problem: **weighted emissions attribution across multi-owner industrial assets**.

When a steel plant is owned by multiple corporate entities (e.g., 60% ArcelorMittal, 30% government, 10% local partner), how do you split carbon responsibility? This pipeline implements the **GHG Protocol equity share approach** — attributing emissions proportionally by ownership stake.

**Dataset:** Climate TRACE (Climate Tracking Real-time Atmospheric Carbon Emissions)  
**Sector:** Iron and Steel Manufacturing (7–9% of global GHG emissions)  
**Coverage:** 2023–2025, global facility-level data  
**Source:** [Climate TRACE Data Downloads](https://climatetrace.org/data)

---

## What This Project Demonstrates

- **dbt fundamentals**: staging → core → marts architecture, materialisation strategies, `ref()` for lineage
- **Domain-aware engineering**: COALESCE defaults to 100% ownership where data is missing (GHG Protocol Scope 1 attribution rules)
- **Data quality enforcement**: schema tests, singular tests, relationship tests between models
- **Production patterns**: LEFT JOIN to preserve all records, explicit column selection (no SELECT *), custom schema naming macro
- **Analytical thinking**: two mart models answering distinct business questions (corporate accountability, country benchmarking)

---

## Project Structure

```
models/
├── staging/
│   ├── stg_emissions_sources.sql       # Cleaned emissions data (view)
│   ├── stg_emissions_ownership.sql     # Cleaned ownership data (view)
│   └── properties.yml                  # Schema tests + documentation
├── core/
│   ├── fct_steel_emissions_attribution.sql  # Central fact table (table)
│   └── core_properties.yml             # Schema tests + documentation
├── marts/
│   ├── dim_steel_giants.sql            # Corporate accountability rankings (table)
│   ├── country_emissions_benchmarking.sql   # Country-level benchmarking (table)
│   └── marts_properties.yml            # Schema tests + documentation
└── sources.yml                          # Source definitions

tests/
├── assert_emissions_are_positive.sql   # Custom data quality test
└── assert_share_perct_is_not_null.sql  # Custom data quality test

macros/
└── custom_schema_name.sql              # Override dbt's default schema naming
```

---

## Key Models

### `fct_steel_emissions_attribution` (Core Fact Table)
- **Grain:** One row per emission source per parent company ownership record
- **Key Logic:** `COALESCE(ownership_percent, 100)` — defaults to 100% attribution where ownership data is unavailable (GHG Protocol methodology)
- **Join Type:** LEFT JOIN to preserve all emission sources even when ownership data is missing

### `dim_steel_giants` (Mart)
- **Purpose:** Corporate accountability — ranked list of largest steel emitters globally
- **Output:** Dual rankings (global rank, category rank by parent type)
- **Use Case:** NGO reporting, investor analysis, corporate benchmarking

### `country_emissions_benchmarking` (Mart)
- **Purpose:** Policy benchmarking — country-level emissions vs. global average
- **Output:** Total emissions, emissions per asset, variance from global average by year
- **Use Case:** Government sustainability dashboards, industry reports

---

## Tech Stack

- **Warehouse:** Snowflake
- **Transformation:** dbt Core
- **Testing:** dbt schema tests + singular tests
- **Documentation:** dbt docs (auto-generated from YAML descriptions)
- **Version Control:** Git

---

## Data Quality

The project includes comprehensive testing:

- **Uniqueness:** Every `source_id` is unique in both staging models (prevents double-counting)
- **Referential Integrity:** Every ownership record links to an existing emission source
- **Null Checks:** Critical fields flagged with `severity: warn` (flags issues without halting pipeline)
- **Custom Tests:** Positive emissions values, ownership percentages within valid range

Run `dbt test` to execute all tests. Failed tests return non-zero exit code.

---

## Production Improvements (Next Steps)

1. **Incremental Models:** Switch `fct_steel_emissions_attribution` to incremental materialisation for large-scale daily runs
2. **Source Freshness:** Add freshness thresholds to source definitions (alert if data is stale)
3. **CI/CD:** Integrate with dbt Cloud for automated test runs on every pull request

---

## Dataset Citation

Data sourced from Climate TRACE (Climate Tracking Real-time Atmospheric Carbon Emissions):  
https://climatetrace.org/data

Climate TRACE is an independent coalition using satellite data, remote sensing, and machine learning to track facility-level greenhouse gas emissions globally.

---

## Contact

**Built by:** Likhit M.  
**Portfolio:** [Built by Likhit YouTube Channel] https://youtube.com/@built_by_likhit?si=mMfKBV8WLxbcfQ6Q  
**GitHub:** https://github.com/likhit-m/data_warehousing_practice_repo.git

---

*This project is part of a 3-project portfolio series documenting the transition from sustainability professional to analytics engineer. See also: EPA Greenhouse Gas Warehouse (Project 1), E-Commerce Fulfilment Pipeline (Project 2).*