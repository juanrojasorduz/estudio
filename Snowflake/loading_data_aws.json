-- create storage integration 

create or replace storage integration s3_int
type = external_stage
storage_provider = s3
enabled = true
storage_aws_role_arn = 'arn:aws:iam::850740812278:role/awssupport'
storage_allowed_locations = ('s3://bucketfordatajds3/csv/', 's3://bucketfordatajds3/json/')
comment = 'optional';


--See storage integration properties to fetch external_id so we can update it in S3

desc integration s3_int;


------  CSV FILES



--Create table first

create or replace table our_first_db.public.movie_titles (
  show_id string,
  type string,
  title string,
  director string,
  cast string,
  country string,
  date_added string,
  release_year string,
  rating string,
  duration string,
  listed_in string,
  description string
);



--create file format object

create or replace file format manage_db.file_formats.csv_fileformat
type = csv
field_delimiter = ','
skip_header = 1
null_if = ('NULL','null')
empty_field_as_null = true
field_optionally_enclosed_by = '"'
;


--create stage object with integration object & file format object

create or replace stage manage_db.external_stages.csv_folder
url = 's3://bucketfordatajds3/csv/'
storage_integration = s3_int
file_format = manage_db.file_formats.csv_fileformat;


--Use copy command

copy into our_first_db.public.movie_titles
    from @manage_db.external_stages.csv_folder

;

select * from our_first_db.public.movie_titles limit 10

;



------  JSON FILES

--create file format object

create or replace file format manage_db.file_formats.json_fileformat
type = json
;

--create stage object with integration object & file format object

create or replace stage manage_db.external_stages.json_folder
url = 's3://bucketfordatajds3/json/'
storage_integration = s3_int
file_format = manage_db.file_formats.json_fileformat;


select * from @manage_db.external_stages.json_folder;


-- create destination table

create or replace table our_first_db.public.reviews (
asin string,
helpful string,
overall string,
reviewtext string,
reviewtime date,
reviewerid string,
reviewername string,
summary string,
unixreviewtime date
)

;


copy into our_first_db.public.reviews
from (
select
$1:asin::string as asin,
$1:helpful::string as helpful,
$1:overall::string as overall,
$1:reviewText::string as reviewtext, 
date_from_parts(
  right($1:reviewTime::string,4),
  left($1:reviewTime::string,2),  
  case when substring($1:reviewTime::string,5,1)=','
       then substring($1:reviewTime::string,4,1) else substring($1:reviewTime::string,4,2) end) as reviewtime,   
$1:reviewerID::string as reviewerid,
$1:reviewerName::string as reviewername,
$1:summary::string as summary,
date($1:unixReviewTime::int) as unixreviewtime
from @manage_db.external_stages.json_folder s);


select * from our_first_db.public.reviews limit 10;

;

