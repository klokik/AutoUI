import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.12
import QtPositioning 5.12

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
        //name: "mapboxgl"
        name: "osm"

        PluginParameter {
            name: 'mapboxgl.access_token'
            value: 'VALID_MAPBOX_TOKEN'
        }
    }

    Map {
        id: mapView

        property var locationA: QtPositioning.coordinate(59.91, 10.75)
        property var locationB: QtPositioning.coordinate(59.81, 10.78)
        property var myLocation: QtPositioning.coordinate(59.85, 10.86)

        property bool showA: true
        property bool showB: true
        property bool showMe: true

        anchors.fill: parent
        plugin: mapPlugin
        zoomLevel: 12

        Image {
            width: parent.width / 5
            height: width

            x: parent.width - 40 - width
            y: parent.y + 40

            source: "qrc:/res/compass.svg"
            rotation: -parent.bearing

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    mapView.bearing = 0
                    mapView.tilt = mapView.minimumTilt
                    console.log("Reseting bearing and tilt")
                }
            }
        }

        center: QtPositioning.coordinate(59.91, 10.75)

        MapQuickItem {
            coordinate: parent.locationA
            visible: parent.showA
            anchorPoint.x: markerA.width / 2
            anchorPoint.y: markerA.height

            sourceItem: Image {
                width: 64
                height: 64
                id: markerA

                source: "qrc:/res/location-pin-red.svg"
            }
        }

        MapQuickItem {
            coordinate: parent.locationB
            visible: parent.showB
            anchorPoint.x: markerB.width / 2
            anchorPoint.y: markerB.height

            sourceItem: Image {
                width: 64
                height: 64
                id: markerB

                source: "qrc:/res/location-pin-blue.svg"
            }
        }

        MapCircle {
            center: parent.myLocation
            radius: 50.0
            color: '#C0C0FF'
            border.width: 4
            visible: parent.showMe
        }
    }
}
