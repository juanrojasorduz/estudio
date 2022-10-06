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

