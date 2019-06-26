import os, sys, inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)
import config


def __filter_title_beginning_ending(title):
  for beginning in config.title_filter_beginning:
    if title[:len(beginning)].lower() == beginning.lower():
      title = title[len(beginning):]
      
  for ending in config.title_filter_ending:
    if title[len(ending):].lower() == ending.lower():
      title = title[:len(ending)]
      
  return title


def mod_comp_name(name):
  """
  Modifies filename or table-entry so that they can be compared.

  :param name: String to be modified
  :return: Modified string
  """
  name = __filter_title_beginning_ending(name)

  for x in range(0, ord('0')):
    name = name.replace(chr(x), '')
  for x in range((ord('9') + 1), ord('A')):
    name = name.replace(chr(x), '')
  for x in range((ord('Z') + 1), ord('a')):
    name = name.replace(chr(x), '')
  for x in range((ord('z') + 1), 255):
    name = name.replace(chr(x), '')
  
  for repl in config.title_filter:
    name = name.replace(repl, '')

  return name.lower().strip()

