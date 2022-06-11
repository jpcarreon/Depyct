import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow{
    id: window
    width: 275
    height: 175
    visible: true
    modality: Qt.ApplicationModal
    title: qsTr("Error!")
    

    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint |Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint

    Material.theme: Material.White
    Material.accent: Material.LightBlue

    property string errorText: "Error:\n"

    Column {
        width: parent.width
        anchors.centerIn: parent

        Row {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter


            Image {
                id: image
                source: "../Images/warning.svg"
                sourceSize: Qt.size(75, 75)
            }
            

            Text {
                width: 125
                text: errorText
                font.pixelSize: 14
                wrapMode: Text.WordWrap
            }
            
        }

        Button {
            id: button
            height: 40
            text: qsTr("OK")
            anchors.right: parent.right
            anchors.rightMargin: 20
            onClicked: {
                window.close()
            }
        }
    }
}