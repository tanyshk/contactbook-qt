import QtQuick 2.1
import "text/"

Item {
    id: searchResultPage
    //tools: commonTools

    property string name: ""
    property string mobile: ""
    property string header: "Результаты поиска"

//    PageHeader {
//        id: header
//        text: "Результаты поиска"
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
        model: if (name != "" || mobile != "") controller.searchResult(searchResultPage.name, searchResultPage.mobile);
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
