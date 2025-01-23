# ------------------------------
# Setup project
# ------------------------------

set(EXEC_NAME "PROJECT")
set(LIB_NAME ${EXEC_NAME}Lib)
set(TEST_NAME UnitTestTarget)

cmake_minimum_required(VERSION 3.29)
project(${EXEC_NAME} C CXX)

set(PROJECT_NAME ${EXEC_NAME})
set(PROJECT_VERSION "1.0")
set(PROJECT_AUTHOR "Jakub Lisowski")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 17)

# ------------------------------
# Load all deps
# ------------------------------

add_subdirectory(deps)

# ------------------------------
# Load project
# ------------------------------

add_subdirectory(src)

# ------------------------------
# Setup compile options
# ------------------------------

# ------------------------------
# Setup compile options
# ------------------------------

string(TOUPPER "${CMAKE_BUILD_TYPE}" BUILD_TYPE_UPPER)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

    if(BUILD_TYPE_UPPER STREQUAL "DEBUG")
        target_compile_options(${LIB_NAME} PUBLIC
                -g
                -fsanitize=undefined
                -fsanitize=address
                -fsanitize=leak
                -O0
                -Wall
                -Wextra
                -pedantic
        )
        target_link_options(${LIB_NAME} PUBLIC
                -fsanitize=undefined
                -fsanitize=address
                -fsanitize=leak
        )
    elseif (BUILD_TYPE_UPPER STREQUAL "RELEASE")
        target_compile_options(${LIB_NAME} PUBLIC -O3;-march=native;-funroll-loops;)
    elseif(BUILD_TYPE_UPPER STREQUAL "RELWITHDEBINFO")
        target_compile_options(${LIB_NAME} PUBLIC -g;-O2;-march=native;)
    else()
        message(FATAL_ERROR "UNKNOWN BUILD TYPE: ${BUILD_TYPE_UPPER}")
    endif()

elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

    if(BUILD_TYPE_UPPER STREQUAL "DEBUG")
        target_compile_options(${LIB_NAME} PUBLIC
                -g
                -fsanitize=undefined
                -fsanitize=address
                -O0
                -Wall
                -Wextra
                -pedantic
        )
        target_link_options(${LIB_NAME} PUBLIC
                -fsanitize=undefined
                -fsanitize=address
        )
    elseif (BUILD_TYPE_UPPER STREQUAL "RELEASE")
        target_compile_options(${LIB_NAME} PUBLIC -O3;-march=native;-funroll-loops)
    elseif(BUILD_TYPE_UPPER STREQUAL "RELWITHDEBINFO")
        target_compile_options(${LIB_NAME} PUBLIC -g;-O2;-march=native;)
    else()
        message(FATAL_ERROR "UNKNOWN BUILD TYPE: ${BUILD_TYPE_UPPER}")
    endif()

elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel" OR CMAKE_CXX_COMPILER_ID STREQUAL "IntelLLVM")
    message(FATAL_ERROR "Intel compiler is not supported...")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    message(FATAL_ERROR "MSVC is not supported...")
else()
    message(FATAL_ERROR "Unknown compiler: ${CMAKE_CXX_COMPILER_ID}")
endif()

# ------------------------------
# Add test target
# ------------------------------

add_subdirectory(tests)
