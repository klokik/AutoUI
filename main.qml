import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")
    id: appContainer

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        interactive: false

        PageMap {
        }

        PageWeb {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        z: inputPanel.z + 1

        TabButton {
            text: qsTr("Map")
        }
        TabButton {
            text: qsTr("Web")
        }
    }

    InputPanel {
        id: inputPanel
        z: 89
        y: swipeView.height
        anchors.left: parent.left
        anchors.right: parent.right
        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: swipeView.height - inputPanel.height
            }
        }
        transitions: Transition {
            id: inputPanelTransition
            from: ""
            to: "visible"
            reversible: true
            enabled: !VirtualKeyboardSettings.fullScreenMode
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Binding {
            target: InputContext
            property: "animating"
            value: inputPanelTransition.running
        }

        AutoScroller {}
    }

    Binding {
        target: VirtualKeyboardSettings
        property: "fullScreenMode"
        value: swipeView.height > 0 && (swipeView.width / swipeView.height) > (16.0 / 9.0)
    }
}
