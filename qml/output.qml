import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow{
    id: window
    width: 800
    height: 600
    visible: true
    modality: Qt.ApplicationModal
    title: qsTr("Output")

    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint |Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint

    Material.theme: Material.White
    Material.accent: Material.LightBlue

    property string contentText: ""

    Column {
        width: parent.width - 20
        height: parent.height - 20
        anchors.centerIn: parent

        ScrollView{
            width: parent.width
            height: parent.height - 60

            TextArea {
                id: mainText
                font.pointSize: 14
                wrapMode: Text.WordWrap
                selectByMouse: true
                text: contentText
            }
        }
        
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Button {
                text: qsTr("Copy")
                
                onClicked: {
                    mainText.selectAll()
                    mainText.copy()
                    mainText.deselect()
                }
            }

            Button {
                text: qsTr("Close")
                onClicked: window.close()
            }
        }

        
        
    }    
}