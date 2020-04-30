set(EP_REQUIRED_PROJECTS POSIX_shim protobuf GLog GFlags OpenCV Sophus tinyxml2 Calibu)
if(WIN32)
    list(APPEND EP_REQUIRED_PROJECTS dirent dlfcn-win32)
ENDIF()
set(EP_URL "https://github.com/dmirota/HAL.git")

set(EP_TAG master)


#set(EP_PATCH "${CMAKE_CURRENT_LIST_DIR}/${EP_NAME}.patch")

cma_end_definition()

set(EP_CMAKE_ARGS
  -DCMAKE_USER_MAKE_RULES_OVERRIDE:FILEPATH=${CMAKE_USER_MAKE_RULES_OVERRIDE}
  -DCMAKE_USER_MAKE_RULES_OVERRIDE_CXX:FILEPATH=${CMAKE_USER_MAKE_RULES_OVERRIDE_CXX}
  -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
  -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
  -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
  -DCMAKE_LIBRARY_PATH_FLAG:STRING=${CMAKE_LIBRARY_PATH_FLAG}
  -DCMAKE_INSTALL_RPATH:PATH=${CMAKE_INSTALL_RPATH}
  -DEIGEN3_INCLUDE_DIR:PATH=${EIGEN_INCLUDE_DIR}
  -Dglog_DIR:PATH=${Glog_DIR}
  -Dgflags_DIR:PATH=${gflags_DIR}
  -DSophus_DIR:PATH=${Sophus_DIR}
  -Dtinyxml2_DIR:PATH=${tinyxml2_DIR}
  -DSophus_INCLUDE_DIRS:PATH=${Sophus_INCLUDE_DIRS}
  -DOpenCV_STATIC:BOOL=ON
  -DOpenCV_DIR:PATH=${OpenCV_DIR}
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -Dprotobuf_DIR:PATH=${protobuf_DIR}
  -Dprotobuf_MODULE_COMPATIBLE:BOOL=TRUE
  -DPROTOBUF_PROTOC_EXECUTABLE:FILEPATH=${PROTOBUF_PROTOC_EXECUTABLE}
  -DBUILD_Cleave:BOOL=OFF
  -DBUILD_SHARED_LIBS:BOOL=ON
  -DBUILD_Velodyne:BOOL=OFF
  -DBUILD_MicroStrain:BOOL=OFF
  -DBUILD_AutoExposure:BOOL=OFF
  -DBUILD_OpenCV:BOOL=OFF
  -DBUILD_Rectify:BOOL=OFF
  -DBUILD_UVC:BOOL=OFF
  -DBUILD_Undistort:BOOL=OFF
  -DDIRENT_INCLUDE_DIR:PATH=${DIRENT_INCLUDE_DIR}
  -Ddlfcn-win32_DIR:PATH=${dlfcn-win32_DIR}
  -DPOSIX_shim_INCLUDE_DIR:PATH=${CMAKE_CURRENT_LIST_DIR}/../POSIX_shim/include
  -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${CMAKE_TOOLCHAIN_FILE}
  -DCMAKE_ANDROID_NDK:PATH=${CMAKE_ANDROID_NDK}
  -DCMAKE_ANDROID_ARCH_ABI:STRING=${CMAKE_ANDROID_ARCH_ABI}
  -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION:STRING=${CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION}
  -DCMAKE_C_COMPILER_LAUNCHER:FILEPATH=${CMAKE_C_COMPILER_LAUNCHER}
  -DCMAKE_CXX_COMPILER_LAUNCHER:FILEPATH=${CMAKE_CXX_COMPILER_LAUNCHER}
  )


ExternalProject_Add(${EP_NAME}
  DEPENDS ${EP_REQUIRED_PROJECTS}
  GIT_REPOSITORY  ${EP_URL}
  GIT_TAG ${EP_TAG}
  UPDATE_DISCONNECTED 1
  SOURCE_DIR ${PROJECT_BINARY_DIR}/src/${EP_NAME}
  CMAKE_ARGS ${EP_CMAKE_ARGS}
  BINARY_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-build
  INSTALL_DIR ${PROJECT_BINARY_DIR}/install)

set(hal_DIR "${PROJECT_BINARY_DIR}/install/lib/cmake/hal" CACHE INTERNAL "")
