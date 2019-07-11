import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import QtMultimedia 5.12

Page {
    padding: width * 0.05

    MediaPlayer {
        id: musicPlayer

        source: "file:///home/klokik/Music/track.flac"
    }

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: albumCover
            source: "file:///home/klokik/Pictures/Cover.jpg"
            Layout.preferredHeight: width
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.minimumHeight: 16
            color: "green"
        }

        RowLayout {
            Layout.alignment: Qt.AlignTop

            Button {
                text: "Back"
                Layout.fillWidth: true
            }
            Button {
                text: "Stop"
                Layout.fillWidth: false

                onClicked: {
                    musicPlayer.stop()
                }
            }
            Button {
                text: ["Play", "Pause", "Play"][musicPlayer.playbackState]
                Layout.fillWidth: true

                onClicked: {
                    if (musicPlayer.playbackState != MediaPlayer.PlayingState)
                        musicPlayer.play()
                    else
                        musicPlayer.pause()
                }
            }
            Button {
                text: "Next"
                Layout.fillWidth: true
            }
        }

        Label {
            text: playbackPosition.value
        }

        Slider {
            id: playbackPosition
            Layout.fillWidth: true

            from: 0
            to: musicPlayer.duration

            value: musicPlayer.position
            onMoved: {
                musicPlayer.seek(value)
            }
        }

        RowLayout {
            Button {
                text: musicPlayer.muted ? "Unmute" : "Mute"

                onClicked: {
                    if (musicPlayer.muted)
                        musicPlayer.muted = false
                    else
                        musicPlayer.muted = true
                }
            }

            Slider {
                id: volumeLevel
                Layout.fillWidth: true

                value: musicPlayer.volume
                onMoved: musicPlayer.volume = value
            }
        }

        Label {
            text: "spacer"
            Layout.fillHeight: true
        }
    }
}
