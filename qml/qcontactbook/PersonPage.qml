import QtQuick 2.1
import QtQuick.Controls 1.0
import "text/"

Item {
    id: personPage
    //tools: commonTools

    property int id_person: -1
    property QtObject person: null
    property string header: ""

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    function update()
    {
        personPage.person = null;
        personPage.person = controller.getPerson(personPage.id_person);
    }

//    PageHeader {
//        id: header
//        text: ""
//    }

    Flickable {
        id: flick
        anchors {
//            top: header.bottom
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
            fill: parent
            //margins: 10
        }

//        ScrollBar {
//            flickable: flick
//            vertical: true
//        }
        contentWidth: parent.width
        contentHeight: info.implicitHeight
        clip: true
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: info
            //anchors.left: parent.left
            //anchors.right: parent.right
            anchors.fill: parent

            spacing: 5

            Image {
                source: person ? "image://photo/"+person.id : ""
            }

            TextItem {
                key: "ФИО:"
                value: person ? person.name : ""
            }
            TextItem {
                key: "Должность:"
                value: person ? person.title : ""
            }
            TextItem {
                key: "Отдел:"
                value: person ? person.department : ""
            }
            TextItem {
                key: "Филиал:"
                value: person ? person.filial : ""
            }
            CallItem {
                key: "Телефон мобильный:"
                value: person ? person.mobile : ""
            }
            CallItem {
                key: "Телефон рабочий:"
                value: person ? person.phone : ""
            }
            CallItem {
                key: "Телефон домашний:"
                value: person ? person.home : ""
            }
            TextItem {
                key: "Дата рождения:"
                value: person ? person.birth : ""
            }
            Button {
                id: add
                text: "Добавить контакт"
                //anchors.top: caption.bottom
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 20
                //height: 50
                height: rootWindow.height * 0.06
                onClicked: {
                    //Qt.openUrlExternally("tel:" + callItem.value);
                    controller.addContact(person.name, person.mobile, person.phone, person.filial, person.title);
                }
            }

        }
    }

}

