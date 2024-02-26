cmake_minimum_required(VERSION 3.5)
project(tests VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Test Core REQUIRED)

add_executable(tests
    main.cpp
    )
target_link_libraries(tests PRIVATE Qt${QT_VERSION_MAJOR}::Test
                                    Qt${QT_VERSION_MAJOR}::Core)
add_test(NAME tests COMMAND tests)
