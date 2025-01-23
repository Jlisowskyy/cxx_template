message(STATUS "GTEST fetcher cmake loaded...")

# -------------------------------
# Fetch GTEST from github...
# -------------------------------

include(FetchContent)

FetchContent_Declare(
        libGTEST
        GIT_REPOSITORY https://github.com/google/googletest
        GIT_TAG main
)

FetchContent_MakeAvailable(libGTEST)
