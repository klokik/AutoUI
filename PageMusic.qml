import QtQuick 2.12

import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.13

Page {
    padding: 20

    id: page

    Audio {
        id: musicPlayer

        playlist: trackList
    }

    FolderListModel {
        id: folderTrackModel
        showDotAndDotDot: false
        showDirs: false
        showOnlyReadable: true

//        folder: "file:///home/klokik/Music"
        folder: "file:///home/klokik/Music/yt/syrex"
        nameFilters: ["*.flac", "*.wav", "*.opus", ".ogg", "*.aac", "*.m4a", "*.mp3"]

        onStatusChanged: {
            if (status == FolderListModel.Ready) {
                console.log("Count: ", count)
                for (var i = 0; i < count; ++i) {
                    var url = get(i, "fileURL")
                    trackList.addItem(get(i, "fileURL"))
                }
            }
        }
    }

    Playlist {
        id: trackList
        playbackMode: Playlist.Loop

        PlaylistItem {
            source: "http://kcrw.streamguys1.com/kcrw_192k_mp3_e24_internet_radio"
        }

        onItemChanged: trackListView.itemsHeightReserve = itemCount
    }

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        contentHeight: 2048

        Rectangle {
            anchors.fill: parent
            color: "pink"
        }

        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right

            RowLayout {
                Layout.fillWidth: true

                Image {
                    id: albumCover
                    source: "qrc:/res/AlbumCover.png"
                    Layout.maximumWidth: Math.min(page.height * 0.4, page.width - 200)
                    Layout.preferredHeight: width

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
                    id: metaRect
    //                color: "lime"
                    Layout.preferredHeight: albumCover.height
                    Layout.fillWidth: true

                    Column {
                        anchors.centerIn: parent
                        spacing: 10

                        Text {
                            text: musicPlayer.metaData.albumTitle ? musicPlayer.metaData.albumTitle : "Unknown Album"
                            font.pointSize: 20
                            width: metaRect.width
                            anchors.horizontalCenter: parent.horizontalCenter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: musicPlayer.metaData.albumArtist ? musicPlayer.metaData.albumArtist : "Unknown Artist"
                            font.pointSize: 18
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: musicPlayer.metaData.year ? musicPlayer.metaData.year : ""
                            font.pointSize: 18
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: musicPlayer.metaData.genre ? musicPlayer.metaData.genre : ""
                            font.pointSize: 16
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: (musicPlayer.metaData.audioBitRate / 1000) + "kbps"
                            font.pointSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: musicPlayer.metaData.audioCodec ? musicPlayer.metaData.audioCodec : ""
                            font.pointSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            Text {
                text: musicPlayer.metaData.title ? musicPlayer.metaData.title : "Unk"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 36

                Layout.fillWidth: true
                Layout.topMargin: 16
                Layout.bottomMargin: 16
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
//                Layout.fillHeight: true

                property var itemHeight: 16
                property var itemsHeightReserve: 24
                Layout.minimumHeight: 480 + itemHeight * itemsHeightReserve
                contentHeight: 480 + itemHeight * itemsHeightReserve
//                spacing: itemHeight

                model: trackList
                delegate: ItemDelegate {
                    text: source
                    font.pointSize: 16
                    height: parent.itemHeight

                    onClicked: {
                        trackList.currentIndex = index
                        console.log(parent.text)
                        musicPlayer.play()
                    }
                }

                currentIndex: trackList.currentIndex
                highlight: Rectangle { color: "lightsteelblue"; }
                interactive: true
            }

            Rectangle {
                color: "green"
                Layout.fillWidth: true
                height: 16
            }
        }
    }
}
