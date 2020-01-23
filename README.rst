Yandasoft integrated project
############################

This repository contains a cmake project that is able to build
all yandasoft repositories in a single pass.

Quick start
===========

Go and try to build the single-pass project for a given branch:

.. code-block:: sh

 ./git-do clone -b cmake-improvements
 mkdir build
 cd build
 cmake ..
 make all -j<N>
 make install


Managing individual repositories
================================

Individual repositories are handled as individual git clones
(as opposed to using git submodules).
Using submodules could be an option in the future,
but brings its own set of complications.

To ease somehow the management of these individual repositories
a ``git-do`` tool is provided in this repository
to help cloning the repositories, changing branches,
querying status, and any other task that may be needed
across all repositories.


Building
========

As a single project
-------------------

This repository brings all other repositories together as a single project.
This is useful for building them all in a single pass,
and also for setting up development environments
that include more than one repository.

To build all repositories as a single project
the top-level ``CMakeLists.txt`` file can be used, e.g.:

.. code-block:: sh

 mkdir build
 cd build
 cmake .. -DCMAKE_INSTALL_PREFIX=/tmp/installation -G Ninja
 cmake --build . -j 4                   # build
 cmake --build . --target install -j 4  # install
 ctest                                  # run tests

In the example above, Ninja build files are generated
(instead of the default Makefile ones),
and installation is done on ``/tmp/installation``.

You can also try to use the top-level ``CMakeLists.txt`` file
to setup your IDE for development (see your IDE documentation for this).

Standard cmake options work as usual, and are inherited by all projects.
Some of those are:

* ``BUILD_TESTING`` enables test building and execution.
  If ``ON`` (default) all tests are built, and they can be run
  with ``ctest``.
* ``CMAKE_INSTALL_PREFIX`` is the target installation directory base.
* ``CMAKE_PREFIX_PATH`` contains a ``;``-separated list of directories
  where different dependencies can be found
* ``CMAKE_BUILD_TYPE`` selects the type of build to produce.
  See the cmake documentation for the different values.
* ``CMAKE_CXX_FLAGS`` is used to pass down additional C++ compiler flags.

You can also select a different cmake generator (instead of the default Makefile
generator in Unix) with the ``-G`` option if wanted/required.


As separate projects
--------------------

You can also still build the repositories separately like before, e.g.:

.. code-block:: sh

 common_cmake_opts="-DCMAKE_INSTALL_PREFIX=/tmp/installation ...."
 for repo in lofar-common lofar-blob base-askap base-logfilters base-imagemath base-askapparallel base-scimath base-accessors yandasoft; do
     cd $repo
     mkdir build
     cd build
     cmake ..
     cmake --build . -j 4
     cmake --build . --target install -j 4
     cd ../../
  done
