import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    width: 600
    height: 400

    ColumnLayout {
        anchors.fill: parent

        property int fontSize: 48
        property real buttonWidth: width / 3

        ToolButton {
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
            text: "kek3"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.buttonWidth
            font.pointSize: parent.fontSize
        }
    }
}
