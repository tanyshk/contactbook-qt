import QtQuick 2.1
//import com.nokia.meego 1.0
import "text/"
//import "Scrollable/"

Item {
    id: staffPage
    //tools: commonTools

    property int id_department: -1
    property string name_department: ""
    property string header: name_department

//    PageHeader {
//        id: header
//        text: name_department
//    }

    ListView {
        id: list
        anchors {
            fill: parent
        }
        clip: true
        model: controller.getStaff(id_department);
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
                    personPage.id_person = modelData.id;
                    personPage.update();
                    //personPage.person = controller.getPerson(modelData.id);
                    stackView.push(personPage);
                }
            }
        }
    }

}
