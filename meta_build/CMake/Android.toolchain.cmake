cmake_minimum_required(VERSION 3.7)

set(CMAKE_SYSTEM_NAME Android)

if (NOT CMAKE_SYSTEM_VERSION)
  set(CMAKE_SYSTEM_VERSION 21)
endif()

if (NOT CMAKE_ANDROID_ARCH_ABI)
  set(CMAKE_ANDROID_ARCH_ABI x86)
  set(CMAKE_SIZEOF_VOID_P 4) #Workaround for OpenCV 2.4.12 cross-compilation
endif()
set(ANDROID_NDK_ABI_NAME ${CMAKE_ANDROID_ARCH_ABI}) #Workaround for OpenCV
set(ANDROID_ABI ${CMAKE_ANDROID_ARCH_ABI})

if(${CMAKE_ANDROID_ARCH_ABI} MATCHES 64)
    set(CMAKE_SIZEOF_VOID_P 8)
endif()

set(CMAKE_ANDROID_STL_TYPE c++_shared)
set(ANDROID_STL ${CMAKE_ANDROID_STL_TYPE})

if (NOT CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION)
    set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION 4.9)
endif()

add_definitions(-DANDROID)