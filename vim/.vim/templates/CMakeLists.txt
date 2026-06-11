cmake_minimum_required(VERSION 3.13)
set(PROJECT_NAME "my_project")
project(${PROJECT_NAME})
set(CMAKE_CXX_STANDARD 14)

set(SOURCE_FILES main.cpp)
add_executable(${PROJECT_NAME} ${SOURCE_FILES})