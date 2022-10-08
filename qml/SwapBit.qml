import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: swapBit

    entityType: "swapBit"

    width: 40
    height: 40

    z: 10

    visible: used

    property bool used: false
    property bool voidBit: false
    property bool floatBit: false

    property bool bob: false

    property var bitId

    property int bitSize: 32
    property int bitOffset: 0

    property var rowCont
    property int bitType
    property bool bitFlip
    property int bitColumn

    property int dropTime: gameScene.dropTime

    NumberAnimation {
        id: selDrop
        target: swapBit
        property: "y"
        to: target.y + gameScene.bitSize
        duration: dropTime
        easing.type: Easing.InBack
        onStarted: {
            if (target.y + gameScene.bitSize > gameScene.ladderBase)
                selFade.start()
            enabled = false
        }
        onStopped: enabled = true
    }

    //The circle graphic that indicates if a bit is selected. (Complete)
    Item {
        id: bitSelectHL
        anchors.centerIn: parent
        anchors.verticalCenterOffset: bitOffset

        property string color: "white"

        width: bitSize
        height: 8

        Rectangle {
            width: bitSize + 6
            height: width
            anchors.centerIn: parent
            radius: height / 2
            color: "transparent"
            border.color: parent.color
            border.width: 4
        } //Close Rectangle.

        Rectangle {
            width: bitSize + 12
            height: parent.height + 4
            anchors.centerIn: parent
            radius: 4
            color: parent.color
        } //Close Rectangle.

        NumberAnimation {
            target: bitSelectHL
            property: "rotation"
            duration: 1000 * 6 // Math.random() * 9000 + 9000
            from: 0
            to: 180
            loops: Animation.Infinite
            running: true
        } //Close NumberAnimation.

        NumberAnimation {
            id: selFade
            target: bitSelectHL
            property: "opacity"
            from: 1
            to: 0
            duration: gameScene.fadeTime
            running: false
            onStopped: {
                target.opacity = 1
                swapBit.used = false
            }
        }

    } //Close Item.

    function drop() {
        selDrop.start()
    }

} //Close EntityBase 'dnaBit'. (Complete)
