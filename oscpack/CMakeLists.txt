
set(OSCPACK_PUBLIC_HEADERS
  osc/MessageMappingOscPacketListener.h
  osc/OscOutboundPacketStream.h
  osc/OscReceivedElements.h
  osc/OscException.h
  osc/OscPacketListener.h
  osc/OscTypes.h
  osc/OscHostEndianness.h
  osc/OscPrintReceivedElements.h
  ip/IpEndpointName.h
  ip/NetworkingUtils.h
  ip/PacketListener.h
  ip/TimerListener.h
  ip/UdpSocket.h
)

set(OSCPACK_SOURCES
  osc/OscTypes.cpp
  osc/OscOutboundPacketStream.cpp
  osc/OscReceivedElements.cpp
  osc/OscPrintReceivedElements.cpp
)

if(MSVC)
  list(APPEND OSCPACK_SOURCES
    ip/win32/NetworkingUtils.cpp
    ip/win32/UdpSocket.cpp
  )
else()
  list(APPEND OSCPACK_SOURCES
    ip/posix/NetworkingUtils.cpp
    ip/posix/UdpSocket.cpp
  )
endif()

set(OSCPACK_INCLUDE_NAME oscpack) # not TUIO
set(OSCPACK_OMIT_CHECK_TARGETS ON)
set(OSCPACK_OMIT_LIBRARY_HEADER ON)
set(OSCPACK_OMIT_VERSION_HEADERS ON)
common_library(oscpack)
