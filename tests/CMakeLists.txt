message(STATUS "Loading test target...")

# ------------------------------
# Load test sources
# ------------------------------

file(GLOB_RECURSE TEST_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/*.cc"
        "${CMAKE_CURRENT_SOURCE_DIR}/*.cxx"
)

# ------------------------------
# Define executable
# ------------------------------

add_executable(${TEST_NAME}
        ${TEST_SOURCES}
)

# ------------------------------
# Link with lib and gtest
# ------------------------------

target_link_libraries(
        ${TEST_NAME} PRIVATE ${LIB_NAME} GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(${TEST_NAME})
