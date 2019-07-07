import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtWebEngine 1.8

Page {
    width: 600
    height: 400

    property alias url: webEngineView.url

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                property int itemAction: WebEngineView.Back
                text: webEngineView.action(itemAction).text
                enabled: webEngineView.action(itemAction).enabled
                onClicked: webEngineView.action(itemAction).trigger()
                icon.name: webEngineView.action(itemAction).iconName
                display: AbstractButton.TextUnderIcon
            }

            ToolButton {
                property int itemAction: WebEngineView.Forward
                text: webEngineView.action(itemAction).text
                enabled: webEngineView.action(itemAction).enabled
                onClicked: webEngineView.action(itemAction).trigger()
                icon.name: webEngineView.action(itemAction).iconName
                display: AbstractButton.TextUnderIcon
            }

            ToolButton {
                property int itemAction: webEngineView.loading ? WebEngineView.Stop : WebEngineView.Reload
                text: webEngineView.action(itemAction).text
                enabled: webEngineView.action(itemAction).enabled
                onClicked: webEngineView.action(itemAction).trigger()
                icon.name: webEngineView.action(itemAction).iconName
                display: AbstractButton.TextUnderIcon
            }

            TextField {
                Layout.fillWidth: true

                text: webEngineView.url
                selectByMouse: true
                font.pixelSize: Qt.application.font.pixelSize * 2

                onEditingFinished: function() {
                    if (text == webEngineView.url) {
                        console.log("Url contains same text");
                        return;
                    } else {
                        console.log("Old URL:", webEngineView.url);
                        console.log("New URL request:", text)
                    }

                    function isUrl(request) {
                        console.log("test for spaces:", request.includes(" "));
                        if (request.includes(" "))
                            return false;

                        console.log("test for dots:", request.includes("."));
                        if (!request.includes("."))
                            return false; // unlikely, except for local domains, which should be prepended explicitly

                        if (request.match(/\.(com|net|org|ua|ru|xyz|icu)/gi))
                            return true;

                        // default
                        return true;
                    }

                    function groomUrl(address) {
                        console.log("Grooming: '" + address + "'")
                        address = address.trim()
                        if (address.match(/http[s]?:\/\/.*/i)) {
                            console.log("Already valid")
                        } else {
                            console.log("Specifying 'https' protocol")
                            address = "https://" + address
                        }

                        console.log("Result: '" + address + "'")
                        return address;
                    }

                    function genSearchUrl(request) {
                        var search_engine = "https://duckduckgo.com/?q={query}&kp=-1&kl=us-en";
                        var url = search_engine.replace("{query}", encodeURIComponent(request));

                        return url;
                    }

                    if (isUrl(text)) {
                        console.log("Is an Url")
                        webEngineView.url = groomUrl(text)
                    }
                    else {
                        console.log("Not an Url, searching Web")
                        webEngineView.url = genSearchUrl(text)
                    }
                }
            }

            ToolButton {
                id: settingsButton
                text: "Settings"
                icon.name: "settings-configure"
                display: AbstractButton.TextUnderIcon
                onClicked: settingsMenu.open()
                checked: settingsMenu.visible

                Menu {
                    id: settingsMenu
                    y: settingsButton.height

                    MenuItem {
                        id: customContextMenuOption
                        checkable: true
                        checked: true

                        text: "Custom context menu"
                    }
                }
            }
        }
    }

    WebEngineView {
        id: webEngineView
        url: "https://duckduckgo.com"
        anchors.fill: parent

        Component.onCompleted: {
            profile.downloadRequested.connect(function(download){
                download.accept();
            })
        }

        property Menu contextMenu: Menu {
            Repeater {
                model: [
                    WebEngineView.Back,
                    WebEngineView.Forward,
                    WebEngineView.Reload,
                    WebEngineView.SavePage,
                    WebEngineView.Copy,
                    WebEngineView.Paste,
                    WebEngineView.Cut
                ]
                MenuItem {
                    text: webEngineView.action(modelData).text
                    enabled: webEngineView.action(modelData).enabled
                    onClicked: webEngineView.action(modelData).trigger()
                    icon.name: webEngineView.action(modelData).iconName
                    display: MenuItem.TextBesideIcon
                }
            }
        }

        onContextMenuRequested: function(request) {
            if (customContextMenuOption.checked) {
                request.accepted = true;
                contextMenu.popup();
            }
        }
    }
}
