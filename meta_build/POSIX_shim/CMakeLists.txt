cmake_minimum_required( VERSION 2.8 )
project("POSIX_shim" NONE)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION ${CMAKE_INSTALL_PREFIX} FILES_MATCHING PATTERN "*.h")