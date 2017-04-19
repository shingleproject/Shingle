Shingle
=======

[![Build Status](https://travis-ci.org/shingleproject/Shingle.svg?branch=master)](http://travis-ci.org/shingleproject/Shingle)
[![Python2](https://img.shields.io/badge/python-2-blue.svg)](https://www.python.org/downloads/)
[![PyPI](https://img.shields.io/pypi/v/shingle.svg?maxAge=2592000?style=plastic)](https://pypi.python.org/pypi/shingle/)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.496172.svg)](https://doi.org/10.5281/zenodo.496172)

Generalised self-consistent and automated domain discretisation for multi-scale geophysical models.

![Shingle](./resource/shingle.png?raw=true "Shingle")

Shingle is a generalised and accessible framework for model-independent and self-consistent geophysical domain discretisation, which accurately conform to fractal-like bounds and at varyingly resolved spatial scales. The full heterogeneous set of constraints are necessarily completely described by an extensible, hierarchical formal grammar with an intuitive natural language basis for geophysical domain features to achieve robust reproduction and consistent model intercomparisons.

LibShingle: Computational research software library providing a high-level abstraction to spatial discretisation, or mesh generation, for domains containing complex, fractal-like boundaries that characterise those in numerical simulations of geophysical dynamics.  This is accompanied by a compact, shareable and necessarily complete description of the domain discretisation.

Geophysical model domains typically contain irregular, complex fractal-like boundaries and physical processes that act over a wide range of scales. Constructing geographically constrained boundary-conforming spatial discretisations of these domains with flexible use of anisotropic, fully unstructured meshes is a challenge. The problem contains a wide range of scales and a relatively large, heterogeneous constraint parameter space. Approaches are commonly ad hoc, model or application specific and insufficiently described. Development of new spatial domains is frequently time-consuming, hard to repeat, error prone and difficult to ensure consistent due to the significant human input required. As a consequence, it is difficult to reproduce simulations, ensure a provenance in model data handling and initialisation, and a challenge to conduct model intercomparisons rigorously. Moreover, for flexible unstructured meshes, there is additionally a greater potential for inconsistencies in model initialisation and forcing parameters. This library introduces a consistent approach to unstructured mesh generation for geophysical models, that is automated, quick-to-draft and repeat, and provides a rigorous and robust approach that is consistent to the source data throughout. The approach is enabling further new research in complex multi-scale domains, difficult or not possible to achieve with existing methods.

Outline web page: [http://shingleproject.org](http://shingleproject.org "Shingle")

Further details are provided in the library source and [Shingle project manual](http://homepage.tudelft.nl/w8w0h/4fcf65d8/shingle_manual.pdf "Shingle manual").

For further information and updates, please contact the lead author Dr Adam S. Candy at contact@shingleproject.org.

Example geophysical domains
---------------------------

A selection of geophysical domains where Shingle has been applied to describe and generate geophysical domain spatial discretisation.

![Shingle examples](./resource/shingleexamples.jpg?raw=true "Shingle examples")

Objectives
----------

1. Introduce a consistent approach to the generation of boundary representation to arbitrary geoid bounds.
2. A user-friendly, accessible and extensible framework for model-independent geophysical domain mesh generation.
3. An intuitive, hierarchical formal grammar to fully describe and share the full heterogeneous set of constraints for the spatial discretisation of geophysical model domains.
4. Natural language basis for describing geophysical domain features.
5. Self-consistent, scalable, automated and efficient mesh prototyping.
6. Platform for iterative development that is repeatable, reproducible with a provenance history of generation.
7. Enabling rigorous unstructured mesh generation in general, for a wide range of geophysical applications, in a process that is automated, quick-to-draft and repeat, rigorous and robust, and consistent to the source data throughout.

Verification test engine
------------------------

Includes a selection of examples, from a relatively straight-forward high-level GUI-driven interaction accessible to modellers new to mesh generation, to complex low-level development communicating with the LibShingle library.  Python interaction is used within the source, in generating documentation and in example Jupyter notebooks.

A verification test engine is continuously run in response to source code changes, some of which is tested under [http://travis-ci.org/shingleproject/Shingle](Travis "Travis").

An earlier version of the library Shingle 1.0 is available at: [https://github.com/shingleproject/Shingle1.0](https://github.com/shingleproject/Shingle1.0 "Shingle1.0"), with details on the [Shingle1.0 webpage](http://shingleproject.org/index_shingle1.0.html "Shingle1.0 webpage").


