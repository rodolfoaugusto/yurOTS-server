cmake_minimum_required(VERSION 2.8)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(yurOTS)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(cotire)

add_compile_options(-pipe -fvisibility=hidden)

if (CMAKE_COMPILER_IS_GNUCXX)
    add_compile_options(-fno-strict-aliasing)
endif()

include(FindCXX11)

# Find packages.

find_package(Crypto++ REQUIRED)

find_package(PugiXML REQUIRED)
find_package(LuaJIT)
find_package(MySQL)
find_package(Threads)

option(USE_LUAJIT "Use LuaJIT" ${LUAJIT_FOUND})

if(USE_LUAJIT)
    find_package(LuaJIT REQUIRED)
    if(APPLE)
      set(CMAKE_EXE_LINKER_FLAGS "-pagezero_size 10000 -image_base 100000000")
    endif()
else()
    find_package(Lua)
endif()

find_package(Boost 1.53.0 COMPONENTS system filesystem REQUIRED)

include(src/CMakeLists.txt)
add_executable(yurOTS ${yurOTS_SRC})

include_directories(${MYSQL_INCLUDE_DIR} ${LUA_INCLUDE_DIR} ${Boost_INCLUDE_DIRS} ${PUGIXML_INCLUDE_DIR})
target_link_libraries(yurOTS ${MYSQL_CLIENT_LIBS} ${LUA_LIBRARIES} ${Boost_LIBRARIES} ${Boost_FILESYSTEM_LIBRARIES} ${PUGIXML_LIBRARIES} ${Crypto++_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})

set_target_properties(yurOTS PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "src/otpch.h")
set_target_properties(yurOTS PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE)

cotire(yurOTS)
