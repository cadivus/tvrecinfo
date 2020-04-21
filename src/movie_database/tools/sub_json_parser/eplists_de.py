"""
Creates json from eplists.de
"""

import csv
import os, sys, inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)
import webcache


def __get_header(url):
  lines = webcache.get_text(url).splitlines()
  reader = csv.reader(lines, delimiter="\t")

  search_name = False

  for row in reader:
    if row[0][0] == '#' and len(row[0]) > 1:
      if search_name == False and row[0][1:].strip() == '/SEASONLIST':
        search_name = True
      elif search_name == True:
        search_name = False
        row[0] = row[0][1:]
        return row
  return False


def get_json(path):
  """
  Gets json from path.

  :param path: Path to json
  :return: json-content
  """
  result = []
  url = path
  colums = __get_header(path)
  lines = webcache.get_text(url).splitlines()
  reader = csv.reader(lines, delimiter="\t")
  search_name = False

  for row in reader:
    if row[0].strip()[0] == '#':
      continue

    newrow = {}
    for x in range(0, len(row)):
      if x >= len(colums):
        continue
      newrow[colums[x]] = row[x]
    
    result.append(newrow)
  return result


def supports_get_json(path):
  """
  Checks, whether json-path == supported for this parser

  :param path: json-path
  :return: True/False
  """
  compare_str = 'https://www.eplists.de/eplist.cgi?'
  return path[:len(compare_str)] == compare_str
