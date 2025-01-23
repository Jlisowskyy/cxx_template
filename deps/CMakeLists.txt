# ------------------------------
# Add all externals
# ------------------------------

file(GLOB directories RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*)

foreach(dir ${directories})
    if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${dir})
        add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/${dir})
    endif()
endforeach()
