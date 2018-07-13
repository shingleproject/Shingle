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
      version='1.2',
      description="An XML aware diff tool",
      author = "The ICOM team and collaborators",
      author_email = "contact@candylab.org",
      url = "http://candylab.org",
      packages = ['dxdiff'],
      scripts=["dxdiff/dxdiff"],
      long_description="""
dxdiff
======

An XML aware diff tool.

Maintained by Dr Adam S. Candy ([http://candylab.org](http://candylab.org "http://candylab.org")) primarily for use with the Shingle Project, see: [http://shingleproject.org](http://shingleproject.org "http://shingleproject.org").

""",
      long_description_content_type='text/markdown',
     )

