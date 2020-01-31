cmake_minimum_required(VERSION 3.10)

include(CTest)
if (BUILD_TESTING)
	enable_testing()
endif()

add_subdirectory(lofar-common)
add_subdirectory(lofar-blob)
add_subdirectory(base-askap)
add_subdirectory(base-logfilters)
add_subdirectory(base-imagemath)
add_subdirectory(base-askapparallel)
add_subdirectory(base-scimath)
add_subdirectory(base-accessors)
add_subdirectory(base-components)
add_subdirectory(yandasoft)

