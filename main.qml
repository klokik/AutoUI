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

        Label {
            text: "Nothing there yet"
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        z: inputPanel.z + 1

        property real fontSize: height / 2

        TabButton {
            text: qsTr("Map")
            font.pixelSize: tabBar.fontSize
        }

        TabButton {
            text: qsTr("Web")
            font.pixelSize: tabBar.fontSize
        }

        TabButton {
            id: newTabButton
            text: qsTr("+")
            width: height
            font.bold: true
            font.pixelSize: tabBar.fontSize

            onClicked: {
                function newTab(kind, args) {
                    console.log("New tab of kind '" + kind + "' requested");

                    var label = "Page " + swipeView.count;

                    var tab_page = Qt.createQmlObject(`import QtQuick 2.12; import QtQuick.Controls 2.5; Label { text: '${label}' }`, swipeView)
                    var tab_button = Qt.createQmlObject(`import QtQuick 2.12; import QtQuick.Controls 2.5; TabButton { text: '${label}' }`, tabBar)

                    swipeView.insertItem(swipeView.count-2, tab_page);
                    tabBar.insertItem(tabBar.count-2, tab_button);
                }

                newTab("empty", "none")
            }
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
