if __package__ is None or __package__ is "":
  import comp_name_modify
else:
  from . import comp_name_modify


def compare_strings(string1, string2):
  """
  Compares the modified version of two strings

  :param string1: First string
  :param string2: Second string
  :return: True/False
  """
  string1m = comp_name_modify.mod_comp_name(string1)
  string2m = comp_name_modify.mod_comp_name(string2)
  
  return (string1m == string2m)


def compare_titel_from_row(row, title):
  """
  Checks whether title belong to row.

  :param row: Datarow
  :param title: Title
  :return: True/False
  """
  try:
    string1 = row['Titel']
  except:
    try:
      string1 = row['Title']
    except:
      try:
        string1 = row['titel']
      except:
        try:
          string1 = row['title']
        except:
          return False
  
  return compare_strings(string1, title)
