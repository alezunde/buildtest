//--**COMPLETE**--\\`

import QtQuick 2.0
import Felgo 3.0

//Entity 'dnaBB' is that main game piece. (Complete)
Item {
    id: dnaBB

    property var rowCont: gameScene.dnaRows[bitRow]

    property bool holding: false
    property bool under: false

    property int bitSize: 32

    property int bitType: 0

    property bool bitFlip
    property bool bitError: false

    property int bitColumn
    property int bitRow

    property int bitOffset
    property double bobOffset
    property int bobTime: Math.floor(Math.random() * 1200) + 2400
    property int flipTime: gameScene.flipTime
    property int flashTime: gameScene.flashTime
    property int sinkTime: gameScene.sinkTime

    SequentialAnimation {
        id: bitBob
        running: bitError
        loops: Animation.Infinite

        onStopped: bobOffset = 0

        NumberAnimation {
            id: bobUp
            target: dnaBB
            property: "bobOffset"
            easing.type: Easing.InOutSine
            from: 2
            to: -2
            duration: bobTime / 2
        }

        NumberAnimation {
            id: bobDown
            target: dnaBB
            property: "bobOffset"
            easing.type: Easing.InOutSine
            from: -2
            to: 2
            duration: bobTime / 2
        }
    }

    //Animation to spin the bit as it is flipped. (Complete)
    NumberAnimation {
        id: bitFlip
        target: bitImage
        property: "rotation"
        duration: flipTime //One tenth of a second. (Complete)
        easing.type: Easing.OutCubic
        from: {
            //Spin the bit in a random direction. (Complete)
            if (Math.floor(Math.random() * 2) < 1)
                return -180
            else return 180
        } //Close from.
        to: 0
        onStarted: {
            dnaBB.bitFlip = !dnaBB.bitFlip
                if (bitError)
                    flash("red")
                else {
                 gameScene.polyPlus(1)
                    flash()
                }
            if (!gameScene.flipSound.playing)
                gameScene.flipSound.play()
        }
        onStopped: rowCheck()
    } //Close NumberAnimation 'bitFlip'. (Complete)

    ParallelAnimation {
        id: bitSink
        property int duration: sinkTime

        NumberAnimation {
            target: bitImage
            property: "scale"
            from: 1
            to: 0.8
            duration: bitSink.duration
        }
        NumberAnimation {
            target: bitImage
            property: "opacity"
            from: 1
            to: 0.6
            duration: bitSink.duration
        }
    }

    BitConn { id: bitConn }

    Rectangle {
        id: bitBox
        width: parent.width - 4
        height: parent.height - 4
        radius: 6
        color: "transparent"
        border.color: "white"
        border.width: 2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: bitOffset
        visible: false

        Rectangle {
            anchors.fill: parent
            radius: 6
            color: "white"
            opacity: 0.8
        }

        NumberAnimation {
            id: boxFade
            target: bitBox
            running: false
            property: "opacity"
            duration: 400
            from: 1
            to: 0
            onStarted: {
                target.opacity = 1
                target.visible = true
            }
            onStopped: target.visible = false
        }
    }

    Image {
        id: bitGlow
        width: dnaBB.width
        height: width
        anchors.centerIn: bitImage
        source: "../assets/gfx/highlight.png"
        visible: !bitError
        Timer {
            running: true
            repeat: true
            interval: 60
            onTriggered: bitGlow.opacity = (Math.floor(Math.random() * 40) + 40) / 100
        }
    }

    Image {
        id: bitImage
        width: bitSize
        height: width

        anchors.centerIn: parent
        anchors.verticalCenterOffset: bitOffset + bobOffset

        source: {
            if (parent.bitFlip)
                return "../assets/gfx/dna_dr2.png"
            else return "../assets/gfx/dna_dr.png"
        }

        //The image that appears if there is an error. (Complete)
        Image {
            id: bitErrorSign
            width: dnaBB.width
            height: width
            anchors.centerIn: parent
            source: "../assets/gfx/error.png"
            visible: bitError && !bitHighlight.visible
        } //Close Image 'bitErrorSign'. (Complete)

        //The image that appears if there is an error. (Complete)
        Image {
            id: bitErrorHL
            width: dnaBB.width
            height: width
            anchors.centerIn: parent
            source: "../assets/gfx/error2.png"
            visible: bitHighlight.visible && bitError
        } //Close Image 'bitErrorSign'. (Complete)

        //The image that appears if there is an error. (Complete)
        Image {
            id: bitHighlight
            anchors.fill: parent
            source: "../assets/gfx/highlight.png"
            visible: false
        } //Close Image 'bitErrorSign'. (Complete)

    }

    Rectangle {
        id: holdBar
        width: parent.width
        height: 12
        anchors.horizontalCenter: parent.horizontalCenter
        radius: height / 2
        color: "white"
        border.color: "black"
        border.width: 2
        anchors.bottom: parent.top
        visible: false

        Timer {
            id: holdTimer
            interval: 300
            running: false
            onTriggered: if (bitMouseArea.containsPress) holding = true
        }

        ParallelAnimation {
            id: holdDown
            running: holding
            property int duration: 500

            onStarted: {
                parent.z = 150
                holdBar.width = dnaBB.width
                holdBar.opacity = 0
                holdBar.visible = true
            }
            NumberAnimation {
                target: holdBar
                property: "opacity"
                from: 0
                to: 1
                duration: holdDown.duration
            }
            NumberAnimation {
                target: holdBar
                property: "width"
                from: holdBar.width
                to: 0
                duration: holdDown.duration
            }
            onStopped: {
                parent.z = 100
                holdBar.width = dnaBB.width
                holdBar.visible = false
                holding = false
            }
        }
    }

    Rectangle {
        id: bitFlash

        signal start()
        onStart: flashStart.start()

        property int duration: flashTime

        width: 36
        height: width
        radius: height / 2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: bitOffset
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

    MouseArea {
        id: bitMouseArea
        hoverEnabled: true
        anchors.fill: bitImage
        onEntered:
            if (bitError) {
                bitHighlight.visible = true
                boxFade.start()
            }
        onExited: bitHighlight.visible = false
        onPressed: if (bitError) holdTimer.start()
        onReleased: holding = false
        onPressAndHold: if (bitError) flip()
    }

    function flip() {
        bitFlip.start()
    }

    function sink() {
        bitConn.fade()
        bitSink.start()
    }

    function flash(col) {
        if (col !== undefined)
            bitFlash.border.color = col
        else bitFlash.border.color = "white"
        bitFlash.start()
    }

} //Close EntityBase 'dnaBB'. (Complete)
