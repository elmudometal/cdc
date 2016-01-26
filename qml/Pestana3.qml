import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import MyApp 1.0
//import Ubuntu.Components 1.3

ColumnLayout{
    id: rootProcess2
    width: parent.width
    height: parent.height - 20
    property string output
    property string parametro
    RowLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        Text {
            text: qsTr("Clave GPG Generadas:")
            Layout.topMargin: 20
            Layout.preferredWidth: rootProcess2.width / 2.2
            Layout.alignment: Qt.AlignHCenter
        }
        Button{
            text: qsTr("Ver Claves")
            Layout.topMargin: 20
            Layout.preferredWidth: rootProcess2.width / 2.2
            //tooltip: "use this button to run a system command"
            onClicked: {
                var comando="gpg"
                systemCall.program = comando //cmdTxt.text
                var args = "--fingerprint"
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()

            }
        }
    }
    TextArea{
        id: cmdOutPut2
        Layout.preferredWidth: parent.width / 1.10
        Layout.preferredHeight: parent.height / 3.07
        Layout.alignment: Qt.AlignHCenter
        text: systemCallOutPut2
    }
    Text {
        text: qsTr("Número de tu llave GPG:")
        //Layout.topMargin: 20
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }

    RowLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        TextField{
            id: gpgTxt
            Layout.preferredWidth: parent.width / 2.2
            Layout.alignment: Qt.AlignHCenter

        }
        Button{
            text: qsTr("Enviar Llave al Servidor?")
            Layout.preferredWidth: rootProcess2.width / 2.2
            //tooltip: "use this button to run a system command"
            onClicked: {
                var comando="gpg"
                systemCall.program = comando //cmdTxt.text
                var args = "--send-keys "+gpgTxt.text
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()

            }
        }
    }
    Text {
        text: qsTr("Fingerprint:")
        //Layout.topMargin: 20
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }
    TextField{
        id: fingerprintTxt
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter

    }




    RowLayout{
    }
    RowLayout{
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
            // Clear the message
            //systemCallOutPut2 = ""
            var messagetxt=message.split("\n")
            var fingerprint = messagetxt[3].split("=");
            messagetxt = messagetxt[2].split("/");
            messagetxt = messagetxt[1].split(" ");
            parametro = messagetxt[0];
            gpgTxt.text=parametro;
            fingerprintTxt.text=qsTr(fingerprint[1]);
            //systemCallOutPut2 =message+"casa"

            systemCallOutPut2 =message
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
}//col

