select * 
from {{ ref('raw_patient')}} -- this references the model patient_iceberg under Iceberg folder
where address_city is not null



-- 00000-1-3400cc77-84d2-4a01-be27-14b857e49d3b-00001.parquet