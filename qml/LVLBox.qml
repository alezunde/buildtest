import QtQuick 2.0
import Felgo 3.0

//The swap mode indicator text. (Complete)
Item {
    id: lvlBox
    width: 30
    height: 32

    Text {
        id: lvlTextDS

        font.family: lvlText.font.family
        font.pixelSize: lvlText.font.pixelSize

        color: "black"

        text: lvlText.text

        anchors.centerIn: lvlText
        anchors.horizontalCenterOffset: 2
        anchors.verticalCenterOffset: 2

    } //Close Text 'swapText'. (Complete)

    Text {
        id: lvlText

        font.family: gameFont.name
        font.pixelSize: 14

        color: "white" //gameColors.iFaceBrightCol
        //                    style: Text.Outline

        text: "LVL"

        anchors.centerIn: parent
        anchors.verticalCenterOffset: -8

    } //Close Text 'swapText'. (Complete)

    Text {
        id: lvlNumDS

        font.family: lvlNum.font.family
        font.pixelSize: lvlNum.font.pixelSize

        color: gameColors.iFaceDSCol

        text: lvlNum.text

        anchors.centerIn: lvlNum
        anchors.horizontalCenterOffset: 2
        anchors.verticalCenterOffset: 2

    } //Close Text 'swapText'. (Complete)

    Text {
        id: lvlNum

        font.family: gameFont.name
        font.pixelSize: 24

        color: gameColors.iFaceBrightCol
        style: Text.Outline
        styleColor: gameColors.iFaceDSCol

        anchors.centerIn: parent
        anchors.verticalCenterOffset: 7

        text: gameLevel

    } //Close Text 'swapText'. (Complete)

} //Close Item 'swapLight'.
