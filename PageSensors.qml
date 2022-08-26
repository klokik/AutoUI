import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQml 2.2

Page {
    width: 600
    height: 400

    Rectangle {
        anchors.fill: parent
        GridLayout {
            anchors.centerIn: parent
            columns: 2
            Text {
                id: time
                text: qsTr("Time:")
                Layout.column: 0
            }
            Text {
                id: time_value
                property string timeString: "none"

                text: timeString
                Layout.column: 1
            }
            Text {
                id: position
                text: qsTr("Position:")
                Layout.column: 0
                Layout.row: 1
            }
            Text {
                id: position_value

                text: "unknown"
                Layout.column: 1
                Layout.row: 1
            }
            Text {
                id: altitude_label
                text: qsTr("Altitude:")
                Layout.column: 0
                Layout.row: 2
            }
            Text {
                id: altitude

                text: "unknown"
                Layout.column: 1
                Layout.row: 2
            }
            Text {
                text: qsTr("Speed:")
                Layout.column: 0
                Layout.row: 3
            }
            Text {
                id: speed

                text: "unknown"
                Layout.column: 1
                Layout.row: 3
            }
            Text {
                text: qsTr("Azimuth:")
                Layout.column: 0
                Layout.row: 4
            }
            Text {
                id: azimuth

                text: "unknown"
                Layout.column: 1
                Layout.row: 4
            }
        }
    }

    PositionSource {
        id: gnss_src
        updateInterval: 100
        active: true

        onPositionChanged: {
            var position = gnss_src.position
            var coord = position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
            position_value.text =
                    coord.latitude + " " + coord.longitude
                    + " ±" + position.horizontalAccuracy + "m "
                    + "\n"
                    + (position.valid ? "Valid" : "Invalid");
            altitude.text = coord.altitude + " ±" + position.altitudeAccuracy
            speed.text = coord.speed + " m/s"
            azimuth.text = coord.direction + " deg"
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            time_value.timeString = Date();
        }
    }
}
