cmake_minimum_required(VERSION 2.8)

option(WITH_ONLINE "WINDOWS" OFF)
if(WINDOWS)
    set(CMAKE_SYSTEM_NAME Windows)
    set(CMAKE_SYSTEM_VERSION 1)
    set(CMAKE_C_COMPILER "/usr/bin/x86_64-w64-mingw32-gcc-win32")
    set(CMAKE_CXX_COMPILER "/usr/bin/x86_64-w64-mingw32-g++-win32")
    set(CMAKE_RANLIB "/usr/bin/x86_64-w64-mingw32-ranlib")
    message("-- Crosscompiling for Windows")
endif()

project(craft)
add_executable(
    craft src/main.c src/db.c src/map.c src/util.c
    deps/glew/src/glew.c deps/lodepng/lodepng.c
    src/noise.c deps/sqlite/sqlite3.c)

add_definitions(-std=c99 -O3)

add_subdirectory(deps/glfw)
include_directories(deps/glew/include)
include_directories(deps/glfw/include)
include_directories(deps/lodepng)
include_directories(deps/sqlite)

find_package(OpenGL REQUIRED)

if(APPLE)
    target_link_libraries(craft glfw ${OPENGL_gl_LIBRARY} ${GLFW_LIBRARIES})
elseif(UNIX)
    target_link_libraries(craft glfw dl ${OPENGL_gl_LIBRARY} ${GLFW_LIBRARIES})
else()
    target_link_libraries(craft glfw ws2_32.lib ${OPENGL_gl_LIBRARY} ${GLFW_LIBRARIES})
endif()
