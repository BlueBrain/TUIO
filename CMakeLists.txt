
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(TUIO VERSION 1.4.0)
set(TUIO_VERSION_ABI 1)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMake
  ${CMAKE_SOURCE_DIR}/CMake/common)
include(GitExternal)

set(TUIO_INCLUDE_NAME TUIO)
include(Common)

common_find_package(GLUT)
common_find_package(OpenGL)
common_find_package(SDL)
common_find_package_post()

if(NOT MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-result")
else()
  add_definitions(/wd4267)
endif()
if(CMAKE_COMPILER_IS_CLANG)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations")
endif()

add_definitions(-DOSC_HOST_LITTLE_ENDIAN)
include_directories(${CMAKE_CURRENT_LIST_DIR}/TUIO
                    ${CMAKE_CURRENT_LIST_DIR}/oscpack)

add_subdirectory(oscpack)
add_subdirectory(TUIO)

set(TUIODUMP_SOURCES TuioDump.cpp)
set(TUIODUMP_LINK_LIBRARIES TUIO)
set(TUIODUMP_OMIT_CHECK_TARGETS ON)
common_application(TuioDump)

if(GLUT_FOUND AND OPENGL_FOUND AND SDL_FOUND)
  include_directories(${SDL_INCLUDE_DIR})

  set(TUIODEMO_SOURCES TuioDemo.cpp)
  set(TUIODEMO_LINK_LIBRARIES
    TUIO ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES} ${SDL_LIBRARY})
  set(TUIODEMO_OMIT_CHECK_TARGETS ON)
  common_application(TuioDemo)

  set(SIMPLESIMULATOR_SOURCES SimpleSimulator.cpp)
  set(SIMPLESIMULATOR_LINK_LIBRARIES
    TUIO ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES} ${SDL_LIBRARY})
  set(SIMPLESIMULATOR_OMIT_CHECK_TARGETS ON)
  common_application(SimpleSimulator)
endif()

include(CommonPackageConfig)
