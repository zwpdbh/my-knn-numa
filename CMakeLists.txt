cmake_minimum_required(VERSION 3.9)
set(CMAKE_CXX_STANDARD 11)


project(my_knn_numa)

set(CMAKE_C_COMPILER /usr/local/Cellar/gcc/7.2.0/bin/gcc-7)
set(CMAKE_CXX_COMPILER /usr/local/Cellar/gcc/7.2.0/bin/g++-7)

set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH  ${CMAKE_BINARY_DIR})

include_directories("/usr/local/include/" "/usr/include" "/usr/local/Cellar/boost/1.65.1/include/boost")
include_directories("/usr/local/Cellar/gcc/7.2.0/lib/gcc/7/gcc/x86_64-apple-darwin17.0.0/7.2.0/include/")
link_directories("/usr/local/lib" "/usr/lib" "/usr/local/Cellar/gcc/7.2.0/lib/gcc/7/")
link_libraries(flann gsl gslcblas rbc gomp)
add_compile_options("-fopenmp")

add_executable(my_knn_numa main.cpp main.h
        common.h
        flann_kdtree_index.h
        flann_kmeans_index.h
        flann_linear_index.h
        csv_parser.cpp
        csv_parser.h
        csv_parser.cpp
        rbc_index.cpp
        rbc_index.h
        sdc_index.cpp
        sdc_index.h)

