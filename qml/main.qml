import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 

ApplicationWindow{
    id: window
    width: 200
    height: 200
    visible: true
    title: qsTr("Dashboard")

    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint |Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Button {
        id: submitButton
        text: qsTr("Upload Image")
        anchors.centerIn: parent
        onClicked: {
            fileOpen.open()
        }

        FileDialog{
            id: fileOpen
            title: "Open Image"
            nameFilters: ["Image Files (*.png *.jpg)"]
            onAccepted: {
                backend.openFile(fileOpen.currentFile)
            }
        }
    }
    
    Connections {
        target: backend
    }
}