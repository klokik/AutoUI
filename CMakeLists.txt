cmake_minimum_required(VERSION 3.1)

project(AutoUI LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#find_package(Qt5 COMPONENTS Core Quick Location WebEngine VirtualKeyboard REQUIRED PATHS /usr/local/qt5.12)
find_package(Qt5 COMPONENTS Core Quick Location VirtualKeyboard REQUIRED PATHS /usr/local/qt5.12)

add_executable(${PROJECT_NAME} "main.cpp" "qml.qrc")
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core Qt5::Quick Qt5::Location Qt5::VirtualKeyboard)
