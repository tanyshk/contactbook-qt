import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import "text/"

Item {
    id: searchPage
    signal close
    //tools: commonTools

//    PageHeader {
//        id: header
//        text: "Поиск"
//    }
    property string header: "Поиск"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("search page clicked");
        }
    }

    function search()
    {
        Qt.inputMethod.hide();
        searchPage.close();
        searchResultPage.name = name.value;
        searchResultPage.mobile = mobile.value;
        stackView.push(searchResultPage);
    }

    Flickable {
        id: container
        anchors {
//            top: header.bottom
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
//            margins: 10
            fill: parent
        }

        contentWidth: parent.width
        contentHeight: fields.height
        clip: true
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: fields
            spacing: 30
            width: container.width

            SearchItem {
                id: name
                label: "ФИО:"
                onChanged: {
                    searchResultPage.name = name.value;
                    searchResultPage.mobile = mobile.value;
                    stackView.push(searchResultPage);
                }
                onAccepted: search()
            }
            SearchItem {
                id: mobile
                label: "Телефон:"
                isPhoneNumber: true
                onChanged: {
                    searchResultPage.name = name.value;
                    searchResultPage.mobile = mobile.value;
                    stackView.push(searchResultPage);
                }
            }

            Button {
                id: searchbtn
                text: "Искать"
                width: parent.width
                //height: 50
                height: rootWindow.height * 0.06
                style: ButtonStyle {
                    label: TextCommon {
                        //font.pointSize: 14
                        font.pixelSize: height * 0.5
                        //color: "#ffffff"
                        text: control.text
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                onClicked: {
                    search();
                }
            }
//            Text {
//                color: "red"
//                width: parent.width
//                height: 50
//                wrapMode: Text.WordWrap
//                font.pixelSize: 18
//                text: controller.getError()
//            }
        }

    }

}
