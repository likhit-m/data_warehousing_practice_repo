# 🚀 Project 01: The EPA GHG Emissions Warehouse (2023)
## Status: ✅ Completed

Objective: Transform raw EPA Greenhouse Gas Reporting Program (GHGRP) data into a normalized Star Schema.

Bronze Layer: Raw ingestion of multi-sheet Excel data into Snowflake Internal Stages.

Silver Layer: Data cleaning, type casting, and deduplication using CTEs and Window Functions.

Gold Layer: Implementation of a Star Schema with Surrogate Keys, resolving complex "Fan-out" join traps via composite keys.

Tech Stack: Snowflake, SQL, Python (Jupyter).
