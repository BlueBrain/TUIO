
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(TUIO)

set(VERSION_MAJOR "1")
set(VERSION_MINOR "4")
set(VERSION_PATCH "0")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake
  ${CMAKE_SOURCE_DIR}/CMake/common)
include(GitExternal)
include(Common)

add_definitions(-DOSC_HOST_LITTLE_ENDIAN)
include_directories(${CMAKE_CURRENT_LIST_DIR}/TUIO
                    ${CMAKE_CURRENT_LIST_DIR}/oscpack)

set(TUIO_HEADERS
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

set(OSC_HEADERS
  oscpack/osc/MessageMappingOscPacketListener.h
  oscpack/osc/OscOutboundPacketStream.h
  oscpack/osc/OscReceivedElements.h
  oscpack/osc/OscException.h
  oscpack/osc/OscPacketListener.h
  oscpack/osc/OscTypes.h
  oscpack/osc/OscHostEndianness.h
  oscpack/osc/OscPrintReceivedElements.h
)

set(OSC_SOURCES
  oscpack/osc/OscTypes.cpp
  oscpack/osc/OscOutboundPacketStream.cpp
  oscpack/osc/OscReceivedElements.cpp
  oscpack/osc/OscPrintReceivedElements.cpp
  oscpack/ip/posix/NetworkingUtils.cpp
  oscpack/ip/posix/UdpSocket.cpp
)

set(IP_HEADERS
  oscpack/ip/IpEndpointName.h
  oscpack/ip/NetworkingUtils.h
  oscpack/ip/PacketListener.h
  oscpack/ip/TimerListener.h
  oscpack/ip/UdpSocket.h
)

add_library(TUIO SHARED ${TUIO_SOURCES} ${OSC_SOURCES})
target_link_libraries(TUIO pthread)
add_library(TUIO_static STATIC ${TUIO_SOURCES} ${OSC_SOURCES})

install(FILES ${TUIO_HEADERS}
        DESTINATION include/TUIO COMPONENT dev)
install(FILES ${OSC_HEADERS}
        DESTINATION include/TUIO/osc COMPONENT dev)
install(FILES ${IP_HEADERS}
        DESTINATION include/TUIO/ip COMPONENT dev)
install(TARGETS TUIO TUIO_static
        ARCHIVE DESTINATION lib COMPONENT dev
        RUNTIME DESTINATION bin COMPONENT lib
        LIBRARY DESTINATION lib COMPONENT lib)

add_executable(TuioDump TuioDump.cpp)
target_link_libraries(TuioDump TUIO)
install(TARGETS TuioDump DESTINATION bin COMPONENT apps)

if(GLUT_FOUND AND OPENGL_FOUND AND SDL_FOUND)
  include_directories(${SDL_INCLUDE_DIR})

  add_executable(TuioDemo TuioDemo.cpp)
  target_link_libraries(TuioDemo TUIO ${GLUT_LIBRARIES}
                                  ${OPENGL_LIBRARIES} ${SDL_LIBRARY})

  add_executable(SimpleSimulator SimpleSimulator.cpp)
  target_link_libraries(SimpleSimulator TUIO ${GLUT_LIBRARIES}
                                        ${OPENGL_LIBRARIES} ${SDL_LIBRARY})
  install(TARGETS TuioDemo SimpleSimulator
          DESTINATION bin COMPONENT apps)
endif()
