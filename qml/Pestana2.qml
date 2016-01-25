import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import MyApp 1.0
//import Ubuntu.Components 1.3

ColumnLayout{
    id: rootProcess
    width: parent.width
    height: parent.height - 20
    property string output
    property string parametro


    Text {
        text: qsTr("Nombre:")
        Layout.topMargin: 20
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }

    TextField{
        id: nombreTxt
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter

    }
    Text {
        text: qsTr("Correo Electronico:")
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }
    TextField{
        id: correoTxt
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter

    }
    Text {
        text: qsTr("Contraseña:")
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }
    TextField{
        id: claveTxt
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter

    }
    Text {
        text:{
            if(systemCall.processState === QQmlProcess.Running){
                qsTr("\nCorriendo comando  " + systemCall.program + " Con ID: " + systemCall.pid)
            }else if( systemCall.processState !== QQmlProcess.Running){
                qsTr("\nEstatus: ")
            }
        }
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }


    TextArea{
        id: cmdOutPut
        Layout.preferredWidth: parent.width / 1.07
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        text: systemCallOutPut
    }

    RowLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        Button{
            text: qsTr("Kill Command")
            Layout.preferredWidth: rootProcess.width / 2.2
            onClicked: {
                systemCall.kill()
            }
        }
        Button{
            text: qsTr("Run Command")
            Layout.preferredWidth: rootProcess.width / 2.2
            //tooltip: "use this button to run a system command"
            onClicked: {
                var comando="sh"
                systemCall.program = comando //cmdTxt.text
                var args = "comando.sh "+nombreTxt.text+" "+correoTxt.text+" "+claveTxt.text
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()

            }
        }
    }

    QQmlProcess{
        id: systemCall
        onFinished: {
            console.log("The Qml System Runner has Finished")
            systemCallOutPut = "<b>The Qml System Runner got a error _A_</b>"
        }
        onPidChanged: console.log(pid)
        onRunning: {
            console.log("The Qml System call is running")
        }
        onError: {
            systemCallOutPut = ""
            systemCallOutPut = "<b>The Qml System Runner got a error </b>" + errorString
            /*systemCall.program = "gpg"
            var args = "--list-keys"
            var argToList = args.split(" ");
            systemCall.arguments = argToList
            systemCall.start()*/
        }

        onMessageChanged:{
            // Clear the message
            //systemCallOutPut = ""

            if(program=="gpg"){
                /*var messagetxt=message.split("\n")
                messagetxt = messagetxt[2].split("/");
                messagetxt = messagetxt[1].split(" ");
                systemCallOutPut = messagetxt[0];
                parametro=message;*/
                //systemCallOutPut =message+"casa"
            }else{
                systemCallOutPut =systemCallOutPut +"* "+message+processState
                /*systemCall.program = "gpg" //cmdTxt.text
                var args = "comando.sh "+nombreTxt.text+" "+correoTxt.text+" "+claveTxt.text
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()*/
            }


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





