import QtQuick 2.1
import QtQuick.Controls 1.0
import "text/"

Item {
    id: callItem
    property string key
    property string value

    visible: callItem.value != ""

    width: parent.width
    height: caption.height + number.height
    TextKey {
        id: caption
        text: callItem.key
        font.pixelSize: rootWindow.height * 0.025
    }

//    Item {
//        anchors.top: caption.bottom
//        anchors.left: parent.left
//        anchors.leftMargin: 30
//        anchors.right: parent.right
//        anchors.rightMargin: 20
//        height: 80

//        Row {
//            Image {
//                source: "qrc:/images/phone.png"
//            }

//            TextData {
//                id: number
//                text: callItem.value

//            }
//        }
//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                controller.call(callItem.value);
//            }
//        }
//    }

    Button {
        id: number
        iconSource: "qrc:/images/phone.png"
        text: callItem.value
        anchors.top: caption.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 20
        //height: 50
        height: rootWindow.height * 0.06
        onClicked: {
            //Qt.openUrlExternally("tel:" + callItem.value);
            controller.call(callItem.value);
        }
    }

}
