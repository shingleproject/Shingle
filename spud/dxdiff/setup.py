#!/usr/bin/env python
from setuptools import setup

setup(
      name='dxdiff',
      version='1.3',
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

