#!/usr/bin/env python3

import argparse
from movie_database import database as mdatabase

parser = argparse.ArgumentParser()
parser.add_argument('--get-column', help='Specifies column to print')
parser.add_argument('--title', help='Specifies title')
parser.add_argument('--in-database', action='store_true', help='Prints whether title == in database')
parser.add_argument('database', help='Specifies database-source')

args = parser.parse_args()


if args.in_database:
  print(mdatabase.in_database(args.database, args.title))
elif args.get_column != None:
  row = mdatabase.get_row(args.database, args.title)
  print(row[args.get_column])
else:
  pass

