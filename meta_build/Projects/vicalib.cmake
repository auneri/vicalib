set(EP_REQUIRED_PROJECTS Calibu HAL rapidjson)

if(NOT ANDROID AND BUILD_GUI)
  list(APPEND EP_REQUIRED_PROJECTS Pangolin)
endif()

#set(EP_URL "git@github.com:dmirota/vicalib.git")
set(EP_OPTION_DEFAULT ON)

if(ANDROID OR NOT BUILD_GUI)
  set(BUILD_GUI OFF)
else()
  set(BUILD_GUI ON)
endif()

#set(EP_PATCH "${CMAKE_CURRENT_LIST_DIR}/${EP_NAME}.patch")

cma_end_definition()

set(EP_CMAKE_ARGS
  -DCMAKE_USER_MAKE_RULES_OVERRIDE:FILEPATH=${CMAKE_USER_MAKE_RULES_OVERRIDE}
  -DCMAKE_USER_MAKE_RULES_OVERRIDE_CXX:FILEPATH=${CMAKE_USER_MAKE_RULES_OVERRIDE_CXX}
  -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
  "-DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS} ${MKL_C_FLAGS}"
  "-DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS} ${MKL_CXX_FLAGS}"
  -DCMAKE_INSTALL_RPATH:PATH=${CMAKE_INSTALL_RPATH}
  -DEIGEN3_INCLUDE_DIR:PATH=${EIGEN_INCLUDE_DIR}
  -DEIGEN_INCLUDE_DIR:PATH=${EIGEN_INCLUDE_DIR}
  -Dprotobuf_DIR:PATH=${protobuf_DIR}
  -DPROTOBUF_PROTOC_EXECUTABLE:FILEPATH=${PROTOBUF_PROTOC_EXECUTABLE}
  -Dglog_DIR:PATH=${Glog_DIR}
  -Dgflags_DIR:PATH=${gflags_DIR}
  -DSophus_DIR:PATH=${Sophus_DIR}
  -DTINYXML2_INCLUDE_DIRS:PATH=${TINYXML2_INCLUDE_DIRS}
  -DTINYXML2_LIBRARIES:FILEPATH=${TINYXML2_LIBRARIES}
  -DTINYXML2_INCLUDE_DIR:PATH=${TINYXML2_INCLUDE_DIR}
  -DTINYXML2_LIBRARY:FILEPATH=${TINYXML2_LIBRARY}
  -DSophus_INCLUDE_DIRS:PATH=${Sophus_INCLUDE_DIRS}
  -DOpenCV_DIR:PATH=${OpenCV_DIR}
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=OFF
  -DCalibu_DIR:PATH=${Calibu_DIR}
  -Dhal_DIR:PATH=${hal_DIR}
  -DBUILD_GUI:BOOL=${BUILD_GUI}
  -DCeres_DIR:PATH=${Ceres_DIR}
  -DPangolin_DIR:PATH=${Pangolin_DIR}
  -DPangolin_LIBRARY_DIRS:PATH=${Pangolin_LIBRARY_DIRS}
  -Drapidjson_INCLUDE_DIR:PATH=${rapidjson_INCLUDE_DIR}
  -Dglew_DIR:PATH=${glew_DIR}
  -DFreeGLUT_DIR:PATH=${FreeGLUT_DIR}
  -Dtinyxml2_DIR:PATH=${tinyxml2_DIR}
  -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${CMAKE_TOOLCHAIN_FILE}
  -DCMAKE_ANDROID_NDK:PATH=${CMAKE_ANDROID_NDK}
  -DCMAKE_ANDROID_ARCH_ABI:STRING=${CMAKE_ANDROID_ARCH_ABI}
  -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION:STRING=${CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION}
  )

if(NOT ${CMAKE_C_COMPILER_LAUNCHER} MATCHES sccache)
  list(APPEND EP_CMAKE_ARGS
    -DCMAKE_C_COMPILER_LAUNCHER:FILEPATH=${CMAKE_C_COMPILER_LAUNCHER}
    -DCMAKE_CXX_COMPILER_LAUNCHER:FILEPATH=${CMAKE_CXX_COMPILER_LAUNCHER})
endif()



ExternalProject_Add(${EP_NAME}
  DEPENDS ${EP_REQUIRED_PROJECTS}
  #GIT_REPOSITORY  ${EP_URL}
  #GIT_TAG master
  #UPDATE_DISCONNECTED 1
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${PROJECT_SOURCE_DIR}/..
  CMAKE_ARGS ${EP_CMAKE_ARGS}
  BINARY_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-build
  INSTALL_DIR ${PROJECT_BINARY_DIR}/install)
