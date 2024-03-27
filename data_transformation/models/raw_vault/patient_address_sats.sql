{{ config(
    materialized='table', 
    table_type='iceberg', 
    external_volume='S3_EXT_VOL3', 
    catalog='snowflake', 
    base_location=''
) }}

{%- set source_model = "v_stage_patient" -%}
{%- set src_pk = ["uh_hk_hub_patient", "uh_load_dt"] -%}
{%- set src_extra_columns = ["uh_data_space_id", "uh_data_run_id", "uh_applied_dt", "uh_seq_id"] -%}
{%- set src_hashdiff = "uh_hk_address_diff" -%}
{%- set src_payload = ["address_use",
    "address_type",
    "address_text",
    "address_line1",
    "address_line2",
    "address_line3",
    "address_line4",
    "address_city",
    "address_state_code",
    "address_postal_code",
    "address_country",
    "address_period_start",
    "address_period_end"] -%}
{%- set src_source = "uh_src" -%}


{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, 
                   src_source=src_source,
                   source_model=source_model) }}
