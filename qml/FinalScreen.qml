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
            duration: 1800
            easing.type: Easing.OutSine
        }
    }

    Rectangle {
        id: blackStripe
        width: 200
        height: parent.height
        anchors.centerIn: parent
        color: "black"
        clip: true

        Image {
            id: totBG
            width: 160
            height: 240
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: 64
            source: fnlSource
            opacity: 0.2

            Timer {
                running: true
                repeat: true
                interval: 80
                onTriggered: totBG.opacity = (Math.floor(Math.random() * 2) + 25) / 100
            }
        }

        Item {
            id: header
            width: parent.width
            height: parent.height

            Text {
                id: headerTxtDS
                font.family: headerTxt.font.family
                font.pixelSize: headerTxt.font.pixelSize
                anchors.centerIn: headerTxt
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceCol
                text: headerTxt.text
                visible: headerTxt.visible
            }
            Text {
                id: headerTxt
                font.family: gameFont.name
                font.pixelSize: 24
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 24
                color: "white"
                text: "Final Results:"
                visible: false

                NumberAnimation {
                    id: hdrTxtDrop
                    target: headerTxt
                    property: "anchors.topMargin"
                    from: -24
                    to: 24
                    duration: 600
                    onStarted: target.visible = true
                    easing.type: Easing.OutBack
                    onStopped: resultsDrop.start()
                }
            }
        }
    }

    Item {
        id: sideStripes
        width: 200
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: false

        NumberAnimation {
            id: stripeStart
            target: blackStripe
            running: finalScreen.visible
            property: "width"
            from: 0
            to: 200
            duration: 600
            easing.type: Easing.OutSine
            onStopped: {
                sideStripes.visible = true
                sideStripesDown.start()
                hdrTxtDrop.start()
            }
        }

        Rectangle {
            id: stripeLeft
            width: 4
            height: parent.height + 12
            anchors.top: parent.top
            anchors.topMargin: -border.width
            anchors.left: parent.left
            color: "white"
            border.color: gameColors.iFaceLightCol
            border.width: 1

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                    GradientStop { position: 0.5; color: "transparent"}
                }
            }

            Image {
                width: 24
                height: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                source: "../assets/gfx/highlight.png"
            }

            Image {
                width: 24
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                source: "../assets/gfx/shine.png"
                rotation: 35
            }
        }
        Rectangle {
            id: stripeRight
            width: 4
            height: parent.height + 12
            anchors.top: parent.top
            anchors.topMargin: -border.width
            anchors.right: parent.right
            color: "white"
            border.color: gameColors.iFaceLightCol
            border.width: 1

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                    GradientStop { position: 0.5; color: "transparent"}
                }
            }

            Image {
                width: 24
                height: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                source: "../assets/gfx/highlight.png"
            }

            Image {
                width: 24
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                source: "../assets/gfx/shine.png"
                rotation: 35
            }
        }

        ParallelAnimation {
            id: sideStripesDown

            NumberAnimation {
                target: sideStripes
                property: "height"
                from: 0
                to: parent.height + 12
                duration: 800
                easing.type: Easing.InOutSine
            }
            NumberAnimation {
                target: sideStripes
                property: "opacity"
                from: 0
                to: 1
                duration: 800
                easing.type: Easing.InOutSine
            }
        }
    }

    Item {
        id: results
        width: 200
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: false
        clip: true

        property int titleSize: 16
        property int listSize: 12

        property int pixelSpacing: 32
        property int timerSpacing: flashTime

        NumberAnimation {
            id: resultsDrop
            target: results
            property: "height"
            from: 0
            to: parent.height
            duration: 1200
            easing.type: Easing.InCirc
            onStarted: target.visible = true
            onStopped: {
                rowTimer.start()
                rowShine.scoreFlash()
            }
        }

        Text {
            id: scoreTitlesDS
            font.family: scoreTitles.font.family
            font.pixelSize: scoreTitles.font.pixelSize
            anchors.centerIn: scoreTitles
            anchors.horizontalCenterOffset: 2
            anchors.verticalCenterOffset: 2
            horizontalAlignment: scoreTitles.horizontalAlignment
            lineHeightMode: Text.FixedHeight
            lineHeight: scoreTitles.lineHeight
            color: gameColors.iFaceDarkCol
            text: scoreTitles.text
        }

        Text {
            id: scoreTitles
            font.family: gameFont.name
            font.pixelSize: results.titleSize
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 64
            horizontalAlignment: Text.AlignHCenter
            lineHeightMode: Text.FixedHeight
            lineHeight: 46
            color: "white"
            text: "
Complete Rows:<br/>
+ Matched Rows:<br/>
+ Extra Bits:<br/>
+ Best Chain:<br/>
+ Best Perfect:<br/>
+ Level Reached:<br/>
= Total Score:"
        }

        Text {
            id: rowText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: scoreTitles.anchors.topMargin + 22
            text: compRows + " × 2 = " + compRows * 2

            visible: false

            Timer {
                id: rowTimer
                interval: results.timerSpacing
                onTriggered: {
                    matchTimer.start()
                    rowText.visible = true
                    matchShine.scoreFlash()
                }
            }

            ScoreShine {
                id: rowShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: matchText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: rowText.bottom
            anchors.topMargin: results.pixelSpacing
            text: matchRows + " × 4 = " + matchRows * 4

            visible: false

            Timer {
                id: matchTimer
                interval: results.timerSpacing
                onTriggered: {
                    bitTimer.start()
                    matchText.visible = true
                    bitShine.scoreFlash()
                }
            }

            ScoreShine {
                id: matchShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: bitText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: matchText.bottom
            anchors.topMargin: results.pixelSpacing
            text: exBits + " × 1 = " + exBits

            visible: false

            Timer {
                id: bitTimer
                interval: results.timerSpacing
                onTriggered: {
                    chainTimer.start()
                    bitText.visible = true
                    chainShine.scoreFlash()
                }
            }

            ScoreShine {
                id: bitShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: chainText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bitText.bottom
            anchors.topMargin: results.pixelSpacing
            text: bestChain

            visible: false

            Timer {
                id: chainTimer
                interval: results.timerSpacing
                onTriggered: {
                    perfTimer.start()
                    chainText.visible = true
                    perfShine.scoreFlash()
                }
            }

            ScoreShine {
                id: chainShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: perfText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: chainText.bottom
            anchors.topMargin: results.pixelSpacing
            text: bestPerfect

            visible: false

            Timer {
                id: perfTimer
                interval: results.timerSpacing
                onTriggered: {
                    levelTimer.start()
                    perfText.visible = true
                    levelShine.scoreFlash()
                }
            }

            ScoreShine {
                id: perfShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: levelText
            font.family: chatFont.name
            font.pixelSize: results.listSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: perfText.bottom
            anchors.topMargin: results.pixelSpacing
            text: gameLevel + " × 5 = " + gameLevel * 5

            visible: false

            Timer {
                id: levelTimer
                interval: results.timerSpacing
                onTriggered: {
                    totTimer.start()
                    levelText.visible = true
//                    totShine.scoreFlash()
                    flashStart.start()
                }
            }

            ScoreShine {
                id: levelShine
                anchors.top: parent.bottom
            }
        }

        Text {
            id: totText
            font.family: gameFont.name
            font.pixelSize: results.titleSize * 2
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: levelText.bottom
            anchors.topMargin: results.pixelSpacing + 8
            text: gameScore

            visible: false

            Timer {
                id: totTimer
                interval: results.timerSpacing
                onTriggered: {
                    ladderDrop.play()
                    totText.visible = true
                }
            }

            ScoreShine {
                id: totShine
                anchors.top: parent.bottom
            }

            Rectangle {
                id: bitFlash

                signal start()
                onStart: flashStart.start()

                property int duration: 1600

                width: 64
                height: width
                radius: height / 2
                anchors.centerIn: parent
                color: "transparent"
                border.width: width / 2
                border.color: "white"

                visible: false

                Image {
                    id: flashShine
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    source: "../assets/gfx/shine.png"

                    NumberAnimation {
                        target: flashShine
                        property: "rotation"
                        running: bitFlash.visible
                        loops: Animation.Infinite
                        from: 0
                        to: {
                            if (Math.floor(Math.random() * 2) < 1)
                                return -360
                            else return 360
                        }
                        duration: 600
                    }
                }

                SequentialAnimation {
                    id: flashStart

                    onStarted: {
                        bitFlash.visible = true
                    } //Close onStarted.

                    NumberAnimation {
                        target: bitFlash
                        property: "scale"
                        duration: bitFlash.duration / 3
                        from: 0
                        to: 1
                    } //Close NumberAnimation.

                    NumberAnimation {
                        target: bitFlash
                        property: "border.width"
                        duration: bitFlash.duration / 3
                        from: bitFlash.width / 2
                        to: 0
                        easing.type: Easing.OutCubic
                    } //Close NumberAnimation.

                    NumberAnimation {
                        target: bitFlash
                        property: "scale"
                        duration: bitFlash.duration / 3
                        from: 1
                        to: 0
                        easing.amplitude: Easing.InBack
                    } //Close NumberAnimation.

                    onStopped: {
                        bitFlash.border.width = bitFlash.width / 2
                        bitFlash.visible = false
                    } //Close onStarted.

                } //Close SequentialAnimation.

            } //Close Rectangle 'flashIcon'.
        }


    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            results.visible = false
            rowText.visible = false
            matchText.visible = false
            bitText.visible = false
            chainText.visible = false
            perfText.visible = false
            levelText.visible = false
            totText.visible = false
            headerTxt.visible = false
            sideStripes.visible = false
            backFade.start()
            stripeStart.start()
        }
    }

    function reveal() {
        finalScreen.visible = true
    }
}
