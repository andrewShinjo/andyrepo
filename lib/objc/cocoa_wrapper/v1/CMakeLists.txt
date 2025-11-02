cmake_minimum_required(VERSION 3.16)
project(CocoaWrapper LANGUAGES OBJC)

add_library(
  ${PROJECT_NAME}
  STATIC
<<<<<<< HEAD
  src/CocoaAppBuilder.m
  src/CocoaWindowBuilder.m
)

target_include_directories(
  ${PROJECT_NAME} 
  PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
=======
  src/CocoaWindowBuilder.m
)

target_include_directories(MyLibrary PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
>>>>>>> cd2f826 (Initial cocoa wrapper)
)