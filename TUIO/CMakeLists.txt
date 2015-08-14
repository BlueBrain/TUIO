
set(TUIO_PUBLIC_HEADERS
  TuioClient.h
  TuioContainer.h
  TuioCursor.h
  TuioListener.h
  TuioObject.h
  TuioPoint.h
  TuioServer.h
  TuioTime.h
)

set(TUIO_SOURCES
  TuioClient.cpp
  TuioServer.cpp
  TuioTime.cpp
)

set(TUIO_LINK_LIBRARIES PUBLIC OSC)
if(MSVC)
  list(APPEND TUIO_LINK_LIBRARIES PRIVATE mswsock winmm ws2_32)
else()
  list(APPEND TUIO_LINK_LIBRARIES PRIVATE pthread)
endif()
set(TUIO_INCLUDE_NAME TUIO)
set(TUIO_OMIT_CHECK_TARGETS ON)
common_library(TUIO)
