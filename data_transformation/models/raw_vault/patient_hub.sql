{{ config(
    materialized='table', 
    table_type='iceberg', 
    external_volume='S3_EXT_VOL3', 
    catalog='snowflake', 
    base_location=''
) }}

{%- set source_model = "v_stage_patient" -%}
{%- set src_pk = "uh_hk_hub_patient" -%}
{%- set src_extra_columns = ["uh_data_space_id", "uh_last_updated_dt", "uh_data_run_id", "uh_applied_dt", "uh_biz_key_collision_cd"] -%}
{%- set src_nk = "patient_id" -%}
{%- set src_ldts = "uh_load_dt" -%}
{%- set src_source = "uh_src" -%}

{{ automate_dv.hub(
    src_pk=src_pk, 
    src_nk=src_nk, 
    src_extra_columns=src_extra_columns, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model
) }}

