import QtQuick 2.1
import QtQuick.Controls 1.0

import "text/"
//import "Scrollable/"

//Page {
//    id: filialPage
//    tools: commonTools

//    PageHeader {
//        id: header
//        text: "ContactBook"
//    }

Item {
    width: parent.width
    height: parent.height

    property string header: "ContactBook"

    Connections {
        target: controller
        onDbChanged: {
            console.log("db changed");
            list.model = controller.getModel(0);
        }
    }

    id: filialPage
    ListView {
        id: list
        anchors {
            //top: header.bottom
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 10
            bottomMargin: 10
        }
        clip: true
        model: controller.getModel(0)
        delegate: listItem
//        ScrollBar {
//            flickable: list
//            vertical: true
//        }
    }

    Component {
        id: listItem
        ListDelegate {
            name: modelData.name
            isPressed: listMouseArea.pressed
            MouseArea {
                id: listMouseArea
                anchors.fill: parent
                onClicked: {
                    console.log(modelData.id + " " + modelData.name);
                    departmentPage.id_filial = modelData.id;
                    departmentPage.name_filial = modelData.name;
                    stackView.push(departmentPage);
                }
            }
        }
    }

}
