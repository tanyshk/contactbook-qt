import QtQuick 2.1
import "text/"
//import "Scrollable/"

Item {
    id: departmentPage
    //tools: commonTools

    property int id_filial: -1
    property string name_filial: ""
    property string header: name_filial

//    PageHeader {
//        id: header
//        text: name_filial
//    }

    ListView {
        id: list
        anchors {
//            top: header.bottom
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
//            margins: 10
            fill: parent
        }
        clip: true
        model: controller.getModel(id_filial);
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
                    console.log(modelData.id);
                    staffPage.id_department = modelData.id;
                    staffPage.name_department = modelData.name;
                    stackView.push(staffPage);
                }
            }
        }
    }

}
