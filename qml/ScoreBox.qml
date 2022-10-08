import QtQuick 2.0
import Felgo 3.0

Item {
    id: scoreBox

    width: 80
    height: 24

    //The score bar below the strand length indicator.
    Rectangle {
        id: scoreMeter
        width: parent.width
        height: 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        color: gameColors.iFaceDSCol

        border.width: 2
        border.color: gameColors.iFaceLightCol

        Rectangle {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 2
            anchors.verticalCenterOffset: 2
            color: gameColors.iFaceDSCol
        }

        Rectangle {
            id: scoreBar

            width: parent.height
            height: parent.width
            anchors.centerIn: parent

            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBrightCol }
                GradientStop { position: 1.0; color: gameColors.iFaceDarkCol }
            } //Close Gradient

            rotation: 90

            x: 4

            border.color: gameColors.iFaceLightCol
            border.width: 2
            clip: true

            Rectangle {
                id: scoreFill

                width: parent.width
                height: parent.height * ((scoreLevel - levelScore) / scoreLevel)
                //                    anchors.top: scoreMeter.top
                //                    anchors.right: scoreMeter.right
                border.color: gameColors.iFaceLightCol
                border.width: 2

                color: gameColors.iFaceDSCol

            } //Close Rectangle 'scoreFill'.

        } //Close Rectangle 'scoreBar'.

        Image {
            id: scoreGlow
            width: parent.height - 4
            height: parent.height + 8
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 3 + (parent.width - 4) * (levelScore / scoreLevel)
            anchors.verticalCenter: parent.verticalCenter
            source: "../assets/gfx/highlight.png"
            opacity: (levelScore / scoreLevel) + 0.4
            visible: {
                if (levelScore / scoreLevel < 0.1)
                    return false
                //                    if (levelScore / scoreLevel > 0.9)
                //                        return false
                return true
            } //Close visible.

            Timer {
                running: (levelScore / scoreLevel < 0.5)
                repeat: true
                interval: 60
                onTriggered: scoreGlow.opacity = (Math.floor(Math.random() * 40) + 40) / 100
            }
        } //Close Image.

        Image {
            id: scoreShine
            width: parent.height + 4
            height: width
            anchors.centerIn: scoreGlow
            source: "../assets/gfx/shine.png"
            opacity: (levelScore / scoreLevel) + 0.4
            visible: {
                if (levelScore / scoreLevel < 0.5)
                    return false
                //                    if (levelScore / scoreLevel > 0.9)
                //                        return false
                return true
            } //Close visible.

            NumberAnimation {
                target: scoreShine
                property: "rotation"
                duration: {
                    var ranDur = 1000 - (levelScore / scoreLevel) * 1000
                    if (ranDur <= 0)
                        return 100
                    else return ranDur
                }
                from: 0
                to: 90
                loops: Animation.Infinite
                running: true
            } //Close NumberAnimation.

        } //Close Image 'scoreShine'.

    } //Close Rectangle 'scoreMeter'.

    //The game score drop shadow. (Complete)
    Text {
        id: scoreTextDS
        font.family: scoreText.font.family
        font.pixelSize: scoreText.font.pixelSize
        anchors.centerIn: scoreText
        anchors.horizontalCenterOffset: 2
        anchors.verticalCenterOffset: 2
        color: "black"
        text: scoreText.text
    } //Close Text. (Complete)

    //The game score display. (Complete)
    Text {
        id: scoreText
        font.family: gameFont.name
        font.pixelSize: 16
        anchors.left: parent.left
        anchors.top: parent.top
        color: gameColors.iFaceHLCol
        style: Text.Outline
        styleColor: gameColors.iFaceDSCol
        text: "Score:"
    } //Close Text. (Complete)

    Text {
        id: actualScoreDS
        font.family: actualScore.font.family
        font.pixelSize: actualScore.font.pixelSize
        color: "black"
        text: actualScore.text
        anchors.centerIn: actualScore
        anchors.horizontalCenterOffset: 2
        anchors.verticalCenterOffset: 2
    } //Close Text. (Complete)

    Text {
        id: actualScore
        font.family: chatFont.name
        font.pixelSize: 14
        color: "white"
        text: gameScore
        anchors.right: parent.right
        anchors.verticalCenter: scoreText.verticalCenter
    } //Close Text. (Complete)

    Text {
        y: 16
        font.family: gameFont.name
        font.pixelSize: 14
        color: gameColors.iFaceHLCol
        style: Text.Outline
        styleColor: gameColors.iFaceDarkCol
        text: "Error Rate:  " //+ Math.floor(errorRate) + " %"
        visible: false
    } //Close Text. (Complete)

} //Close Item 'scoreBox'.

