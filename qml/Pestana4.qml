import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import MyApp 1.0
//import Ubuntu.Components 1.3

ColumnLayout{
    width: parent.width
    height: parent.height - 20
    property string editString

    Button{
        Layout.topMargin: 20
        text: qsTr("Crear Archivo Cifrado")
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            reader.fileName ="/home/hernan/lauchpad.txt"
            reader.exec()
        }

    }


    Text {
        text: qsTr("Ubicación Del Archivo")
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
        text: qsTr("Guardar")
        Layout.preferredWidth: parent.width / 2.1
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            writer.incoming=editFile2.text
            writer.exec()
        }
    }
    TextArea{
        id: editFile3
        Layout.preferredWidth: parent.width / 1.07
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        text: systemCallOutPut2
    }


    Button{
        id: save2Button
        text: qsTr("Descifrar Archivo")
        Layout.preferredWidth: parent.width / 2.1
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            var comando="gpg"
            systemCall.program = comando //cmdTxt.text
            var args = "--batch --decrypt "+"/home/hernan/lauchpad.txt"
            var argToList = args.split(" ");
            systemCall.arguments = argToList
            systemCall.start()
        }
    }

    QQmlProcess{
        id: systemCall
        onFinished: {
            console.log("The Qml System Runner has Finished")
        }
        onPidChanged: console.log(pid)
        onRunning: {
            console.log("The Qml System call is running")
        }
        onError: {
            systemCallOutPut2 = ""
            systemCallOutPut2 = "<b>The Qml System Runner got a error </b>" + errorString
            /*systemCall.program = "gpg"
            var args = "--list-keys"
            var argToList = args.split(" ");
            systemCall.arguments = argToList
            systemCall.start()*/
        }

        onMessageChanged:{


            systemCallOutPut2 =message

        }
        onProcessStateChanged: {
            console.log("the state " +processState)
        }
        Component.onCompleted: {
            // set the models
            for(var i = 0 ; i < runTypes.length; i++){
                runtypesModel.append({"text": runTypes[i] })
            }
            for(var o=0; o< inputChannelModeTypes.length ; o++ ){
                inputChannelModel.append({"text": inputChannelModeTypes[o]})
            }

            for(var p = 0 ; p < processChannelModeTypes.length; p++){
                processChannelModeModel.append({"text":processChannelModeTypes[p]})
            }
            for (var q= 0 ; q < processChannelTypes.length; q++){
                processChannelModel.append({"text":processChannelTypes[q]})
            }


        }


    }
    ListModel{id: runtypesModel}
    ListModel{id: inputChannelModel}
    ListModel{id: processChannelModeModel}
    ListModel{id: processChannelModel}

}
