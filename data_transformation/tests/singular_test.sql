select * 
from {{ ref('raw_patient')}} -- this references the model patient_iceberg under Iceberg folder
where address_city is not null

