import QtQuick 2.1
import "text/"

Item {
    id: aboutPage
    //tools: commonTools

//    PageHeader {
//        id: header
//        text: "О программе"
//    }
    property string header: ""

    Column {
        anchors {
//            top: header.bottom
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
            margins: 10
            fill: parent
        }
        spacing: 10
        TextAbout {
            text: "ContactBook v0.1 for Android"
            width: parent.width
            font.bold: true
        }
        TextAbout {
            text: "Корпаротивный телефонный справочник работников УП \"Витебскоблгаз\""
            width: parent.width
        }
    }
}
