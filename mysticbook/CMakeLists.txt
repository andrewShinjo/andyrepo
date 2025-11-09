cmake_minimum_required(VERSION 3.16)
project(Mysticbook)

add_executable(
  ${PROJECT_NAME}
  cocoa_main.m
  BlockEditor.m
)

target_link_libraries(
  ${PROJECT_NAME} 
  "-framework Cocoa" 
  "-framework Metal" 
  "-framework QuartzCore"
  CocoaWrapper
)