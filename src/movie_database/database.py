import datetime

if __package__ is None or __package__ is "":
  from tools import cache
  from tools import json_parser
  from tools import database_comparator
  import config
else:
  from .tools import cache
  from .tools import json_parser
  from .tools import database_comparator
  from . import config


def database_from_parser(database):
  """
  Parses database-source

  :param database: Database-source
  :return: Data
  """
  data = json_parser.get_json(database)
  try:
    cache.save_database(database, data)
  except:
    pass
  return data


def get_database(database):
  """
  Returns database-data.

  :param database: Databsae-source
  :return: Data
  """
  try:
    result = cache.get_database(database)
    savedate = cache.get_savedate(database)
    if (datetime.datetime.now() - savedate) > config.refresh_age:
      return database_from_parser(database)
    return result
  except:
    try:
      return database_from_parser(database)
    except:
      return False


def in_database(database, title):
  """
  Checks whether title is in database.

  :param database: Database-source
  :param title: Title
  :return: True/False
  """
  data = get_database(database)
  
  for row in data:
    if database_comparator.compare_titel_from_row(row, title):
      return True
  
  return False


def get_row(database, title):
  """
  Gets row from database for "title"

  :param database: Database-source
  :param title: Title
  :return: Row in database
  """
  data = get_database(database)
  
  for row in data:
    if database_comparator.compare_titel_from_row(row, title):
      return row
  
  return False



