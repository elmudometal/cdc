import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
//import Ubuntu.Components 1.3

ColumnLayout{
    width: parent.width
    height: parent.height - 20
    property string editString

    Button{
        text: qsTr("Descargar Archivo")
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            //reader.fileName ="/home/hernan/cdc22.conf"
            //reader.exec()
        }

    }


    Text {
        text: qsTr("Ubicacion Del Archivo")
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextField{
        id: savePath
        text: downladFolder + "/"
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        onTextChanged: downloader.savePath = text
        Component.onCompleted: downloader.savePath = text
    }

    TextArea{
        id: editFile2
        text: networkTabString
        Layout.preferredWidth: parent.width / 1.07
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
    }


    Button{
        id: saveButton
        text: qsTr("Aceptar")
        Layout.preferredWidth: parent.width / 2.1
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            writer2.exec()
        }
    }

}//col


