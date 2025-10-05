cmake_minimum_required(VERSION 3.16)
project(hello_world C)

# Set C standard to C17
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Add executable
add_executable(hello_world src/main.c)

# Set output directory
set_target_properties(hello_world PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# Ensure debug symbols are generated for debugging
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(hello_world PRIVATE -g -O0)
endif()

# Add custom target to run the executable
add_custom_target(run
    COMMAND ${CMAKE_BINARY_DIR}/bin/hello_world
    DEPENDS hello_world
    COMMENT "Running hello_world executable"
)
