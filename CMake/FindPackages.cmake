# generated by Buildyard, do not edit.

include(System)
list(APPEND FIND_PACKAGES_DEFINES ${SYSTEM})

find_package(GLUT )
if(GLUT_FOUND)
  set(GLUT_name GLUT)
endif()
if(GLUT_FOUND)
  set(GLUT_name GLUT)
endif()
if(GLUT_name)
  list(APPEND FIND_PACKAGES_DEFINES TUIO_USE_GLUT)
  link_directories(${${GLUT_name}_LIBRARY_DIRS})
  if(NOT "${${GLUT_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${GLUT_name}_INCLUDE_DIRS})
  endif()
endif()

find_package(OpenGL )
if(OpenGL_FOUND)
  set(OpenGL_name OpenGL)
endif()
if(OPENGL_FOUND)
  set(OpenGL_name OPENGL)
endif()
if(OpenGL_name)
  list(APPEND FIND_PACKAGES_DEFINES TUIO_USE_OPENGL)
  link_directories(${${OpenGL_name}_LIBRARY_DIRS})
  if(NOT "${${OpenGL_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${OpenGL_name}_INCLUDE_DIRS})
  endif()
endif()

find_package(SDL )
if(SDL_FOUND)
  set(SDL_name SDL)
endif()
if(SDL_FOUND)
  set(SDL_name SDL)
endif()
if(SDL_name)
  list(APPEND FIND_PACKAGES_DEFINES TUIO_USE_SDL)
  link_directories(${${SDL_name}_LIBRARY_DIRS})
  if(NOT "${${SDL_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${SDL_name}_INCLUDE_DIRS})
  endif()
endif()


set(TUIO_DEPENDS GLUT;OpenGL;SDL)

# Write defines.h and options.cmake
if(NOT PROJECT_INCLUDE_NAME)
  set(PROJECT_INCLUDE_NAME ${CMAKE_PROJECT_NAME})
endif()
if(NOT OPTIONS_CMAKE)
  set(OPTIONS_CMAKE ${CMAKE_BINARY_DIR}/options.cmake)
endif()
set(DEFINES_FILE "${CMAKE_BINARY_DIR}/include/${PROJECT_INCLUDE_NAME}/defines${SYSTEM}.h")
set(DEFINES_FILE_IN ${DEFINES_FILE}.in)
file(WRITE ${DEFINES_FILE_IN}
  "// generated by Buildyard, do not edit.\n\n"
  "#ifndef ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n"
  "#define ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n\n")
file(WRITE ${OPTIONS_CMAKE} "# Optional modules enabled during build\n")
foreach(DEF ${FIND_PACKAGES_DEFINES})
  add_definitions(-D${DEF})
  file(APPEND ${DEFINES_FILE_IN}
  "#ifndef ${DEF}\n"
  "#  define ${DEF}\n"
  "#endif\n")
if(NOT DEF STREQUAL SYSTEM)
  file(APPEND ${OPTIONS_CMAKE} "set(${DEF} ON)\n")
endif()
endforeach()
file(APPEND ${DEFINES_FILE_IN}
  "\n#endif\n")

include(UpdateFile)
update_file(${DEFINES_FILE_IN} ${DEFINES_FILE})
