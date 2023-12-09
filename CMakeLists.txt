cmake_minimum_required(VERSION 3.15)

include(cmake/find_opencv.cmake)
auto_find_opencv(ON)

project(cmake_template)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(source)
