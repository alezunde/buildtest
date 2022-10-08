import QtQuick 2.0
import Felgo 3.0

Item {
    id: finalScreen

    anchors.fill: parent

    visible: false

    Rectangle {
        id: backColor
        anchors.fill: parent
        color: gameColors.iFaceBGCol

        NumberAnimation {
            id: backFade
            target: backColor
            running: finalScreen.visible
            property: "opacity"
            from: 0
            to: 0.6
            duration: 2400
            easing.type: Easing.OutCirc
        }
    }

    Item {
        id: resultsBG
        width: parent.width - 64
        height: parent.height - 64

        anchors.centerIn: parent

        visible: true

        NumberAnimation {
            id: bgIn
            running: finalScreen.visible
            target: resultsBG
            properties: "width"
            from: 0
            to: parent.width - 64
            duration: 1200
            easing.type: Easing.OutCirc
            onStopped: scoreTotals.visible = true
        }

        Rectangle {
            id: screenBlockDS
            width: parent.width
            height: parent.height
            radius: 12
            anchors.centerIn: screenBlock
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenterOffset: 3
            color: "black"
        }

        Rectangle {
            id: screenBlock
            width: parent.width - 2
            height: parent.height - 2
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -2
            anchors.verticalCenterOffset: -2
            radius: 12
            color: gameColors.iFaceDSCol

            Rectangle {
                width: parent.width - 16
                height: parent.height - 16
                radius: 4
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceLightCol
            }

            Item {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                clip: true

//                Image {
//                    width: finalScreen.width
//                    height: finalScreen.height
//                    anchors.centerIn: parent
//                    anchors.horizontalCenterOffset: 1
//                    anchors.verticalCenterOffset: 1
//                    source: "../assets/gfx/splashBG.png"
//                }

                Rectangle {
                    width: parent.width - 44
                    height: parent.height / 2
                    anchors.centerIn: parent
                    color: gameColors.iFaceLightCol
                    border.color: gameColors.iFaceCol
                    border.width: 2
                }

                Rectangle {
                    width: parent.width
                    height: 44
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -4
                    color: gameColors.iFaceLightCol
                    border.color: gameColors.iFaceCol
                    border.width: 2
                }

                Rectangle {
                    width: 12
                    height: parent.height
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    color: gameColors.iFaceLightCol
                    border.color: gameColors.iFaceCol
                    border.width: 2
                }

                Rectangle {
                    width: 12
                    height: parent.height
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    color: gameColors.iFaceLightCol
                    border.color: gameColors.iFaceCol
                    border.width: 2
                }
            }

            Rectangle {
                width: parent.width
                height: parent.height
                radius: 12
                anchors.centerIn: parent
                color: "transparent"
                border.color: gameColors.iFaceDarkCol
                border.width: 6
            }
        }

//        Image {
//            width: parent.width - 64
//            height: 96
//            anchors.centerIn: parent
//            anchors.verticalCenterOffset: -130
//            source: "../assets/gfx/splashTitle.png"
//        }
    }

    Item {
        id: scoreTotals
        width: 180
        height: 370
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 55

        visible: false
        clip: true

        NumberAnimation {
            id: totalDrop
            running: scoreTotals.visible
            target: scoreTotals
            property: "height"
            from: 0
            to: 370
            duration: 800
            easing.type: Easing.OutCirc
        }

        Rectangle {
            anchors.fill: parent
            radius: 6
            color: "black" //gameColors.iFaceDSCol

            Image {
                width: 180
                height: 240
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: "../assets/gfx/totBG_earth.png"
                opacity: 0.3
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: "white" //gameColors.iFaceLightCol
                border.width: 2
            }
        }

        Text {
            id: headerTxtDS
            font.family: headerTxt.font.family
            font.pixelSize: headerTxt.font.pixelSize
            anchors.centerIn: headerTxt
            anchors.horizontalCenterOffset: 2
            anchors.verticalCenterOffset: 2
            color: "black"
            text: headerTxt.text
        }

        Text {
            id: headerTxt
            font.family: gameFont.name
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 12
            color: "white"
            text: "Final Results"
        }

        Item {
            id: scoreText
            anchors.fill: scoreTotals

            Text {
                id: bitsScoredDS
                font.family: bitsScored.font.family
                font.pixelSize: bitsScored.font.pixelSize
                lineHeight: bitsScored.lineHeight
                horizontalAlignment: bitsScored.horizontalAlignment
                anchors.centerIn: bitsScored
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                color: "black"
                text: bitsScored.text
            }

            Text {
                id: bitsScored
                font.family: chatFont.name
                font.pixelSize: 14
                lineHeight: 1.2
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
                color: "white"
                text: "
    Complete Rows:<br/><br/>
    Total Matches:<br/><br/>
    Total Errors:<br/><br/>
    Best Chain:<br/><br/>
    Best Perfect:<br/><br/>
    Level Reached:"
            }

//            Rectangle {
//                id: scoreLineDS
//                width: scoreLine.width
//                height: scoreLine.height
//                anchors.centerIn: scoreLine
//                anchors.horizontalCenterOffset: 1
//                anchors.verticalCenterOffset: 1
//                color: "black"
//            }

//            Rectangle {
//                id: scoreLine
//                width: parent.width - 24
//                height: 2
//                anchors.centerIn: parent
//                anchors.verticalCenterOffset: 50
//                color: "white"
//            }
        }


    }

    function reveal() {
        finalScreen.visible = true
        //        backFade.start()
        bgIn.start()
    }
}
