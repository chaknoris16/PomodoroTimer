cmake_minimum_required(VERSION 3.16)

project(PomodoroTimer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 COMPONENTS Core Gui Quick Widgets Sql Test REQUIRED)


qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appPomodoroTimer
    src/main.cpp

)

qt_add_qml_module(appPomodoroTimer
    URI PomodoroTimer
    VERSION 1.0

    QML_FILES
    ui/Main.qml
    ui/MinutesSelector.qml
    ui/MyDial.qml
    ui/DialPage.qml
    ui/TimeSelectorPage.qml
    ui/PopupMessage.qml

    SOURCES
    include/dialcontroller.h
    src/dialcontroller.cpp

    include/db_manager.h
    src/db_manager.cpp

    include/itemmodel.h
    src/itemmodel.cpp

    include/timer_controller.h
    src/timer_controller.cpp

    include/ListItem.h
    include/i_db_manager.h

    RESOURCES resources.qrc
)


set_target_properties(appPomodoroTimer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPomodoroTimer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPomodoroTimer PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::Sql
    Qt${QT_VERSION_MAJOR}::Test
)

include(GNUInstallDirs)
install(TARGETS appPomodoroTimer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

enable_testing()
add_subdirectory(tests)
