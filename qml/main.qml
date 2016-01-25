import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
//import Ubuntu.Components 1.3
import MyApp 1.0

Window {
    visible: true
    width: 800//Screen.width/2
    height: 700//Screen.height/2
    color: "#c7c7c7"
    title: ".:Firma del Codigo de Conducta:."

    //NetworkTab
    property string networkTabString
    property int max
    property int val
    property bool showProgression: false

    // process Tab
    property string systemCallOutPut
    // pestana3 Tab
    property string systemCallOutPut2
    // pestana5 Tab
    property string systemCallOutPut3


    TabView{

        anchors.fill: parent
        Tab{

            title: qsTr("Paso #1 ")
                Pestana1{
                    id: networkTab
                }
        }
        Tab{
            title: qsTr("Paso #2 GPG")
            Pestana2{
                id: processTab
            }
        }
        Tab{
            title: qsTr("Paso #3 Verificar y enviar firma")
            Pestana3{
                id: process2Tab
            }
        }
        Tab{
            title: qsTr("Paso #4 Validar firma")
            Pestana4{
                id: process3Tab
            }
        }
        Tab{
            title: qsTr("Paso #5 Firmar CDC")
            Pestana5{
                id: process3Tab
            }
        }
    }

    // The c++ classes
    Downloader{
        id: downloader
        onFinished: {
            showProgression = false
            // open the file now that we downloaded it
            reader.fileName =savedFile //"/home/hernan/cdc.conf"
            reader.exec()
        }
        onBytesReceivedChanged:{
            val =  bytesReceived
        }
        onBytesTotalChanged:{
            max = bytesTotal
        }

    }
    QQmlFile{
        id: reader
        onError: console.log("There has been a error " + errorString +" "+ fileName)
        onTextChanged: networkTabString = outPut
    }
    QQmlFile{
        id: writer
        fileName: reader.fileName
        onError: console.log("There has been a error " + errorString)
        type: QQmlFile.Write
    }


}
