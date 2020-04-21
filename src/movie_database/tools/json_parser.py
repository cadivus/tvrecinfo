if __package__ == None or __package__ == "":
  from sub_json_parser import eplists_de
  from sub_json_parser import csv_file
else:
  from .sub_json_parser import eplists_de
  from .sub_json_parser import csv_file


def get_json(path):
  """
  Gets json from path.

  :param path: Path of json-file
  :return: json-content
  """
  if eplists_de.supports_get_json(path):
    return eplists_de.get_json(path)
  
  if csv_file.supports_get_json(path):
    return csv_file.get_json(path)

