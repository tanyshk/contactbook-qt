import QtQuick 2.1
import "text/"

Item {
    id: textItem
    property string key
    property string value

    width: parent.width
    height: caption.height + data.height
    TextKey {
        id: caption
        text: textItem.key
        font.pixelSize: rootWindow.height * 0.025
    }

    TextData {
        id: data
        text: textItem.value
        anchors.top: caption.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        wrapMode: Text.WordWrap
        font.pixelSize: rootWindow.height * 0.025
    }

}
