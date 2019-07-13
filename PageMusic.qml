import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import QtMultimedia 5.12

Page {
    padding: width * 0.05

    Audio {
        id: musicPlayer
//        source: "file:///home/klokik/Music/track.flac"

        playlist: trackList
    }

    Playlist {
        id: trackList
        playbackMode: Playlist.Loop

        PlaylistItem { source: "file:///home/klokik/Music/track.flac" }
        PlaylistItem { source: "file:///home/klokik/Music/track1.mp3" }
        PlaylistItem { source: "file:///home/klokik/Music/track2.mp3" }
        PlaylistItem { source: "file:///home/klokik/Music/track3.mp3" }
    }

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: albumCover
            source: "file:///home/klokik/Pictures/Cover.jpg"
            Layout.preferredHeight: width
            Layout.fillWidth: true

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (musicPlayer.playbackState != Audio.PlayingState)
                        musicPlayer.play()
                    else
                        musicPlayer.pause()
                }
            }
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
                onClicked: trackList.previous()
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
                    if (musicPlayer.playbackState != Audio.PlayingState)
                        musicPlayer.play()
                    else
                        musicPlayer.pause()
                }
            }
            Button {
                text: "Next"
                Layout.fillWidth: true
                onClicked: trackList.next()
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

        ListView {
            id: trackListView
            Layout.fillHeight: true

            model: trackList
            delegate: Text {
                text: source
                font.pointSize: 16

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        trackList.currentIndex = index
                        console.log(parent.text)
                        musicPlayer.play()
                    }
                }
            }

            currentIndex: trackList.currentIndex
            highlight: Rectangle { color: "lightsteelblue"; }
            interactive: true
        }
    }
}
