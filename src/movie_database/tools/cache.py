from datetime import datetime
import json
import os
import sys
import inspect

currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)
import config

path = config.cache_file


def get_database(database):
  """
  Gets database from cache.

  :param database: Database-name
  :return: Database
  """
  with open(path) as json_file:
    data = json.load(json_file)
  
  return data[database]['data']


def get_savedate(database):
  """
  Returns the savedate of a database

  :param database: Database
  :return: Savedate
  """
  with open(path) as json_file:
    data = json.load(json_file)
  
  date_str = data[database]['date']
  return datetime.strptime(date_str.split('.')[0], '%Y-%m-%d %H:%M:%S')


def save_database(database, new_data):
  """
  Saves database to cache.

  :param database: Database-name
  :param new_data: Database-data
  """
  data = {}
  
  try:
    with open(path) as json_file:  
      data = json.load(json_file)
  except:
    pass
  
  newline = {}
  newline['data'] = new_data
  newline['date'] = str(datetime.now())
  
  data[database] = newline
    
  with open(path, 'w') as outfile:  
      json.dump(data, outfile)

