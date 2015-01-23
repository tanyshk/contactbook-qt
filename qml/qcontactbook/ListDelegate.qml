import QtQuick 2.1
import "text/"

Item {
    property string name: ""
    property bool isPressed: false

    //height: 80
    height: rootWindow.height * 0.07
    width: parent.width

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        color: isPressed ? "#b4cee5" : "#e0e1e2"
    }

    TextCommon {
        text: name
        //font.pixelSize: 26
        font.pixelSize: parent.height * 0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: arrow.left
        anchors.rightMargin: 5
        wrapMode: Text.WordWrap
    }
    Image {
        id: arrow
        source: "qrc:/images/arrow.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
    Rectangle {
        anchors.top: parent.bottom
        width: parent.width
        height: 1
        color: "gray"
        //z: 2
    }
}
