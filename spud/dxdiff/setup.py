from distutils.core import setup
import os
import os.path
import glob

try:
  destdir = os.environ["DESTDIR"]
except KeyError:
  destdir = ""

setup(
      name='dxdiff',
      version='1.1',
      description="An XML aware diff tool.",
      author = "The ICOM team and collaborators",
      author_email = "contact@candylab.org",
      url = "http://candylab.org",
      packages = ['dxdiff'],
      scripts=["dxdiff/dxdiff"],
     )

