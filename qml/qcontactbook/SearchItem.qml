import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import "text/"

Item {
    id: item
    property string label: ""
    property alias value: textField.text
    property bool isPhoneNumber: false
    property string header: ""

    signal changed
    signal accepted

    width: parent.width
    height: textField.height

//    SipAttributes {
//        id: sipAttributes
//        actionKeyLabel: "Искать"
//        actionKeyEnabled: true
//    }

//    TextKey {
//        id: textLabel
//        text: label
//        anchors.top: parent.top
//    }
    TextField {
        id: textField
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        //font.pointSize: 14
        font .pixelSize: height * 0.5
        //height: 50
        height: rootWindow.height * 0.06
        maximumLength: 80
        inputMethodHints: isPhoneNumber ? (Qt.ImhDialableCharactersOnly | Qt.ImhNoPredictiveText) : 0
        placeholderText: item.label
        style: TextFieldStyle {
            background: Rectangle {
                color: white
                radius: 3
            }
        }

        onAccepted: item.accepted()

        Image {
            id: clearButton
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            //height: 40
            height: textField.height * 0.6
            source: "qrc:/images/clear1.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    textField.text = "";
                }
            }
        }
    }
}
