"""
Creates json from csv-file.
"""

import csv
import os, sys, inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)
import webcache


def get_json(filepath):
  """
  Gets json from path.

  :param path: Path to json
  :return: json-content
  """
  result = []
  lines = open(filepath, "r").read().splitlines()
  reader = csv.DictReader(lines, delimiter=',')
  
  for row in reader:
    new_row = {}
    for ri in row.keys():
      new_row[ri] = row[ri]
      
    result.append(new_row)
  return result


def supports_get_json(path):
  """
  Checks, whether json-path is supported for this parser

  :param path: json-path
  :return: True/False
  """
  compare_str = 'https://'
  return path[:len(compare_str)] != compare_str


