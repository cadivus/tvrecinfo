import json
import requests

class Webcache:
  """
  A simple cache for webcontent.
  """
  def __init__(self):
    self.textcache = {}
    self.jsoncache = {}

  def get_json(self, url):
    """
    Gets json from web.

    :param url: url
    :return: json
    """
    try:
      test = self.jsoncache[url]
    except KeyError as e:
      r = requests.get(url)
      json_r = r.json()
      self.jsoncache[url] = json_r
    return self.jsoncache[url]


  def get_text(self, url):
    """
    Gets text from web.

    :param url: url
    :return: text
    """
    try:
      test = self.textcache[url]
    except KeyError as e:
      r = requests.get(url)
      text_r = r.text
      self.textcache[url] = text_r
    return self.textcache[url]


"""
A Webcache-instance for global use
"""
_webcache = Webcache()

def get_json(url):
  return _webcache.get_json(url)

def get_text(url):
  return _webcache.get_text(url)

