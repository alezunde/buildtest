import QtQuick 2.0
import Felgo 3.0

Item {
    id: gameHelper

    anchors.fill: parent

    Item {
        id: helperHand
        width: 128
        height: width
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Rectangle {
            width: 106
            height: width
            radius: height / 2
            anchors.centerIn: parent
            color: "red"
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent"}
                GradientStop { position: 1.0; color: gameColors.iFaceCol}
            }
        }

        Image {
            anchors.fill: parent
            source: "../assets/gfx/helper.png"
        }
    }

}
