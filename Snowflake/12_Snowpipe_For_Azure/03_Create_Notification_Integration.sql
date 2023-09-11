-- Go to the Storage account
-- Select queues
-- Create a new queue, for example: snowpipequeue
-- Go to the storage account
-- Select Events
-- Select Create event subscription
-- Give a name, for example snowpipenotification. same for System topic name
-- Select "Blob created" for filter to event types
-- Select "Storage Queues" for Endpoint Type
-- Click on "Select an endpoint"
        -- Select The Storage Account
        -- Select the queue that we already created
-- Select Create and we get an error message, so to solve this:
        -- We go to HOME 
        -- We go to subscriptions
        -- Select the subscription we have 
        -- Select resource providers
        -- Look up Microsoft.EventGrid
        -- Select Microsoft.EventGrid
        -- Click on Register and wait until the status is Registered
--Select the resource group again
-- Select Create
        
        

CREATE OR REPLACE NOTIFICATION INTEGRATION snowpipe_event
  ENABLED = true
  TYPE = QUEUE
  NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
  AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://jdsnowstorageaccount.queue.core.windows.net/snowpipequeue' -- Go to storage_accounts>storage_created>queues>copy the queue URL
  AZURE_TENANT_ID = 'a8e855ef-303a-4a47-816e-c709a721c7df';
  
  
-- Register Integration and grant permissions to snowflake
-- Execute this query:
  
  DESC notification integration snowpipe_event;
  
-- select the value for AZURE_CONSENT_URL and copy it in our browser
-- Then click on Consent on behalf of your organization
-- Select Accept


-- Then we need to assign a role so that our notification integration can view all of the queues that will be stored in our queue storage
  
-- Go to the Storage Account 
-- Select access control (IAM)
-- Select add
-- Select add role assignment
-- Look for Storage Queue Data Contributor
-- Select Next
-- Select "+ Select members"
-- Write the value of AZURE_MULTI_TENANT_APP_NAME that we can get using  DESC notification integration snowpipe_event;





  