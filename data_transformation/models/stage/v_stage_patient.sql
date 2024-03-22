
{%- set yaml_metadata -%}
source_model: 'raw_patient'
derived_columns:
  derived_patient_id: 'patient_id'
  uh_data_space_id: '!1'
  uh_src: '!api'
  uh_data_run_id: '!101'
  uh_biz_key_collision_cd: '!56'
  uh_seq_id: '!95'
hashed_columns:
  uh_hk_hub_patient: 'derived_patient_id'
  uh_hk_core_diff:
    is_hashdiff: true
    columns:
      - 'core_active'
      - 'core_gender'
      - 'core_birth_date'
      - 'core_deceased_boolean'
      - 'core_deceased_date_time'
      - 'core_marital_status_code'
  uh_hk_misc_diff:
    is_hashdiff: true
    columns:
      - 'misc_multiple_birth'
      - 'misc_contact'
      - 'misc_communication'
      - 'misc_general_practitioner'
      - 'misc_managing_organization'
      - 'misc_link'
      - 'misc_extension'
  uh_hk_identifier_diff:
    is_hashdiff: true
    columns:
      - 'identifier_use'
      - 'identifier_type_code'
      - 'identifier_system'
      - 'identifier_value'
      - 'identifier_period_start'
      - 'identifier_period_end'
      - 'identifier_assigner'
  uh_hk_name_diff:
    is_hashdiff: true
    columns:
      - 'name_use'
      - 'name_text'
      - 'name_family'
      - 'name_given'
      - 'name_middle'
      - 'name_prefix'
      - 'name_suffix'
      - 'name_period_start'
      - 'name_period_end'
  uh_hk_telecom_diff:
    is_hashdiff: true
    columns:
      - 'telecom_system'
      - 'telecom_value'
      - 'telecom_use'
      - 'telecom_rank'
      - 'telecom_period_start'
      - 'telecom_period_end'
  uh_hk_address_diff:
    is_hashdiff: true
    columns:
      - 'address_use'
      - 'address_type'
      - 'address_text'
      - 'address_line1'
      - 'address_line2'
      - 'address_line3'
      - 'address_line4'
      - 'address_city'
      - 'address_state_code'
      - 'address_postal_code'
      - 'address_country'
      - 'address_period_start'
      - 'address_period_end'
{%- endset -%}




{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


WITH staging AS (
{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
)


  SELECT 
    patient_id,
    cast(core_active as boolean) as core_active,
    cast(core_gender as varchar(40)) as core_gender,
    cast(core_birth_date as date) as core_birth_date,
    cast(core_deceased_boolean as boolean) as core_deceased_boolean,
    cast(core_deceased_date_time as  TIMESTAMP_NTZ(6)) as core_deceased_date_time, 
    cast(core_marital_status_code as varchar(20)) as core_marital_status_code,
    cast(misc_multiple_birth as object) as misc_multiple_birth,
    cast(misc_contact as object) as misc_contact,
    cast(misc_communication as object) as misc_communication,
    cast(misc_general_practitioner as object) as misc_general_practitioner,
    cast(misc_managing_organization as object) as misc_managing_organization,
    cast(misc_link as object) as misc_link,
    cast(misc_extension as object) as misc_extension,
    cast(identifier_use as varchar(40)) as identifier_use,
    cast(identifier_type_code as varchar(20)) as identifier_type_code,
    cast(identifier_system as varchar(100)) as identifier_system,
    cast(identifier_value as varchar(100)) as identifier_value,
    cast(identifier_period_start as TIMESTAMP_NTZ(6)) as identifier_period_start,
    cast(identifier_period_end as TIMESTAMP_NTZ(6)) as identifier_period_end,
    cast(identifier_assigner as object) as identifier_assigner,
    cast(name_use as varchar(40)) as name_use,
    cast(name_text as varchar(300)) as name_text,
    cast(name_family as varchar(300)) as name_family,
    cast(name_given as varchar(300)) as name_given,
    cast(name_middle as varchar(300)) as name_middle,
    cast(name_prefix as varchar(300)) as name_prefix,
    cast(name_suffix as varchar(300)) as name_suffix,
    cast(name_period_start as TIMESTAMP_NTZ(6)) as name_period_start,
    cast(name_period_end as TIMESTAMP_NTZ(6)) as name_period_end,
    cast(telecom_system as varchar(40)) as telecom_system,
    cast(telecom_value as varchar(300)) as telecom_value,
    cast(telecom_use as varchar(40)) as telecom_use,
    cast(telecom_rank as integer) as telecom_rank,
    cast(telecom_period_start as TIMESTAMP_NTZ(6)) as telecom_period_start,
    cast(telecom_period_end as TIMESTAMP_NTZ(6)) as telecom_period_end,
    cast(address_use as varchar(40)) as address_use,
    cast(address_type as varchar(40)) as address_type,
    cast(address_text as varchar(300)) as address_text,
    cast(address_line1 as varchar(100)) as address_line1,
    cast(address_line2 as varchar(100)) as address_line2,
    cast(address_line3 as varchar(100)) as address_line3,
    cast(address_line4 as varchar(100)) as address_line4,
    cast(address_city as varchar(100)) as address_city,
    cast(address_state_code as varchar(100)) as address_state_code,
    cast(address_postal_code as varchar(100)) as address_postal_code,
    cast(address_country as varchar(100)) as address_country,
    cast(address_period_start as TIMESTAMP_NTZ(6)) as address_period_start,
    cast(address_period_end as TIMESTAMP_NTZ(6)) as address_period_end,
    name_resource_type,
    cast(uh_hk_hub_patient as binary(20)) as uh_hk_hub_patient,
    cast(uh_data_space_id as varchar(20)) as uh_data_space_id,
    cast(current_timestamp() as TIMESTAMP_NTZ(6)) as uh_load_dt,
    cast(uh_src as varchar(100)) as uh_src,
    cast(current_timestamp() as TIMESTAMP_NTZ(6)) as uh_applied_dt,
    cast(current_timestamp() as TIMESTAMP_NTZ(6)) as uh_last_updated_dt,
    cast(uh_data_run_id as varchar(40)) as uh_data_run_id,
    cast(uh_biz_key_collision_cd as varchar(20)) as uh_biz_key_collision_cd,
    cast(uh_seq_id as numeric(38,0)) as uh_seq_id,
    cast(uh_hk_address_diff as binary(20)) as uh_hk_address_diff,
    cast(uh_hk_name_diff as binary(20)) as uh_hk_name_diff,
    cast(uh_hk_telecom_diff as binary(20)) as uh_hk_telecom_diff,
    cast(uh_hk_core_diff as binary(20)) as uh_hk_core_diff,
    cast(uh_hk_misc_diff as binary(20)) as uh_hk_misc_diff,
    cast(uh_hk_identifier_diff as binary(20)) as uh_hk_identifier_diff
FROM staging








