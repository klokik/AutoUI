import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    width: 600
    height: 400

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            Layout.preferredHeight: 320
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            color: "cyan"

            RowLayout {
                height: parent.height

                ColumnLayout {
                    spacing: 32
                    Button {
                        text: "UP"
                        Layout.preferredHeight: width
                    }

                    Button {
                        text: "Down"
                        Layout.preferredHeight: width
                    }
                }

                ColumnLayout {
                    Text {
                        text: "KEK *C"
                        font.pixelSize: 96
                    }

                    Button {
                        text: "Auto"
                    }
                }
            }
        }

        Slider {
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            color: "pink"

            RowLayout {
                anchors.fill: parent

                Button {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Window heat"
                }
                Button {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Alert"
                }
                Button {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Indoor light"
                }
                Button {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Fresh air"
                }
                Button {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Toggle Windows"
                }
            }
        }
    }
}
