import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    width: 600
    height: 400

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        contentHeight: first_button.height * button_column.children.length * 1.2

        ColumnLayout {
            anchors.fill: parent

            property int fontSize: 48
            property real buttonWidth: width / 2

            id: button_column

            ToolButton {
                id: first_button
                text: "Map"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize

                onClicked: {
                    appContainer.newTab("map", "none")
                }
            }

            ToolButton {
                text: "Google"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize

                onClicked: {
                    appContainer.newTab("web", "google.com")
                }
            }

            ToolButton {
                text: "Music"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize

                onClicked: {
                    appContainer.newTab("music", "none")
                }
            }

            ToolButton {
                text: "Radio"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }

            ToolButton {
                text: "Movies"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }

            ToolButton {
                text: "News"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }

            ToolButton {
                text: "A/C"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize

                onClicked: {
                    appContainer.newTab("climate", "none")
                }
            }

            ToolButton {
                text: "Sensors"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }

            ToolButton {
                text: "Wireless"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }

            ToolButton {
                text: "Debug"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.buttonWidth
                font.pointSize: parent.fontSize
            }
        }
    }

    ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: parent.width * 0.2

        ToolButton {
            text: "F"
            Layout.alignment: Qt.AlignHRight
            Layout.preferredWidth: parent.width * 0.3
            font.pointSize: button_column.fontSize

            onClicked: {
                console.log(appContainer.visibility);
                if (appContainer.visibility == Qt.WindowFullScreen)
                    appContainer.visibility = Qt.WindowMaximized;
                else
                    appContainer.visibility = Qt.WindowFullScreen;
            }
        }
    }
}
