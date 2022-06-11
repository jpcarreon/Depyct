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

    Row {
        id: row
        width: 210
        height: 48
        spacing: 10
        leftPadding: 20
        anchors.centerIn: parent
        
        

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
    
    Connections {
        target: backend
    }
}