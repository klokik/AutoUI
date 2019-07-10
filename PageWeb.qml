import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtWebEngine 1.8

Page {
    width: 600
    height: 400

    id: page

    property string url // XXX: One side binding
    onUrlChanged: setNewAddress(url)

    function setNewAddress(address) {
        if (address == webEngineView.url) {
            console.log("Url contains same text: ", address);
            return;
        } else {
            console.log("Old URL:", webEngineView.url);
            console.log("New URL request:", address);
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

        function groomUrl(url) {
            console.log("Grooming: '" + url + "'")
            url = url.trim()
            if (url.match(/http[s]?:\/\/.*/i)) {
                console.log("Already valid");
            } else {
                console.log("Specifying 'https' protocol");
                url = "https://" + url;
            }

            console.log("Result: '" + url + "'");
            return url;
        }

        function genSearchUrl(request) {
            var search_engine = "https://duckduckgo.com/?q={query}&kp=-1&kl=us-en";
            var url = search_engine.replace("{query}", encodeURIComponent(request));

            return url;
        }

        if (isUrl(address)) {
            console.log("Is an Url");
            webEngineView.url = /*page.url =*/ groomUrl(address);
        }
        else {
            console.log("Not an Url, searching Web");
            webEngineView.url = /*page.url =*/ genSearchUrl(address);
        }
    }

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
                id: addressField
                Layout.fillWidth: true

                text: webEngineView.url
                selectByMouse: true
                font.pixelSize: Qt.application.font.pixelSize * 2

                onEditingFinished: {
                    setNewAddress(text);
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

        onNewViewRequested: function(request) {
            console.log(request.requestedUrl.toString())
            appContainer.newTab("web", request.requestedUrl.toString())
        }
    }
}
