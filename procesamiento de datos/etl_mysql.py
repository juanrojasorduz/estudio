import pandas as pd
from datetime import datetime, date
import numpy as np
import math
from pandas.io import sql
from scipy import stats
import pymysql
import sqlalchemy as db

accounts = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/accounts.csv')
city = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/city.csv') 
country = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/country.csv') 
customers = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/customers.csv')
d_month = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/d_month.csv') 
d_time = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/d_time.csv')
d_week = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/d_week.csv')
d_weekday = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/d_weekday.csv')
d_year = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/d_year.csv')
pix_movements = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/pix_movements.csv')
state = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/state.csv')
transfer_ins = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/transfer_ins.csv')
transfer_outs = pd.read_csv('C:/Users/Usuario/Desktop/empresa/original_dataset/transfer_outs.csv')


def date_conversion(fila):
    date = np.array(np.datetime64(fila))
    return date
def dateid_conversion(fila):
    if np.isnan(fila) == False:
        date = np.array(np.datetime64(datetime.fromtimestamp(int(str(fila)[0:10]))))
        return date
    else:
        return np.nan   

products_types = pd.DataFrame(
    {
    'product_type_id' : [102010, 102011, 102012, 102013, 102014, 102015],
    'product_type_name': ['debit card', 'pix', 'credit card', 'life insurance', 'empresa loan card', 'prime subcription empresa'],
    'created_at': ['2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z']
    }
)
products_types['created_at'] = products_types['created_at'].apply(date_conversion)
products_types = products_types.set_index('product_type_id')
products_types.head()
flow_types = pd.DataFrame(
    {
    'flow_type_id' : [0, 1],
    'flow_type_name': ['transfer in', 'transfer out'],
    'created_at': ['2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z']
    }
)
flow_types['created_at'] = flow_types['created_at'].apply(date_conversion)
flow_types = flow_types.set_index('flow_type_id')
flow_types.head()
operations_types = pd.DataFrame(
    {
    'operation_type_id' : [1020, 1021, 1022, 1023, 1024],
    'operation_type_name': ['money transfer', 'monthly life insurance', 'monthly loan payment', 'subscription prime empresa', 'monthly interest payment'],
    'created_at': ['2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z']
    }
)
operations_types['created_at'] = operations_types['created_at'].apply(date_conversion)
operations_types = operations_types.set_index('operation_type_id')
operations_types.head()


clients_types = pd.DataFrame(
    {
    'client_type_id' : [1, 2, 3],
    'client_type_name': ['empresa', 'Partner', 'Customer'],
    'created_at': ['2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z']
    }
)
clients_types['created_at'] = clients_types['created_at'].apply(date_conversion)
clients_types = clients_types.set_index('client_type_id')
clients_types.head()


partners = pd.DataFrame(
    {
    'partner_id' : [103742, 103743, 103744],
    'partner_name': ['empresa', 'Bank of America', 'Banco Brasileño'],
    'country_id': [465471097668177088, 465471097668177088, 465471097668177088],
    'city_id': [2905840547257075712, 2905840547257075712, 2905840547257075712],
    'client_type_id': [1, 2, 2],
    'nit': [213141232, 121244122, 12212414],
    'created_at': ['2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z', '2022-03-31T22:02:48.840Z']    
    }
)
partners['created_at'] = partners['created_at'].apply(date_conversion)
partners = partners.set_index('partner_id')
partners.head()


customers['country_id'] = 465471097668177088
customers['city_id'] = customers['customer_city']
customers['client_type_id'] = 3
customers['created_at'] = '2022-03-31T22:02:48.840Z'
customers['created_at'] = customers['created_at'].apply(date_conversion)
customers = customers[['customer_id','first_name','last_name','country_id','city_id','client_type_id','cpf','created_at']].set_index('customer_id') 
customers.head()

country['created_at'] = '2022-03-31T22:02:48.840Z'
country['created_at'] = country['created_at'].apply(date_conversion)
country['country_name'] = country['country']
countries = country[['country_id','country_name','created_at']].set_index('country_id')
countries.head()


state['state_name'] = state['state']
state['created_at'] = '2022-03-31T22:02:48.840Z'
state['created_at'] = state['created_at'].apply(date_conversion)
states = state[['state_id','state_name','country_id','created_at']].set_index('state_id')
states.head()

city['created_at'] = '2022-03-31T22:02:48.840Z'
city['created_at'] = city['created_at'].apply(date_conversion)
cities = city[['city_id','city','state_id','created_at']].set_index('city_id')
cities.head()

flow_operations_transactions = pd.DataFrame(
    {
    'flow_operation_transaction_id' : [10232101291,10232101292,10232101293,10232101294,10232101295,10232101296,10232101297,10232101298,10232101299,10232101300,10232101301,10232101302,10232101303,10232101304,10232101305,10232101306,10232101307,10232101308,10232101309,10232101310,10232101311,10232101312,10232101313,10232101314],
    'operation_type_id': [1020,1020,1020,1020,1020,1020,1021,1021,1022,1022,1023,1023,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024],
    'flow_type_id': [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
    'product_type_id': [102010,102010,102011,102011,102012,102012,102013,102013,102014,102014,102015,102015,102010,102010,102011,102011,102012,102012,102013,102013,102014,102014,102015,102015]   
    }
)
flow_operations_transactions['created_at'] = '2022-03-31T22:02:48.840Z'
flow_operations_transactions['created_at'] = flow_operations_transactions['created_at'].apply(date_conversion)
flow_operations_transactions = flow_operations_transactions.set_index('flow_operation_transaction_id')
flow_operations_transactions.head()

accounts['client_type_id'] = 3
accounts['client_id'] = accounts['customer_id']
accounts['created_at'] = '2022-03-31T22:02:48.840Z'
accounts['created_at'] = accounts['created_at'].apply(date_conversion)
accounts = accounts[['account_id','client_type_id','client_id','status','account_branch','account_check_digit','account_number','created_at']].set_index('account_id')
accounts.head()

transfer_ins['user_transaction_id'] = transfer_ins['id']
transfer_ins['transaction_requested_at'] = transfer_ins['transaction_requested_at'].apply(dateid_conversion)
transfer_ins['transaction_completed_at'] = transfer_ins['transaction_completed_at'].apply(dateid_conversion)
transfer_ins['created_at'] = '2022-03-31T22:02:48.840Z'
transfer_ins['created_at'] = transfer_ins['created_at'].apply(date_conversion)
transfer_ins['flow_operation_transaction_id'] = 10232101291
transfer_ins = transfer_ins[['user_transaction_id','account_id','amount','flow_operation_transaction_id','transaction_requested_at','transaction_completed_at','status','created_at']].set_index('user_transaction_id')
transfer_ins.head()


transfer_outs['user_transaction_id'] = transfer_outs['id']
transfer_outs['transaction_requested_at'] = transfer_outs['transaction_requested_at'].apply(dateid_conversion)
transfer_outs['transaction_completed_at'] = transfer_outs['transaction_completed_at'].apply(dateid_conversion)
transfer_outs['created_at'] = '2022-03-31T22:02:48.840Z'
transfer_outs['created_at'] = transfer_outs['created_at'].apply(date_conversion)
transfer_outs['flow_operation_transaction_id'] = 10232101292
transfer_outs = transfer_outs[['user_transaction_id','account_id','amount','flow_operation_transaction_id','transaction_requested_at','transaction_completed_at','status','created_at']].set_index('user_transaction_id')
transfer_outs.head()

pix_movements['user_transaction_id'] = pix_movements['id']
pix_movements['transaction_requested_at'] = pix_movements['pix_requested_at'].apply(dateid_conversion)
pix_movements['transaction_completed_at'] = pix_movements['pix_completed_at'].apply(dateid_conversion)
pix_movements['amount'] = pix_movements['pix_amount']
pix_movements['created_at'] = '2022-03-31T22:02:48.840Z'
pix_movements['created_at'] = pix_movements['created_at'].apply(date_conversion)
pix_movements['flow_operation_transaction_id'] = np.where(pix_movements['in_or_out'] == 'pix_in', 10232101293, 10232101294)
pix_movements = pix_movements[['user_transaction_id','account_id','amount','flow_operation_transaction_id','transaction_requested_at','transaction_completed_at','status','created_at']].set_index('user_transaction_id')
pix_movements.head()


users_transactions = pd.concat([transfer_ins, transfer_outs, pix_movements])
users_transactions.head()

database_username = 'root'
database_password = 'Juandiego1603&'
database_ip = 'localhost'
database_name = 'schema_users_transactions'
database_connection = db.create_engine('mysql+pymysql://{0}:{1}@{2}/{3}'.
                                               format(database_username, database_password,
                                                      database_ip, database_name))
connection = database_connection.connect()
metadata = db.MetaData()


products_types.to_sql('products_types', connection)
operations_types.to_sql('operations_types', connection)
flow_types.to_sql('flow_types', connection)
clients_types.to_sql('clients_types', connection)
partners.to_sql('partners', connection)
customers.to_sql('customers', connection)
countries.to_sql('countries', connection)
states.to_sql('states', connection)
cities.to_sql('cities', connection)
flow_operations_transactions.to_sql('flow_operations_transactions', connection)
accounts.to_sql('accounts', connection)
users_transactions.to_sql('users_transactions', connection)


products_types.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/products_types.csv')
operations_types.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/operations_types.csv')
flow_types.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/flow_types.csv')
clients_types.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/clients_types.csv')
partners.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/partners.csv')
customers.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/customers.csv')
countries.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/countries.csv')
states.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/states.csv')
cities.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/cities.csv')
flow_operations_transactions.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/flow_operations_transactions.csv')
accounts.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/accounts.csv')
users_transactions.to_csv('C:/Users/Usuario/Desktop/empresa/new_dataset/users_transactions.csv')
