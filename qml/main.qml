import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 

ApplicationWindow{
    id: window
    width: 400
    height: 200
    visible: true
    title: qsTr("Depyct")

    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint |Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    
    Rectangle {
        id: miniAlertRect
        width: parent.width - 50
        height: 20
        radius: 4
        color: Material.color(Material.Blue)

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10

        Text {
            id: miniAlertText
            text: qsTr("Idle")
            font.pixelSize: 14
            color: "#ffffff"

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    

    Column {
        id: column
        anchors.centerIn: parent

        Row {
            id: row
            height: 48
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: submitButton
                text: qsTr("Upload Image")
                onClicked: {
                    fileOpen.open()
                }

                FileDialog {
                    id: fileOpen
                    title: "Open Image"
                    nameFilters: ["Image Files (*.png *.jpg)"]
                    onAccepted: {
                        backend.openFile(fileOpen.currentFile)
                    }
                }
            }

            Button {
                id: clipboardButton
                text: qsTr("")
                icon.source: "../Images/content-paste.svg"
                onClicked: {
                    backend.getClipboard()
                }
            }
        }

        Button {
            id: button
            text: qsTr("Parse Data")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                backend.printContents()
            }
            
        }
    }
    
    Connections {
        target: backend

        function onSignalPaste(value) {
            if (!value) {
                var component = Qt.createComponent("error.qml")
                var win = component.createObject()
                win.errorText += "Invalid Clipboard Contents!"
                win.show()
                miniAlertText.text = "Failed to parse"
                miniAlertRect.color = "#ff0000"
            } else {
                miniAlertText.text = "Input parsed successfully"
                miniAlertRect.color = Material.color(Material.Blue)
            }
        }
    }
}