
set(OSC_PUBLIC_HEADERS
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

set(OSC_SOURCES
  osc/OscTypes.cpp
  osc/OscOutboundPacketStream.cpp
  osc/OscReceivedElements.cpp
  osc/OscPrintReceivedElements.cpp
)

if(MSVC)
  list(APPEND OSC_SOURCES
    ip/win32/NetworkingUtils.cpp
    ip/win32/UdpSocket.cpp
  )
else()
  list(APPEND OSC_SOURCES
    ip/posix/NetworkingUtils.cpp
    ip/posix/UdpSocket.cpp
  )
endif()

set(OSC_INCLUDE_NAME osc)
set(OSC_OMIT_CHECK_TARGETS ON)
common_library(OSC)
