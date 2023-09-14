-- The maintenance of materialized view has a cost in credits in snowflake
show materialized views;

-- To see costs:
select * from table(information_schema.materialized_view_refresh_history());


