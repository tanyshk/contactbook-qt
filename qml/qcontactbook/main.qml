import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: rootWindow

    width: 600
    height: 800

    FilialPage {
        id: filialPage
    }

    DepartmentPage {
        id: departmentPage
    }

    StaffPage {
        id: staffPage
    }

    PersonPage {
        id: personPage
    }

    AboutPage {
        id: aboutPage
    }

    SearchPage {
        id: searchPage
        onClose: {
            mainRect.forceActiveFocus();
        }
    }

    SearchResultPage {
        id: searchResultPage

    }

    Rectangle {
        id: mainRect
        color: "#212126"
        anchors.fill: parent
        focus: true


        // Implements back key navigation
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (stackView.depth > 1) {
                    console.log("back depth > 1");
                    stackView.pop();
                    event.accepted = true;
                } else {
                    console.log("back quit");
                    Qt.quit();
                }
            }
        }
    }

    toolBar: BorderImage {
//        border.bottom: 8
//        source: "qrc:/images/toolbar.png"
//        width: parent.width/2
        height: 140
//        height: rootWindow.height * 0.07

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            //height: 50
            height: parent.height
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }

        Text {
            id: header
            //font.pixelSize: 30
            font.pixelSize: parent.height * 0.5
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 10
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            //text: "ContactBook"
            text: stackView.currentItem.header
        }
    }

    menuBar: MenuBar {
        Menu {
            id: menu
            MenuItem {
                id: searchMenuItem
                text: "Поиск"
                onTriggered: stackView.push(searchPage);
                visible: !(stackView.currentItem == searchPage ||
                           stackView.currentItem == searchResultPage ||
                           stackView.currentItem == aboutPage)
            }
    //        MenuItem {
    //            id: aboutMenuItem
    //            text: "О программе"
    //            onTriggered:  {
    //                console.log(stackView.currentItem.id);
    //                stackView.push(aboutPage);
    //            }
    //            visible: !(stackView.currentItem == aboutPage)
    //        }
            MenuItem {
                id: dbItem
                text: "База контактов"
                onTriggered: {
                    fileDialog.open();
                }
            }

            MenuItem {
                id: exitItem
                text: "Выход"
                onTriggered:  {
                    Qt.quit();
                }
            }

        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: filialPage
    }

    FileDialog {
        id: fileDialog
        title: "Выберите файл базы"
        visible: false
        selectMultiple: false
        nameFilters: "Db files (*.db)"
        onAccepted: {
            console.log(fileDialog.fileUrl);
            controller.loadDb(fileDialog.fileUrl);
            close();
        }
        onRejected: {
            close();
        }
    }
}
