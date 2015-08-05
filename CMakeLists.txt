
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(TUIO)

set(VERSION_MAJOR "1")
set(VERSION_MINOR "4")
set(VERSION_PATCH "0")
set(VERSION_ABI 1)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMake
  ${CMAKE_SOURCE_DIR}/CMake/common)
include(GitExternal)

set(TUIO_INCLUDE_NAME TUIO)
include(Common)

common_package(GLUT)
common_package(OpenGL)
common_package(SDL)
common_package_post()

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

set(TUIO_PUBLIC_HEADERS
  TUIO/TuioClient.h
  TUIO/TuioContainer.h
  TUIO/TuioCursor.h
  TUIO/TuioListener.h
  TUIO/TuioObject.h
  TUIO/TuioPoint.h
  TUIO/TuioServer.h
  TUIO/TuioTime.h
)

set(TUIO_SOURCES
  TUIO/TuioClient.cpp
  TUIO/TuioServer.cpp
  TUIO/TuioTime.cpp
)

set(OSC_PUBLIC_HEADERS
  oscpack/osc/MessageMappingOscPacketListener.h
  oscpack/osc/OscOutboundPacketStream.h
  oscpack/osc/OscReceivedElements.h
  oscpack/osc/OscException.h
  oscpack/osc/OscPacketListener.h
  oscpack/osc/OscTypes.h
  oscpack/osc/OscHostEndianness.h
  oscpack/osc/OscPrintReceivedElements.h
  oscpack/ip/IpEndpointName.h
  oscpack/ip/NetworkingUtils.h
  oscpack/ip/PacketListener.h
  oscpack/ip/TimerListener.h
  oscpack/ip/UdpSocket.h
)

set(OSC_SOURCES
  oscpack/osc/OscTypes.cpp
  oscpack/osc/OscOutboundPacketStream.cpp
  oscpack/osc/OscReceivedElements.cpp
  oscpack/osc/OscPrintReceivedElements.cpp
)

if(MSVC)
  list(APPEND OSC_SOURCES
    oscpack/ip/win32/NetworkingUtils.cpp
    oscpack/ip/win32/UdpSocket.cpp
  )
else()
  list(APPEND OSC_SOURCES
    oscpack/ip/posix/NetworkingUtils.cpp
    oscpack/ip/posix/UdpSocket.cpp
  )
endif()

set(OSC_INCLUDE_NAME osc)
set(OSC_LIBRARY_TYPE SHARED STATIC)
set(OSC_OMIT_CHECK_TARGETS ON)
common_library(OSC)

set(TUIO_LINK_LIBRARIES OSC)
if(MSVC)
  list(APPEND TUIO_LINK_LIBRARIES mswsock winmm ws2_32)
else()
  list(APPEND TUIO_LINK_LIBRARIES pthread)
endif()
set(TUIO_LIBRARY_TYPE SHARED STATIC)
set(TUIO_INCLUDE_NAME TUIO)
set(TUIO_OMIT_CHECK_TARGETS ON)
common_library(TUIO)

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

include(PackageConfig)
