
// Define pipe
CREATE OR REPLACE pipe MANAGE_DB.pipes.employee_pipe
auto_ingest = TRUE
AS
COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_folder;

SELECT * FROM OUR_FIRST_DB.PUBLIC.employees limit 10;

// Describe pipe
DESC pipe employee_pipe;
    

// Configure the notifications
-- Execute this query:

DESC pipe employee_pipe;

-- Copy the notification channel value, in my case: arn:aws:sqs:us-east-1:404135062354:sf-snowpipe-AIDAV4GCTVNJIWVAL6QGE-6yjMtgcZKtVWyiJGxfpWyw
-- Select the bucket in AWS Console
-- Let's create a notification event
-- Select the bucket
-- Go to properties
-- Go to event notifications
-- Select create event notification
        -- Give a name
        --Define the prefix with the folder path for the pipe: csv/snowpipe
        --select create for event types "all object create events"

-- Go to destination
-- Select SQS queue
-- Select Enter SQS queue ARN
-- Enter the notification channel value
-- Select save changes

-- So, to prove this, go to the bucket folder and upload a new file
-- Wait one minute, and you will see the changes in the target table

SELECT count(*) FROM OUR_FIRST_DB.PUBLIC.employees;
        
