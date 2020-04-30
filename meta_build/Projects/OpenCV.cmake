#set(EP_REQUIRED_PROJECTS Git)
set(EP_URL "https://github.com/Itseez/opencv")
set(EP_OPTION_DESCRIPTION "Open Source Computer Vision")
set(EP_TAG 3.2.0)

cma_end_definition()
# -----------------------------------------------------------------------------


string(REPLACE ";" "$<SEMICOLON>" BLAS_LIBRARIES_ALT_SEP "${BLAS_LIBRARIES}")

if("${CMAKE_BUILD_TYPE}" MATCHES "RelWithDebInfo")
  set(CMAKE_BUILD_TYPE "Release")
endif()


set(EP_CMAKE_ARGS
  -DBUILD_DOCS:BOOL=OFF
  -DBUILD_opencv_gpu:BOOL=OFF
  -DBUILD_opencv_apps:BOOL=OFF
  -DBUILD_opencv_legacy:BOOL=OFF
  -DBUILD_opencv_nonfree:BOOL=OFF
  -DBUILD_opencv_stitching:BOOL=OFF
  -DBUILD_opencv_superres:BOOL=OFF
  -DBUILD_opencv_ts:BOOL=OFF
  -DBUILD_opencv_videostab:BOOL=OFF
  -DBUILD_opencv_python:BOOL=OFF
  -DBUILD_opencv_video:BOOL=OFF
  -DBUILD_opencv_photo:BOOL=OFF
  -DBUILD_opencv_objdetect:BOOL=OFF
  -DBUILD_opencv_contrib:BOOL=OFF
  -DBUILD_opencv_python2:BOOL=OFF
  -DBUILD_PACKAGE:BOOL=OFF
  -DBUILD_PERF_TESTS:BOOL=OFF
  -DBUILD_TESTS:BOOL=OFF
  -DBUILD_WITH_DEBUG_INFO:BOOL=OFF
  -DBUILD_opencv_androidcamera:BOOL=OFF
  -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
  -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
  -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
  -DCMAKE_LINK_LIBRARY_FLAG:STRING=${CMAKE_LINK_LIBRARY_FLAG}
  -DWITH_CUDA:BOOL=OFF
  -DWITH_FFMPEG:BOOL=OFF
  -DWITH_OPENCL:BOOL=OFF
  -DWITH_QT:BOOL=OFF
  -DWITH_1394:BOOL=OFF
  -DWITH_CUFFT:BOOL=OFF
  -DWITH_FFMPEG:BOOL=OFF
  -DWITH_GIGEAPI:BOOL=OFF
  -DWITH_GSTREAMER:BOOL=OFF
  -DWITH_JASPER:BOOL=OFF
  -DWITH_JPEG:BOOL=OFF
  -DWITH_LIBV4L:BOOL=OFF
  -DWITH_OPENCLAMDBLAS:BOOL=OFF
  -DWITH_OPENCLAMDFFT:BOOL=OFF
  -DWITH_OPENEXR:BOOL=OFF
  -DWITH_PVAPI:BOOL=OFF
  -DWITH_TIFF:BOOL=OFF
  -DWITH_V4L:BOOL=OFF
  -DWITH_PNG:BOOL=OFF
  -DWITH_WEBP:BOOL=OFF
  -DWITH_VTK:BOOL=OFF
  -DHAVE_MKL:BOOL=ON
  -DHAVE_LAPACK:BOOL=TRUE
  -DLAPACK_LIBRARIES:STRING=${BLAS_LIBRARIES_ALT_SEP}
  -DLAPACK_IMPL:STRING=MKL
  -DLAPACK_CBLAS_H:STRING=mkl_cblas.h
  -DLAPACK_LAPACKE_H:STRING=mkl_lapack.h
  -DLAPACK_INCLUDE_DIR:PATH=${LAPACK_INCLUDE_DIR}
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=OFF
  -DBUILD_WITH_STATIC_CRT:BOOL=OFF
  -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${CMAKE_TOOLCHAIN_FILE}
  -DCMAKE_ANDROID_NDK:PATH=${CMAKE_ANDROID_NDK}
  -DCMAKE_ANDROID_ARCH_ABI:STRING=${CMAKE_ANDROID_ARCH_ABI}
  -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION:STRING=${CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION}
  -DENABLE_CCACHE:BOOL=FALSE
  -DWITH_IPP:BOOL=ON
  -DCMAKE_C_COMPILER_LAUNCHER:FILEPATH=${CMAKE_C_COMPILER_LAUNCHER}
  -DCMAKE_CXX_COMPILER_LAUNCHER:FILEPATH=${CMAKE_CXX_COMPILER_LAUNCHER}
  -DBUILD_opencv_python2:BOOL=FALSE
  -DBUILD_opencv_python3:BOOL=FALSE)

if(WIN32)
  list(APPEND EP_CMAKE_ARGS -DBUILD_ZLIB:BOOL=ON)
endif()

if(UNIX)
  list(APPEND EP_CMAKE_ARGS -DIPPROOT:PATH=/opt/intel/ipp)
endif()

ExternalProject_Add(${EP_NAME}
  DEPENDS ${EP_REQUIRED_PROJECTS}
  GIT_REPOSITORY ${EP_URL}
  GIT_TAG ${EP_TAG}
  GIT_SHALLOW 1
  #DOWNLOAD_COMMAND git clone --depth 1 --branch ${EP_TAG} ${EP_URL} ${PROJECT_BINARY_DIR}/${EP_NAME}
  #UPDATE_COMMAND ""
  SOURCE_DIR ${PROJECT_BINARY_DIR}/src/${EP_NAME}
  CMAKE_ARGS ${EP_CMAKE_ARGS}
  BINARY_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-build
  INSTALL_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-install)

if(WIN32)
  set(OpenCV_DIR "${PROJECT_BINARY_DIR}/${EP_NAME}-install/" CACHE INTERNAL "")
elseif(UNIX AND NOT ANDROID)
  set(OpenCV_DIR "${PROJECT_BINARY_DIR}/${EP_NAME}-install/share/${EP_NAME}" CACHE INTERNAL "")
elseif(ANDROID)
  set(OpenCV_DIR "${PROJECT_BINARY_DIR}/${EP_NAME}-install/sdk/native/jni" CACHE INTERNAL "")
endif()


