//--**COMPLETE**--\\

import QtQuick 2.0
import Felgo 3.0

//The game interface, showing the header, footer, and play area background elements.
//Here, values are relative to the logical scene size of 320 x 480px with an origin of 0, 0.
//(Complete)
Item {
    id: interFace

    anchors.fill: parent

    enabled: elementsEnabled

    Rectangle {
        id: ladderTopFade
        width: 160
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black"}
            GradientStop { position: 1.0; color: "transparent"}
        }
    }

    //The top header bar and inside components. (Complete)
    Item {
        id: iFaceHeader

        width: parent.width
        height: 48
        anchors.top: parent.top
        anchors.topMargin: 12

        visible: !menuUp

        //The drop shadow for the header bar. (Complete)
        Rectangle {
            id: iFaceDS
            anchors.fill: parent
            color: gameColors.iFaceDSCol
        } //Close Rectangle 'iFaceDS'. (Complete)

        //A rectangle that draws the header elements. (Complete)
        Rectangle {
            id: iFaceBlock
            width: parent.width
            height: parent.height - 3
            anchors.top: parent.top

            color: gameColors.iFaceCol

            Image {
                anchors.fill: parent
                source: hdrSource
                opacity: 0.8
            } //Close Image.

            //Top header stripe drop shadow. (Complete)
            Rectangle {
                id: iFaceHdrTopDS
                width: parent.width
                height: 6
                anchors.top: parent.top
                color: gameColors.iFaceDSCol

                //Top header stripe. (Complete)
                Rectangle {
                    id: iFaceHdrTop
                    width: parent.width
                    height: parent.height / 2
                    anchors.top: parent.top

                    color: gameColors.iFaceLightCol

                } //Close Rectangle 'iFaceHdrTop'. (Complete)

            } //Close Rectangle 'iFaceHdrTopDS'. (Complete)

            //Bottom header stripe. (Complete)
            Rectangle {
                id: iFaceHdrBot
                width: parent.width //'iFaceBlock'
                height: 3
                anchors.bottom: parent.bottom

                color: gameColors.iFaceLightCol

            } //Close Rectangle 'iFaceHdrBot'. (Complete)

        } //Close Rectangle 'iFaceBlock'. (Complete)

    } //Close Item 'iFaceHeader'. (Incomplete)

    LadderButton {}

    Item {
        id: bgPool
        width: parent.width
        height: 113
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        property int ripInt: Math.floor(Math.random() * 2400) + 2400

        Rectangle {
            id: poolRect
            anchors.fill: parent
            color: gameColors.iFaceBGCol
            opacity: 0.4
        }

        Image {
            id: ripple1
            width: 240
            height: 8
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/gfx/highlight.png"

            ParallelAnimation {
                running: true
                loops: Animation.Infinite

                NumberAnimation {
                    target: ripple1
                    property: "anchors.bottomMargin"
                    duration: bgPool.ripInt
                    from: 0
                    to: -20
                }

                NumberAnimation {
                    target: ripple1
                    property: "opacity"
                    duration: bgPool.ripInt
                    from: 1
                    to: 0
                }

            }
        }

        Image {
            id: ripple2
            width: 180
            height: 6
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/gfx/highlight.png"

            Timer {
                running: true
                interval: Math.floor(Math.random() * 400)
                onTriggered: rip2anim.start()
            }

            SequentialAnimation {
                id: rip2anim
                running: false
                loops: Animation.Infinite

                ParallelAnimation {

                    NumberAnimation {
                        target: ripple2
                        property: "anchors.bottomMargin"
                        duration: bgPool.ripInt / 2
                        from: -10
                        to: -15
                    }

                    NumberAnimation {
                        target: ripple2
                        property: "opacity"
                        duration: bgPool.ripInt / 2
                        from: 0
                        to: 0.8
                    }
                }

                ParallelAnimation {

                    NumberAnimation {
                        target: ripple2
                        property: "anchors.bottomMargin"
                        duration: bgPool.ripInt / 2
                        from: -15
                        to: -25
                    }

                    NumberAnimation {
                        target: ripple2
                        property: "opacity"
                        duration: bgPool.ripInt / 2
                        from: 0.8
                        to: 0
                    }

                }

            }
        }

        Image {
            id: ripple3
            width: 120
            height: 8
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/gfx/highlight.png"

            Timer {
                running: true
                interval: Math.floor(Math.random() * 1200)
                onTriggered: rip3anim.start()
            }

            SequentialAnimation {
                id: rip3anim
                running: true
                loops: Animation.Infinite

                ParallelAnimation {

                    NumberAnimation {
                        target: ripple3
                        property: "anchors.bottomMargin"
                        duration: bgPool.ripInt / 2
                        from: -20
                        to: -25
                    }

                    NumberAnimation {
                        target: ripple3
                        property: "opacity"
                        duration: bgPool.ripInt / 2
                        from: 0
                        to: 0.6
                    }

                }

                ParallelAnimation {

                    NumberAnimation {
                        target: ripple3
                        property: "anchors.bottomMargin"
                        duration: bgPool.ripInt / 2
                        from: -25
                        to: -35
                    }

                    NumberAnimation {
                        target: ripple3
                        property: "opacity"
                        duration: bgPool.ripInt / 2
                        from: 0.6
                        to: 0
                    }

                }

            }
        }

    }

    Rectangle {
        id: goalLine
        width: 160
        height: 2
        radius: 1
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 112

        Image {
            id: goalFlicker
            anchors.centerIn: parent
            width: parent.width * 1.5
            height: 12
            source: "../assets/gfx/highlight.png"

            NumberAnimation {
                running: true
                loops: Animation.Infinite
                duration: 200
                target: goalFlicker
                property: "height"
                from: 12
                to: 6
            }
        }

        Item {
            id: goalFlashes
            anchors.centerIn: parent

            width: 160
            height: 80

            property int duration: dropTime
            property int stagger: duration / 8

            Timer {
                id: goalTimer1
                interval: goalFlashes.stagger
                onTriggered: {
                    flash2.visible = true
                    goalTimer2.start()
                }
            }
            Timer {
                id: goalTimer2
                interval: goalFlashes.stagger
                onTriggered: {
                    flash3.visible = true
                    goalTimer3.start()
                }
            }
            Timer {
                id: goalTimer3
                interval: goalFlashes.stagger
                onTriggered: flash4.visible = true
            }

            Item {
                width: 40
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: flash1
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"

                    visible: false

                    ParallelAnimation {
                        running: flash1.visible
                        onStopped: flash1.visible = false

                        SequentialAnimation {
                            NumberAnimation {
                                target: flash1
                                property: "height"
                                from: 0
                                to: goalFlashes.height
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash1
                                property: "height"
                                from: goalFlashes.height
                                to: 0
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                        SequentialAnimation {
                            NumberAnimation {
                                target: flash1
                                property: "width"
                                from: 80
                                to: 10
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash1
                                property: "width"
                                from: 10
                                to: 80
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                    }

                    Image {
                        id: shine1
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: shine1
                            property: "rotation"
                            running: true
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    } //Close Image 'shine1'.
                } //Close Image 'flash1'.
            } //Close Item.

            Item {
                width: 40
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: flash2
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"

                    visible: false

                    ParallelAnimation {
                        running: flash2.visible
                        onStopped: flash2.visible = false

                        SequentialAnimation {
                            NumberAnimation {
                                target: flash2
                                property: "height"
                                from: 0
                                to: goalFlashes.height
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash2
                                property: "height"
                                from: goalFlashes.height
                                to: 0
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                        SequentialAnimation {
                            NumberAnimation {
                                target: flash2
                                property: "width"
                                from: 80
                                to: 10
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash2
                                property: "width"
                                from: 10
                                to: 80
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                    }

                    Image {
                        id: shine2
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: shine2
                            property: "rotation"
                            running: true
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    } //Close Image 'shine2'.
                } //Close Image 'flash2'.
            } //Close Item.

            Item {
                width: 40
                anchors.left: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: flash3
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"

                    visible: false

                    ParallelAnimation {
                        running: flash3.visible
                        onStopped: flash3.visible = false

                        SequentialAnimation {
                            NumberAnimation {
                                target: flash3
                                property: "height"
                                from: 0
                                to: goalFlashes.height
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash3
                                property: "height"
                                from: goalFlashes.height
                                to: 0
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                        SequentialAnimation {
                            NumberAnimation {
                                target: flash3
                                property: "width"
                                from: 80
                                to: 10
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash3
                                property: "width"
                                from: 10
                                to: 80
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                    }

                    Image {
                        id: shine3
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: shine3
                            property: "rotation"
                            running: true
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    } //Close Image 'shine3'.
                } //Close Image 'flash3'.
            } //Close Item.

            Item {
                width: 40
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: flash4
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"

                    visible: false

                    ParallelAnimation {
                        running: flash4.visible
                        onStopped: flash4.visible = false

                        SequentialAnimation {
                            NumberAnimation {
                                target: flash4
                                property: "height"
                                from: 0
                                to: goalFlashes.height
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash4
                                property: "height"
                                from: goalFlashes.height
                                to: 0
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                        SequentialAnimation {
                            NumberAnimation {
                                target: flash4
                                property: "width"
                                from: 80
                                to: 10
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.InCirc
                            }
                            NumberAnimation {
                                target: flash4
                                property: "width"
                                from: 10
                                to: 80
                                duration: goalFlashes.duration / 2
                                easing.type: Easing.OutCirc
                            }
                        }
                    }

                    Image {
                        id: shine4
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: shine4
                            property: "rotation"
                            running: true
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    } //Close Image 'shine4'.
                } //Close Image 'flash4'.
            } //Close Item.

        } //Close Item 'goalFlashes'.

    } //Close Rectangle 'goalLine'.

    Item {
        id: foreBubbles
        width: parent.width
        height: 113
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        BGBubble {}
        BGBubble {}
        BGBubble {}
        BGBubble {}
    }

    Rectangle {
        id: bottomGrad
        width: parent.width
        height: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -1
        anchors.horizontalCenter: parent.horizontalCenter
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent"}
            GradientStop { position: 1.0; color: "black"}
        }
    }

    Item {
        id: bottomArrows
        anchors.fill: parent

        property int bottomMargin: 60

        Rectangle {
            id: leadGrad
            width: leadArrow.width
            height: leadArrow.height * 2
            anchors.bottom: leadArrow.verticalCenter
            anchors.horizontalCenter: leadArrow.horizontalCenter
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent"}
                GradientStop { position: 1.0; color: gameColors.iFaceCol}
            }
            opacity: 0.6
        }

        Rectangle {
            id: leadArrow
            width: 60
            height: 20
            radius: 4
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: bottomArrows.bottomMargin
            color: gameColors.iFaceCol
            //border.color: gameColors.iFaceDSCol
            //border.width: 2

            opacity: 0.8

            Image {
                anchors.fill: parent
                source: "../assets/gfx/tri.png"
                scale: 0.6
                opacity: 0.8
                rotation: 180
            } //Close Image.

        } //Close Rectangle

        Rectangle {
            id: lagGrad
            width: lagArrow.width
            height: lagArrow.height * 2
            anchors.bottom: lagArrow.verticalCenter
            anchors.horizontalCenter: lagArrow.horizontalCenter
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent"}
                GradientStop { position: 1.0; color: gameColors.iFaceDarkCol}
            }
            opacity: 0.6
        }

        Rectangle {
            id: lagArrow
            width: 60
            height: 20
            radius: 4
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: bottomArrows.bottomMargin
            color: gameColors.iFaceDarkCol

            opacity: 0.8

            Image {
                anchors.fill: parent
                source: "../assets/gfx/tri.png"
                scale: 0.6
                opacity: 0.6
            } //Close Image.

        } //Close Rectangle.

    }

    ChainWindow {
        id: chainWindow
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
    }

    Rectangle {
        id: themeSwitch
        width: 16
        height: width
        radius: height / 2
        color: gameColors.iFaceDSCol
        border.color: gameColors.iFaceCol
        border.width: 3
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                themeSwitch.color = gameColors.iFaceBrightCol
                themeSwitch.border.color = gameColors.iFaceDarkCol
            }
            onExited: {
                themeSwitch.color = gameColors.iFaceDSCol
                themeSwitch.border.color = gameColors.iFaceCol
            }
            onClicked: {
                bitClick.play()
                theme += 1
                if (theme > 4)
                    theme = 0
                gameColors.reColor(theme)
            }
        }
    }

    Item {
        id: turnCounter
        width: 80
        height: 36
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60

        Rectangle {
            width: parent.height
            height: parent.width
            anchors.centerIn: parent
            rotation: -90
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
        }

        Rectangle {
            width: parent.height - 12
            height: parent.width
            anchors.centerIn: parent
            rotation: -90
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceDarkCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
        }

        Text {
            id: turnTextDS
            anchors.centerIn: turnText
            anchors.horizontalCenterOffset: 2
            anchors.verticalCenterOffset: 2
            font.family: turnText.font.family
            font.pixelSize: turnText.font.pixelSize
            color: "black"
            text: turnText.text
        }

        Text {
            id: turnText
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            font.family: gameFont.name
            font.pixelSize: 18
            color: "white"
            text: {
                if (endLess)
                    return "Rows: ∞"
                else return "Rows: " + (stageLength - turnCount)
            }
        }
    }

    Item {
        id: foreTwinkles
        width: parent.width
        height: 113
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        BGTwinkle {}
        BGTwinkle {}
    }

    Item {
        id: breakWarn
        anchors.fill: parent

        visible: breakTurns > 0 && !gameOver

        Item {
            id: fourCorners
            anchors.fill: parent

            Rectangle {
                width: 280
                height: 180
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -parent.width / 2
                anchors.verticalCenterOffset:  -parent.height / 2
                gradient: Gradient {
                    GradientStop { position: 0.5; color: "red"}
                    GradientStop { position: 1.0; color: "transparent"}
                }
                rotation: -55
            }

            Rectangle {
                width: 280
                height: 180
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: parent.width / 2
                anchors.verticalCenterOffset:  -parent.height / 2
                gradient: Gradient {
                    GradientStop { position: 0.5; color: "red"}
                    GradientStop { position: 1.0; color: "transparent"}
                }
                rotation: 55
            }

            Rectangle {
                width: 280
                height: 180
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -parent.width / 2
                anchors.verticalCenterOffset:  parent.height / 2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent"}
                    GradientStop { position: 0.5; color: "red"}
                }
                rotation: 55
            }

            Rectangle {
                width: 280
                height: 180
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: parent.width / 2
                anchors.verticalCenterOffset:  parent.height / 2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent"}
                    GradientStop { position: 0.5; color: "red"}
                }
                rotation: -55
            }

            SequentialAnimation {
                running: breakWarn.visible
                loops: Animation.Infinite

                NumberAnimation {
                    target: fourCorners
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 1200
                }

                NumberAnimation {
                    target: fourCorners
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 1200
                }
            }
        }

        Item {
            id: fourEdges
            anchors.fill: parent

            Item {
                id: topBottom
                anchors.fill: parent

                Rectangle {
                    width: parent.width
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "red"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent"}
                        GradientStop { position: 1.0; color: "red"}
                    }
                }
            }

            Item {
                id: leftRight
                width: parent.height
                height: parent.width
                anchors.centerIn: parent

                rotation: 90

                Rectangle {
                    width: parent.width
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "red"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent"}
                        GradientStop { position: 1.0; color: "red"}
                    }
                }
            }

            SequentialAnimation {
                running: breakWarn.visible
                loops: Animation.Infinite

                NumberAnimation {
                    target: fourEdges
                    property: "opacity"
                    from: 0.4
                    to: 1
                    duration: 1200
                }

                NumberAnimation {
                    target: fourEdges
                    property: "opacity"
                    from: 1
                    to: 0.4
                    duration: 1200
                }
            }
        }

        Item {
            id: breakWarnBanner
            width: parent.width
            height: 80
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 24

            Rectangle {
                id: bannerEdges
                width: parent.height
                height: parent.width
                anchors.centerIn: parent
                rotation: 90
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "red"}
                    GradientStop { position: 0.5; color: "transparent"}
                    GradientStop { position: 1.0; color: "red"}
                }

                SequentialAnimation {
                    running: breakWarn.visible
                    loops: Animation.Infinite

                    NumberAnimation {
                        target: bannerEdges
                        property: "opacity"
                        from: 0.6
                        to: 1
                        duration: 1200
                    }

                    NumberAnimation {
                        target: bannerEdges
                        property: "opacity"
                        from: 1
                        to: 0.6
                        duration: 1200
                    }
                }
            }

            Rectangle {
                id: warnBoxDS
                width: warnBox.width
                height: warnBox.height
                radius: warnBox.radius
                anchors.centerIn: warnBox
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                color: "black"
            }

            Rectangle {
                id: warnBox
                width: extraText.implicitWidth + 20
                height: parent.height - 20
                radius: 6
                anchors.centerIn: parent
                color: "white"

                Rectangle {
                    width: parent.width
                    height: parent.height - 20
                    anchors.centerIn: parent
                    color: "red"
                    clip: true

                    Rectangle {
                        width: parent.width
                        height: 60
                        anchors.centerIn: parent
                        color: "black"
                        rotation: -45
                    }
                }
            }

            Text {
                id: breakWarnTxtDS
                font.family: breakWarnTxt.font.family
                font.pixelSize: breakWarnTxt.font.pixelSize
                color: "black"
                anchors.centerIn: breakWarnTxt
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                text: breakWarnTxt.text
            }

            Text {
                id: breakWarnTxt
                font.family: gameFont.name
                font.pixelSize: 22
                color: "white"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -8
                text: "Chain broken!"
            }

            Text {
                id: extraTextDS
                font.family: extraText.font.family
                font.pixelSize: extraText.font.pixelSize
                color: "black"
                anchors.centerIn: extraText
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                text: extraText.text
            }

            Text {
                id: extraText
                font.family: gameFont.name
                font.pixelSize: 16
                color: "white"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 8
                text: {
                    if (breakTurns > 1)
                        return "Don't break it again for " + breakTurns + " turns!"
                    else return "Don't break it again for " + breakTurns + " turn!"
                }
            }
        }

    }

    Item {
        id: statBoxes
        anchors.fill: iFaceHeader

        ScoreBox {
            id: scoreBox
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        } //Close Item 'scoreBox'.

        PolyBar {
            id: polyBar
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 9
        }

        LVLBox {
            id: lvlBox
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: -12
            anchors.verticalCenter: parent.verticalCenter
        }

        DMGBox {
            id: dmgBox
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 28
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
        }

    }

    Item {
        id: toolTips

        width: parent.width
        height: 48
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 12

        Rectangle {
            id: polyTipHL
            width: polyTipMouse.width + 4
            height: polyTipMouse.height + 4
            anchors.centerIn: polyTipMouse
            radius: height / 2
            color: gameColors.iFaceBrightCol
            opacity: 0.6
            visible: polyTip.visible
        }

        Item {
            id: polyTip
            width: polyTipText.implicitWidth + 12
            height: polyTipText.implicitHeight + 18
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16
            anchors.topMargin: 30
            visible: false

            Rectangle {
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceBGCol
                opacity: 0.8
            }

            Rectangle {
                anchors.fill: parent
                radius: 6
                color: "transparent"
                border.color: "white"
                border.width: 2
            }

            Text {
                id: polyTipTextDS
                font.family: polyTipText.font.family
                font.pixelSize: polyTipText.font.pixelSize
                color: "black"
                anchors.centerIn: polyTipText
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                text: polyTipText.text
                visible: polyTipText.visible
            }

            Text {
                id: polyTipText
                font.family: chatFont.name
                font.pixelSize: 12
                color: "white"
                anchors.centerIn: parent
                text: "
Polys are used to:<br/>
- Remove Errors from Colored Bits<br/>
- Move Colored Bits.<br/>
<br/>
Gain Polys by:<br/>
- Removing Errors from Black and White Bits.<br/>
- Scoring Colored Bits without Errors."
            }

            ParallelAnimation {
                id: boxIn
                running: false
                property int duration: 400

                onStarted: {
                    polyTip.visible = true
                    polyTipText.visible = false
                }
                onStopped: polyTipText.visible = true

                NumberAnimation {
                    target: polyTip
                    property: "width"
                    from: 0
                    to: target.width
                    duration: boxIn.duration
                }
                NumberAnimation {
                    target: polyTip
                    property: "height"
                    from: 0
                    to: target.height
                    duration: boxIn.duration
                }
            }
        }

        MouseArea {
            id: polyTipMouse
            width: polyBar.width
            height: polyBar.height
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 9
            hoverEnabled: true
//            enabled: elementsEnabled
            onEntered: {
                boxIn.start()
            }
            onExited: polyTip.visible = false
        }

    }


    function polyWarn() {
        polyBar.polyWarn()
    }

    function polyPlus(num) {
        polyBar.polyPlus(num)
    } //Close function.

    function goalFlash() {
        flash1.visible = true
        goalTimer1.start()
    }

} //Close Item 'InterFace'. (Incomplete)
