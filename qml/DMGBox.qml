import QtQuick 2.0
import Felgo 3.0

Item {
    id: dmgBox

    width: 30
    height: width

    property var color: {
        if (envDmg <= 15)
            return "limegreen"
        if (envDmg <= 30)
            return "yellow"
        else return "red"
    }

    Rectangle {
        id: dmgIcon

        anchors.fill: parent
        radius: height / 2
        color: parent.color

        border.color: gameColors.iFaceDSCol
        border.width: 3

        Rectangle {
            width: dmgNum.implicitWidth + 8
            height: dmgNum.implicitHeight + 5
            radius: 6
            color: parent.color
            border.color: gameColors.iFaceDSCol
            border.width: 2
            anchors.centerIn: dmgNum
            anchors.horizontalCenterOffset: -1
            Image {
                anchors.fill: parent
                source: "../assets/gfx/highlight.png"
            }
        }

        Text {
            id: dmgNum
            font.family: gameFont.name
            font.pixelSize: 16

            color: "black" //gameColors.iFaceBrightCol
            //                    style: Text.Outline
            //                        style: Text.Outline
            styleColor: "white"

            text: Math.floor(envDmg) + "%"

            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 1

        } //Close Text 'swapText'. (Complete)

    }
}
