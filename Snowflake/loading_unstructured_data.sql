--First step: Load Raw JSON

create or replace stage manage_db.external_stages.jsonstage
    url='s3://bucketsnowflake-jsondemo';

create or replace file format manage_db.file_formats.jsonformat
    type = json;
    
create or replace table our_first_db.public.json_raw (
    raw_file variant);
    
copy into our_first_db.public.json_raw
    from @manage_db.external_stages.jsonstage
    file_format = manage_db.file_formats.jsonformat
    files = ('HR_data.json');
    
select * from our_first_db.public.json_raw limit 10;


--Second step: Parse & analyse raw JSON

select raw_file:city from our_first_db.public.json_raw limit 10;

select $1:first_name from our_first_db.public.json_raw limit 10; 


select 
raw_file:id::int as id,
raw_file:first_name::string as first_name,
raw_file:last_name::string as last_name,
raw_file:gender::string as gender
from our_first_db.public.json_raw
limit 10;


-- selecting a subfield from a json column
select 
    raw_file:job.salary::int as salary
from our_first_db.public.json_raw
limit 10
;


select 
    raw_file:first_name::string as first_name,
    raw_file:job.salary::int as salary,
    raw_file:job.title::string as title
from our_first_db.public.json_raw
limit 10


;


select 
raw_file:id::int as id,
raw_file:first_name::string as first_name,
coalesce(raw_file:prev_company[0],'no prev_company')::string as prev_company  -- for a list selection
from our_first_db.public.json_raw
limit 10
;

-- creating a table using a json structure


select
raw_file,
raw_file:id::int as id,
raw_file:first_name::string as first_name,
raw_file:spoken_languages[0].language::string as first_language,
raw_file:spoken_languages[0].level::string as level_spoken
from our_first_db.public.json_raw
where raw_file:first_name::string = 'Portia' and raw_file:city::string = 'Bakersfield'
union all
select
raw_file,
raw_file:id::int as id,
raw_file:first_name::string as first_name,
raw_file:spoken_languages[1].language::string as first_language,
raw_file:spoken_languages[1].level::string as level_spoken
from our_first_db.public.json_raw
where raw_file:first_name::string = 'Portia' and raw_file:city::string = 'Bakersfield'
order by id
;



select * 
from our_first_db.public.json_raw, table(flatten(raw_file:spoken_languages)) f
where raw_file:first_name::string = 'Portia' and raw_file:city::string = 'Bakersfield'
;


select 
raw_file:first_name::string as first_name,
f.value:language::string as first_language,
f.value:level::string as level_spoken
from our_first_db.public.json_raw, table(flatten(raw_file:spoken_languages)) f
where raw_file:first_name::string = 'Portia' and raw_file:city::string = 'Bakersfield'
;

create or replace table our_first_db.public.languages as 
select 
raw_file:first_name::string as first_name,
f.value:language::string as first_language,
f.value:level::string as level_spoken
from our_first_db.public.json_raw, table(flatten(raw_file:spoken_languages)) f
;



select * from our_first_db.public.languages limit 10;






