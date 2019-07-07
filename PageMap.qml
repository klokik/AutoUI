import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.12

Page {
    width: 600
    height: 400

    header: TextField {
        cursorVisible: true
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        text: qsTr("Search")
        selectByMouse: true
    }

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        anchors.fill: parent
        plugin: mapPlugin
        zoomLevel: 12
    }
}
