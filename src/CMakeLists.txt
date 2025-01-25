# ------------------------------
# Find all source files
# ------------------------------

file(GLOB_RECURSE LIB_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
)

# Ensure main.cpp removed from lib sources
list(REMOVE_ITEM LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")

# ------------------------------
# Define static library
# ------------------------------

add_library(${LIB_NAME} STATIC
        ${LIB_SOURCES}
)

# ------------------------------
# Add includes
# ------------------------------

target_include_directories(${LIB_NAME} PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}"
)

# ------------------------------
# Define executable
# ------------------------------

add_executable(${EXEC_NAME}
        main.cpp
)

# ------------------------------
# Link lib to executable
# ------------------------------

target_link_libraries(${EXEC_NAME} ${LIB_NAME})
