set(EP_URL "https://github.com/tronkko/dirent")
set(EP_TAG 9064fdfcc155ffe9244e2a6b0047974774ac81f0)
set(EP_PATCH "${CMAKE_CURRENT_LIST_DIR}/${EP_NAME}.patch")

cma_end_definition()

ExternalProject_Add(${EP_NAME}
  DEPENDS ${EP_REQUIRED_PROJECTS}
  GIT_REPOSITORY  ${EP_URL}
  GIT_TAG ${EP_TAG}
  UPDATE_DISCONNECTED 1
  SOURCE_DIR ${PROJECT_BINARY_DIR}/src/${EP_NAME}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND "")


set(DIRENT_INCLUDE_DIR "${PROJECT_BINARY_DIR}/src/${EP_NAME}/include/" CACHE INTERNAL "")
