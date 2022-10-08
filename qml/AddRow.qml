import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: addedRow

    entityType: "addRow"

    width: 48
    height: 12

    anchors.right: gameScene.right
    anchors.rightMargin: 18

    property int row

    Bit_Icon {
        id: bit0
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

    Bit_Icon {
        id: bit1
        anchors.right: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Bit_Icon {
        id: bit2
        anchors.left: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Bit_Icon {
        id: bit3
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

//    Rectangle {
//        anchors.fill: parent
//        color: "red"
//    }

}
