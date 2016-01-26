import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import MyApp 1.0
//import Ubuntu.Components 1.3

ColumnLayout{
    width: parent.width
    height: parent.height - 20
    property string editString
    property string file

    Button{
        text: qsTr("Firmar Código de Conducta")
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            file="/home/hernan/UbuntuCodeofConduct.txt"
            var comando="gpg"
            //gpg --batch --passphrase "abcdefgh" --clearsign /home/hernan/gpl-3.0.txt
            systemCall.program = comando //cmdTxt.text
            var args = "--batch --clearsign "+file
            var argToList = args.split(" ");
            systemCall.arguments = argToList
            systemCall.start()
            reader.fileName =file+".asc"
            reader.exec()

        }

    }

    TextArea{
        id: editFile3
        Layout.preferredWidth: parent.width / 1.07
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        text: networkTabString
    }


    Button{
        id: saveButton
        text: qsTr("Aceptar")
        Layout.preferredWidth: parent.width / 2.1
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
            writer.exec()

        }
    }

    QQmlProcess{
        id: systemCall
        onFinished: {
            console.log("The Qml System Runner has Finished")
            systemCallOutPut3 = "<b>The Qml System Runner got a error _A_</b>"
        }
        onPidChanged: console.log(pid)
        onRunning: {
            console.log("The Qml System call is running")
        }
        onError: {
            systemCallOutPut3 = ""
            systemCallOutPut3 = "<b>The Qml System Runner got a error </b>" + errorString

        }

        onMessageChanged:{
            // Clear the message
            //systemCallOutPut3 = ""

            systemCallOutPut3 =systemCallOutPut3 +"* "+message+processState

                /*systemCall.program = "gpg" //cmdTxt.text
                var args = "comando.sh "+nombreTxt.text+" "+correoTxt.text+" "+claveTxt.text
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()*/



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


