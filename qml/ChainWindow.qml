import QtQuick 2.0
import Felgo 3.0

Item {
    id: chainWindow
    width: 48
    height: width

    Rectangle {
        width: parent.width - 8
        height: width
        radius: height / 2
        anchors.centerIn: parent
        color: gameColors.iFaceLightCol
        border.color: gameColors.iFaceDSCol
        border.width: 1
    }

    Rectangle {
        width: parent.width - 14
        height: width
        radius: height / 2
        anchors.centerIn: parent
        color: gameColors.iFaceLightCol
        border.color: gameColors.iFaceCol
        border.width: 4
    }

    Rectangle {
        width: 12
        height: width
        radius: height / 2
        anchors.centerIn: parent
        color: "transparent"
        border.color: "black"
        border.width: 2
        visible: strChain <= 1
    }

    Text {
        id: chainNumDS

        font.family: chainNum.font.family
        font.pixelSize: chainNum.font.pixelSize

        color: gameColors.iFaceDSCol

        anchors.centerIn: chainNum
        anchors.horizontalCenterOffset: 3
        anchors.verticalCenterOffset: 2

        text: chainNum.text

        visible: chainNum.visible

    } //Close Text 'swapText'. (Complete)

    Text {
        id: chainNum

        font.family: chatFont.name
        font.pixelSize: 18

        color: gameColors.iFaceBrightCol
        style: Text.Outline
        styleColor: "black"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -1
        text: {
            if (strChain > 1)
                return strChain
            return ""
        }

        visible: strChain > 1

    } //Close Text 'swapText'. (Complete)

    Rectangle {
        width: 8
        height: width
        radius: height / 2
        color: "white"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenterOffset: -8
    }

    Text {
        id: chainTextDS

        font.family: chainText.font.family
        font.pixelSize: chainText.font.pixelSize
        font.weight: chainText.font.weight
        horizontalAlignment: chainText.horizontalAlignment
        color: "black" // gameColors.iFaceBrightCol
        anchors.centerIn: chainText
        anchors.horizontalCenterOffset: 2
        anchors.verticalCenterOffset: 2
        text: chainText.text

    } //Close Text 'swapText'. (Complete)

    Text {
        id: chainText

        font.family: gameFont.name
        font.pixelSize: 16
        font.weight: Font.Bold
        horizontalAlignment: Text.AlignHCenter
        //            lineHeight: 0.8

        color: "white" // gameColors.iFaceBrightCol
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenterOffset: -43
        text: {
            if (bestChain > 1)
                return "BEST<br/>CHAIN<br />" + bestChain
            else return "BEST<br/>CHAIN<br />--"
        }

    } //Close Text 'swapText'. (Complete)
}
