cmake_minimum_required(VERSION 3.16)

project(PomodoroTimer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 COMPONENTS Core Gui Quick Widgets QuickWidgets REQUIRED)


qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appPomodoroTimer
    main.cpp
    timer_controller.h
    timer_controller.cpp

    dialcontroller.h
    dialcontroller.cpp

)

qt_add_qml_module(appPomodoroTimer
    URI PomodoroTimer
    VERSION 1.0

    QML_FILES Main.qml
    MinutesSelector.qml
    MyDial.qml
    DialPage.qml
    TimeSelectorPage.qml

    SOURCES
    timer_controller.h
    timer_controller.cpp
    RESOURCES resources.qrc
    SOURCES itemmodel.h itemmodel.cpp
)


set_target_properties(appPomodoroTimer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPomodoroTimer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPomodoroTimer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Widgets
    Qt6::QuickWidgets
)

include(GNUInstallDirs)
install(TARGETS appPomodoroTimer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
