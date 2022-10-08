//--**COMPLETE**--\\`

import QtQuick 2.0
import Felgo 3.0

Item {
    id: dnaBit

    enabled: parent.elementsEnabled

    signal clicked()

    property int bitId: bitRow * 4 + bitColumn

    property var rowCont: parent

    property bool holding: false

    property int bitSize: 32

    property int bitType: Math.floor(Math.random() * 4) + 1

    property bool bitFlip
    property bool bitError

    property int errorTurns: 0

    property int bitColumn
    property int bitRow

    property int bitOffset
    property double bobOffset
    property double jigOffset

    property int bobTime: Math.floor(Math.random() * 1200) + 2400
    property int jigTime: Math.floor(Math.random() * 160) + 160
    property int flipTime: gameScene.flipTime
    property int swapTime: gameScene.swapTime
    property int sinkTime: gameScene.sinkTime
    property int flashTime: gameScene.flashTime

    SequentialAnimation {
        id: bitBob
        running: bitError && bitType < 5
        loops: Animation.Infinite

        onStopped: bobOffset = 0

        NumberAnimation {
            id: bobUp
            target: dnaBit
            property: "bobOffset"
            easing.type: Easing.InOutSine
            from: 2
            to: -2
            duration: bobTime / 2
        }

        NumberAnimation {
            id: bobDown
            target: dnaBit
            property: "bobOffset"
            easing.type: Easing.InOutSine
            from: -2
            to: 2
            duration: bobTime / 2
        }
    }

    SequentialAnimation {
        id: bitJig
        running: errorTurns > 2 && bitType < 5 && !rowCont.sunk
        loops: Animation.Infinite

        onStopped: jigOffset = 0

        NumberAnimation {
            id: jigLeft
            target: dnaBit
            property: "jigOffset"
            easing.type: Easing.InOutSine
            from: 1
            to: -1
            duration: jigTime / 2
        }

        NumberAnimation {
            id: jigRight
            target: dnaBit
            property: "jigOffset"
            easing.type: Easing.InOutSine
            from: -1
            to: 1
            duration: jigTime / 2
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
            dnaBit.bitFlip = !dnaBit.bitFlip
            if (bitType < 5)
                if (bitError)
                    flash("red")
                else {
                    errorTurns = 0
                    flash()
                }
            if (!gameScene.flipSound.playing)
                gameScene.flipSound.play()
        }
        onStopped: rowCont.rowCheck()
    } //Close NumberAnimation 'bitFlip'. (Complete)

    Item {
        id: bitSwap

        signal start()

        onStart: change1.start()

        property int newType
        property bool newFlip
        property int duration: swapTime

        NumberAnimation {
            id: change1
            target: bitImage
            property: "scale"
            from: 1
            to: 0
            duration: bitSwap.duration / 2
            easing.type: Easing.InCubic
            onStopped: {
                dnaBit.bitType = bitSwap.newType
                dnaBit.bitFlip = bitSwap.newFlip
                dnaBit.errorTurns = 0
                change2.start()
                if (bitError)
                    flash("red")
                else flash()
            }
        }

        NumberAnimation {
            id: change2
            target: bitImage
            property: "scale"
            from: 0
            to: 1
            duration: bitSwap.duration / 2
            easing.type: Easing.OutElastic
            onStopped: rowCheck()
        }
    }

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
            to: 0.8
            duration: bitSink.duration
        }
    }

    //Animation to cause void bits to spin. (Complete)
    NumberAnimation {
        id: voidSpin
        target: bitImage
        property: "rotation"
        //Randomly reset the speed of the rotation. (Complete)
        duration: Math.random() * 4000 + 8000 //Twelve seconds. (Complete)
        from: 0
        to: {
            //Spin the bit in a random direction. (Complete)
            if (Math.floor(Math.random() * 2) < 1)
                return -360 //Counter-clockwise. (Complete)
            else return 360
        } //Close to. (Complete)
        onStopped: {
            target.rotation = 0
            duration = Math.random() * 4000 + 8000 //Twelve seconds. (Complete)
        }
        loops: Animation.Infinite
        running: bitType > 4
    } //Close NumberAnimation 'bitShrink'. (Complete)

    BitConn { id: bitConn }

    Image {
        id: bitGlow
        width: dnaBit.width
        height: width
        anchors.centerIn: bitImage
        source: "../assets/gfx/highlight.png"
        visible: rowMatch
        Timer {
            running: true
            repeat: true
            interval: 60
            onTriggered: bitGlow.opacity = (Math.floor(Math.random() * 40) + 40) / 100
        }
    }

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
        id: bitImage
        width: bitSize
        height: width
        anchors.centerIn: parent
        anchors.verticalCenterOffset: bitOffset + bobOffset
        anchors.horizontalCenterOffset: jigOffset

        source: {
            if (bitType === 1)
                if (parent.bitFlip)
                    return "../assets/gfx/dna_a2.png"
                else return "../assets/gfx/dna_a.png"
            if (bitType === 2)
                if (parent.bitFlip)
                    return "../assets/gfx/dna_c2.png"
                else return "../assets/gfx/dna_c.png"
            if (bitType === 3)
                if (parent.bitFlip)
                    return "../assets/gfx/dna_g2.png"
                else return "../assets/gfx/dna_g.png"
            if (bitType === 4)
                if (parent.bitFlip)
                    return "../assets/gfx/dna_t2.png"
                else return "../assets/gfx/dna_t.png"
            if (bitType > 4)
                return "../assets/gfx/voidbit.png"
            return ""
        }

        //The image that appears if there is an error. (Complete)
        Image {
            id: bitErrorSign
            width: dnaBit.width
            height: width
            anchors.centerIn: parent
            source: "../assets/gfx/error.png"
            visible: bitError && !bitHighlight.visible && bitType < 5 && !bitJig.running
        } //Close Image 'bitErrorSign'. (Complete)

        //The image that appears if there is an error. (Complete)
        Image {
            id: bitErrorHL
            width: dnaBit.width
            height: width
            anchors.centerIn: parent
            source: "../assets/gfx/error2.png"
            visible: bitHighlight.visible && bitError && bitType < 5 || bitJig.running
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
                holdBar.width = dnaBit.width
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
                holdBar.width = dnaBit.width
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
        anchors.fill: parent
        onEntered: {
            bitHighlight.visible = true
            boxFade.start()
        }
        onExited: bitHighlight.visible = false
        onPressed: {
            if (gameScene.gamePolys > 0)
                holdTimer.start()
        }
        onReleased: holding = false
        onPressAndHold: {
            if (gameScene.gamePolys > 0) {
                gameScene.polyPlus(-1)
                flip()
            } else gameScene.polyWarn()
        }
        onClicked: select()
    }

    function select() {
        var swap1 = gameScene.swap1
        var swap2 = gameScene.swap2

        if (!swap1.used && swap2.bitId !== bitId) {
            swap1.used = true
            swap1.bitId = bitId
            swap1.floatBit = false
            swap1.rowCont = rowCont
            swap1.bitType = bitType
            if (bitType > 4)
                swap1.voidBit = true
            else swap1.voidBit = false
            swap1.bitFlip = dnaBit.bitFlip
            swap1.bitColumn = bitColumn
            swap1.bitOffset = bitOffset
            swap1.x = rowCont.x + bitColumn * 40
            swap1.y = rowCont.y
        } else if (!swap2.used && swap1.bitId !== bitId) {
            swap2.used = true
            swap2.bitId = bitId
            swap2.floatBit = false
            swap2.rowCont = rowCont
            swap2.bitType = bitType
            if (bitType > 4)
                swap2.voidBit = true
            else swap2.voidBit = false
            swap2.bitFlip = dnaBit.bitFlip
            swap2.bitColumn = bitColumn
            swap2.bitOffset = bitOffset
            swap2.x = rowCont.x + bitColumn * 40
            swap2.y = rowCont.y
        } else {
            swap2.used = false
            swap2.voidBit = false
            swap2.floatBit = false
            swap1.bitId = bitId
            swap1.floatBit = false
            swap1.rowCont = rowCont
            swap1.bitType = bitType
            if (bitType > 4)
                swap1.voidBit = true
            else swap1.voidBit = false
            swap1.bitFlip = dnaBit.bitFlip
            swap1.bitColumn = bitColumn
            swap1.bitOffset = bitOffset
            swap1.x = rowCont.x + bitColumn * 40
            swap1.y = rowCont.y
        }
        if (swap1.used && swap2.used) {
            if (swap1.voidBit || swap2.voidBit) {
                if (swap1.voidBit)
                    if (!swap2.voidBit)
                        gameScene.swapMode = true
                if (swap2.voidBit)
                    if (!swap1.voidBit)
                        gameScene.swapMode = true
            } else
                if (swap1.floatBit || swap2.floatBit) {
                    if (swap1.floatBit)
                        if (!swap2.floatBit)
                            gameScene.swapMode = true
                    if (swap2.floatBit)
                        if (!swap1.floatBit)
                            gameScene.swapMode = true
                } else gameScene.swapMode = true
        } else gameScene.swapMode = false
    }

    function flip() {
        bitFlip.start()
    }

    function errCheck() {
        if (bitType < 5)
            if (bitError)
                if (errorTurns < 3)
                    errorTurns += 1
                else {
                    errorTurns = 0
                    mutate()
                }
    }

    function mutate() {

        if (Math.floor(Math.random() * gameScene.mutVoids) > 0) {

            var typeChance = Math.floor(Math.random() * 100)

            var bitCheck = false

            if (bitType === 1 || bitType === 4) {
                if (bitType === 1) {
                    if (typeChance <= 70) {
                        bitType = 4
                    } else {
                        if (Math.floor(Math.random() * 2) < 1)
                            bitType = 2
                        else bitType = 3
                    }
                    bitCheck = true
                }
                if (bitType === 4 && bitCheck === false) {
                    if (typeChance <= 70) {
                        bitType = 1
                    } else {
                        if (Math.floor(Math.random() * 2) < 1)
                            bitType = 2
                        else bitType = 3
                    }
                }
            }

            bitCheck = false

            if (bitType === 2 || bitType === 3) {
                if (bitType === 2) {
                    if (typeChance <= 70) {
                        bitType = 3
                    } else {
                        if (Math.floor(Math.random() * 2) < 1)
                            bitType = 1
                        else bitType = 4
                    }
                    bitCheck = true
                }
                if (bitType === 3 && bitCheck === false) {
                    if (typeChance <= 70) {
                        bitType = 2
                    } else {
                        if (Math.floor(Math.random() * 2) < 1)
                            bitType = 1
                        else bitType = 4
                    }
                }
            }

            if (Math.floor(Math.random() * 2) < 1)
                flip()

            flash()

        } else {
            bitType = 5
            flash("red")
            gameScene.addFloat(bitRow - (gameScene.turnCount - gameScene.turnBuffer))
        }
    }

    function bitChange(newType,newFlip) {
        bitSwap.newType = newType
        if (newFlip !== undefined)
            bitSwap.newFlip = newFlip
        else bitSwap.newFlip = bitFlip
        bitSwap.start()
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

} //Close EntityBase 'dnaBit'. (Complete)
