import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: floatBit

    entityType: "floatBit"

    width: 40
    height: 40

    z: 100

    enabled: {
        if (!parent.elementsEnabled)
            return false
        else return y > 60
    }
    visible: y >= 0
    property bool holding: false
    property int floatIndex



    property bool sunk: false
    onSunkChanged: bitSink.start()

    property int bitId

    property int bitSize: 32

    property int bitType: Math.floor(Math.random() * 4) + 1
    property bool bitFlip: Math.floor(Math.random() * 2)

    property int row
    property int col

    property double bobOffset
    property int bobTime: Math.floor(Math.random() * 1200) + 2400
    property int dropTime: parent.dropTime
    property int swapTime: parent.swapTime
    property int flashTime: parent.flashTime / 2
    property int sinkTime: parent.sinkTime
    property int flipTime: gameScene.flipTime

    SequentialAnimation {
        id: bitBob
        running: true
        loops: Animation.Infinite

        onStopped: bobOffset = 0

        NumberAnimation {
            id: bobUp
            target: floatBit
            property: "bobOffset"
            easing.type: Easing.InOutSine
            from: 2
            to: -2
            duration: bobTime / 2
        }

        NumberAnimation {
            id: bobDown
            target: floatBit
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
            floatBit.bitFlip = !floatBit.bitFlip
            if (!parent.flipSound.playing)
                parent.flipSound.play()
        }
        onStopped: flash()
    } //Close NumberAnimation 'bitFlip'. (Complete)

    NumberAnimation {
        id: floatDrop
        target: floatBit
        property: "y"
        to: target.y + parent.bitSize
        duration: dropTime
        easing.type: Easing.InBack
        onStarted: {
            if (row < gameScene.turnBuffer + 1 && !sunk)
                sunk = true
            enabled = false
        }
        onStopped: {
            if (target.y > 60 && !sunk)
                enabled = true
            if (row < 0)
                target.visible = false
        }
    }

    NumberAnimation {
        id: bitVanish
        target: bitImage
        property: "scale"
        from: 1
        to: 0
        duration: bitSwap.duration / 2
        easing.type: Easing.InCubic
        onStopped: visible = false
    }

    NumberAnimation {
        id: bitPop
        target: bitImage
        property: "scale"
        from: 0
        to: 1
        duration: bitSwap.duration
        easing.type: Easing.OutCubic
    }

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
                floatBit.bitType = bitSwap.newType
                floatBit.bitFlip = bitSwap.newFlip
                change2.start()
                flash()
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

    Rectangle {
        id: bitBox
        width: parent.width - 4
        height: parent.height - 4
        radius: 6
        color: "transparent"
        border.color: "white"
        border.width: 2
        anchors.centerIn: parent
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
        width: floatBit.width
        height: width
        anchors.centerIn: bitImage
        source: "../assets/gfx/highlight.png"
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
        anchors.verticalCenterOffset: bobOffset

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
            return ""
        }

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
                holdBar.width = floatBit.width
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
                holdBar.width = floatBit.width
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
        anchors.centerIn: bitImage
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
        }

        SequentialAnimation {
            id: flashStart

            onStarted: {
                bitFlash.visible = true
            } //Close onStarted.

            NumberAnimation {
                target: bitFlash
                property: "scale"
                duration: bitFlash.duration / 2
                from: 0
                to: 1
            } //Close NumberAnimation.

            NumberAnimation {
                target: bitFlash
                property: "border.width"
                duration: bitFlash.duration / 2
                from: bitFlash.width / 2
                to: 0
                easing.type: Easing.OutCubic
            } //Close NumberAnimation.

            NumberAnimation {
                target: bitFlash
                property: "scale"
                duration: bitFlash.duration / 2
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
        enabled: parent.enabled
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
        var swap1 = parent.swap1
        var swap2 = parent.swap2

        if (!swap1.used && swap2.bitId !== bitId) {
            swap1.used = true
            swap1.bitId = entityId
            swap1.voidBit = false
            swap1.floatBit = true
            swap1.bitType = bitType
            swap1.bitFlip = bitFlip
            swap1.x = floatBit.x
            swap1.y = floatBit.y
        } else if (!swap2.used && swap1.bitId !== bitId && !swap1.floatBit) {
            swap2.used = true
            swap2.bitId = entityId
            swap2.voidBit = false
            swap2.floatBit = true
            swap2.bitType = bitType
            swap2.bitFlip = bitFlip
            swap2.x = floatBit.x
            swap2.y = floatBit.y
        } else {
            swap2.used = false
            swap2.voidBit = false
            swap2.floatBit = false
            swap1.bitId = entityId
            swap1.voidBit = false
            swap1.floatBit = true
            swap1.bitType = bitType
            swap1.bitFlip = bitFlip
            swap1.x = floatBit.x
            swap1.y = floatBit.y
        }
        if (swap1.used && swap2.used) {
            if (swap1.voidBit || swap2.voidBit) {
                if (swap1.voidBit)
                    if (!swap2.voidBit)
                        parent.swapMode = true
                if (swap2.voidBit)
                    if (!swap1.voidBit)
                        parent.swapMode = true
            } else
                if (swap1.floatBit || swap2.floatBit) {
                    if (swap1.floatBit)
                        if (!swap2.floatBit)
                            parent.swapMode = true
                    if (swap2.floatBit)
                        if (!swap1.floatBit)
                            parent.swapMode = true
                } else parent.swapMode = true
        } else parent.swapMode = false
    }

    function bitChange(newType,newFlip) {
        bitSwap.newType = newType
        bitSwap.newFlip = newFlip
        bitSwap.start()
    }

    function vanish(type,flip) {
        bitVanish.start()
    }

    function drop() {
        row -= 1
        floatDrop.start()
    }

    function flip() {
        bitFlip.start()
    }

    function flash() {
        bitFlash.start()
    }

    function pop() {
        bitPop.start()
    }

} //Close EntityBase 'floatBit'. (Complete)
